#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <sys/time.h>
#include <sys/times.h>
#include <unistd.h>
#include <sys/un.h>
#include <sys/socket.h>
#include <string.h>
#include <sys/wait.h>
#include <time.h>

#define SERVER_SOCKET "/tmp/gniazdko_serwera_259584"


struct tms cpuTimeUsage;
double realTimeUsage;
clock_t val;
double cpuSystime, cpuUtime;

int main() {

srand(time(NULL));

struct timeval realTimeStart, realTimeEnd;
gettimeofday(&realTimeStart, NULL);


int N_ITEMS = 20;
int N_AGENTS = 20;
int OPENING_BID = 100;
int MAX_RAISE = 10;
int BIDDING_ROUNDS = 100000;
int MAX_SIZE = 1024;


int Bids[N_ITEMS];
int NBids[N_ITEMS];

int n, sock, serv_len, cli_len;
struct sockaddr_un serv_addrstr, cli_addrstr;

unlink(CLIENT_SOCKET);
sock = socket(PF_UNIX, SOCK_DGRAM, 0);
cli_addrstr.sun_family = AF_UNIX;
sprintf(cli_addrstr.sun_path, CLIENT_SOCKET, getpid());

cli_len = sizeof(cli_addrstr);
unlink(cli_addrstr.sun_path);
if(bind(sock, (struct sockaddr *)&cli_addrstr, cli_len) == -1) {
        perror("BIND ERROR");
        exit(-1);
}

serv_addrstr.sun_family = AF_UNIX;
strcpy(serv_addrstr.sun_path, SERVER_SOCKET);
serv_len = sizeof(serv_addrstr);

for(int i = 0; i < N_ITEMS; i++) {
        Bids[0] = OPENING_BID;
        NBids[0] = 0;
}

int child[N_AGENTS];
int status;
int itemIdx = 0;
int bidPrice = 1;
char message[MAX_SIZE];
int endValue = -2;
int messagesSent = 0;
for(int k = 0; k < N_AGENTS; k++){
        if((child[k] = fork()) == 0){
                for(int i = 0; i < BIDDING_ROUNDS; i++) {
                        itemIdx  = rand()%(N_ITEMS);
                        bidPrice = rand()%(MAX_RAISE + 1);
                        memcpy(message, &itemIdx, sizeof(int));
                        memcpy(message + sizeof(int), &bidPrice, sizeof(int));
                        sendto(sock, message, 2*sizeof(int), 0, (struct sockaddr *) &serv_addrstr, serv_len);
                messagesSent++;

                if(messagesSent == N_AGENTS*N_ITEMS*BIDDING_ROUNDS) {
                        sendto(sock, &endValue, sizeof(endValue), 0, (struct sockaddr *) &serv_addrstr, serv_len);
                }
                }
                exit(0);
        }
}


for(int i = 0; i < N_AGENTS; i++)  {
        wait(&status);
}
        memcpy(message, &endValue, sizeof(int));
        sendto(sock, message, sizeof(int), 0, (struct sockaddr *) &serv_addrstr, serv_len);
        close(sock);

        gettimeofday(&realTimeEnd, NULL);
        realTimeUsage = ((realTimeEnd.tv_sec - realTimeStart.tv_sec) * 1000000u + realTimeEnd.tv_usec - realTimeStart.tv_usec) / 1.e6;
        val = times(&cpuTimeUsage);
        double tick = (double) sysconf(_SC_CLK_TCK);
        cpuUtime = ((double)(cpuTimeUsage.tms_utime + cpuTimeUsage.tms_cutime))/tick;
        cpuSystime = ((double)(cpuTimeUsage.tms_stime + cpuTimeUsage.tms_cstime))/tick;
        printf("*******************************************\n");
        printf("Realny : %.3fs \nCzas uzytkownika: %.3fs\n", realTimeUsage, cpuUtime);
        printf("systemu: %.3fs\nCalkowity CPU: %.3fs\n", cpuSystime, (cpuUtime+cpuSystime));
}
