#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <sys/time.h>
#include <sys/times.h>
#include <unistd.h>
#include <sys/un.h>
#include <sys/socket.h>
#include <string.h>
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

    int OPENING_BID = 100;
    int N_ITEMS = 20;
    int MAX_SIZE = 1024;


    int Bids[N_ITEMS];
    int NBids[N_ITEMS];

    int itemIdx = 0;
    int bidPrice = 0;

    for(int i = 0; i < N_ITEMS; i++){
        Bids[i] = OPENING_BID;
        NBids[i] = 0;
    }

    int  n, sock;
    socklen_t serv_len, cli_len;
    struct sockaddr_un serv_addrstr, cli_addrstr;
    int dataAmount = 0;
    sock = socket(PF_UNIX, SOCK_DGRAM, 0);
    serv_addrstr.sun_family = AF_UNIX;
    strcpy(serv_addrstr.sun_path, SERVER_SOCKET);

    unlink(SERVER_SOCKET);
    serv_len = sizeof(serv_addrstr);
    if(bind(sock, (struct sockaddr *) &serv_addrstr, serv_len) == -1){
        perror("BIND ERROR");
        exit(-1);
    }

    printf("Serwer: rozpoczynam obsluge klientow\n");
    char message[MAX_SIZE];
    int finished = -2;
    cli_len = sizeof(cli_addrstr);

    while(1) {
        n=recvfrom(sock, message, sizeof(message), 0, (struct sockaddr *)&cli_addrstr, &cli_len);
        if(n == -1){
            perror("RECVFROM ERROR");
            printf("Klient: wyslane %d, blad odczytu\n", n);
        } else {
            memcpy(&itemIdx, message, sizeof(int));
            memcpy(&bidPrice, message + sizeof(int), sizeof(int));
            if(itemIdx == finished){
                if(finished == -2){
                    printf("(!) koniec pracy servera...(!)\n");
                    break;
                }
            } else {
                NBids[itemIdx]++;
                Bids[itemIdx] += bidPrice;
                dataAmount++;
            }
        }
    }

    close(sock);
    unlink(SERVER_SOCKET);
    long int sum = 0, sum_Bids = 0;
    printf("Results: \n");
    for(int i = 0; i < N_ITEMS; i++) {
        if(NBids[i] != 0){
                sum += Bids[i];
                sum_Bids += NBids[i];
            printf("Item ID: %d | Bids: %d | Price: %d\n", i, NBids[i], Bids[i]);
        }
    }
    printf("suma podbic %d\n",sum_Bids );
    printf("suma cen %d\n",sum);

    gettimeofday(&realTimeEnd, NULL);
    realTimeUsage = ((realTimeEnd.tv_sec - realTimeStart.tv_sec) * 1000000u + realTimeEnd.tv_usec - realTimeStart.tv_usec) / 1.e6;
    val = times(&cpuTimeUsage);
    double tick = (double) sysconf(_SC_CLK_TCK);
    cpuUtime = ((double)(cpuTimeUsage.tms_utime + cpuTimeUsage.tms_cutime))/tick;
    cpuSystime = ((double)(cpuTimeUsage.tms_stime + cpuTimeUsage.tms_cstime))/tick;
    printf("Real Time: %.3fs \nUser Time: %.3fs\n", realTimeUsage, cpuUtime);
    printf("SystemTime: %.3fs\nCPU Time: %.3fs\n", cpuSystime, (cpuUtime+cpuSystime));

}
