#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <time.h>
#include <semaphore.h>
//#include <thread.h>



#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/types.h>
#include <sys/times.h>
#include <sys/wait.h>
#include <sys/time.h>

#define N_AGENTS 20
#define N_ITEMS 20
#define OPENING_BID 100
#define MAX_RAISE 10
#define BIDDING_ROUNDS 1000000


#define SHM_ID  259550 
#define MEM_SIZE  4096

static clock_t st_time;
static clock_t en_time;
static struct tms st_cpu;
static struct tms en_cpu;

void start_clock()
{
        st_time = times(&st_cpu);
}

void end_clock()
{
        en_time = times(&en_cpu);

        float RTC_TIME =  (float)(en_time - st_time)/(float)sysconf(_SC_CLK_TCK);
        float CPU_TIME =  (float)(en_cpu.tms_utime + en_cpu.tms_cutime)/(float)sysconf(_SC_CLK_TCK);
        float CPU_SYSTEM = (float)(en_cpu.tms_stime + en_cpu.tms_cstime)/(float)sysconf(_SC_CLK_TCK);


        printf("Czas RTC: %.3f s\nCzas CPU USER %.3f s\nCzas CPU SYSTEM: %.3f s\n",RTC_TIME,CPU_TIME,CPU_SYSTEM);

}






struct common_struct {
        int  Bids[N_ITEMS];
        int Nbids[N_ITEMS];
        sema_t  sem_BIDS[N_ITEMS];
        sema_t  sem_NBIDS[N_ITEMS];
};




int main(int argc , char *argv[]) 
{
         int *Bids , *NBids;
        void *common_memory = (void *)0;
        struct common_struct *common;
        int shmid;
        int i, j, k;
        int ret1,ret2;
        long int sum = 0, sum_Bids = 0; 
        srand((unsigned int)getpid());
        int f;
        key_t shmkey = ftok("/home/hkowalcz/ezi_unix/lab_6_programy/licytuj1.c",6);
        shmid = shmget(shmkey , MEM_SIZE, 0666 | IPC_CREAT);


        if (shmid == -1) 
        {
                exit(1);
        }


        common = (struct common_struct *) shmat(shmid, (void *)0,0);
        if (common == (void *)-1)
        {       
        exit(2);
        }
        
        
        Bids = common -> Bids;
        NBids = common -> Nbids;
        for (int a = 0; a < N_ITEMS; a++)
        {
        sema_init(&(common->sem_BIDS[a]),BIDDING_ROUNDS,USYNC_PROCESS,0);
        sema_init(&(common->sem_NBIDS[a]),BIDDING_ROUNDS,USYNC_PROCESS,0);
        }
        if (ret1 < 0 || ret2 < 0){
        exit(3);
        }

        
        for (int i = 0; i < N_ITEMS; i++)
        {
                Bids[i] = OPENING_BID;
                NBids[i] = 0;
        }

        start_clock();  

        for (int l = 0; l < N_AGENTS; l++)
        {
                
                if (fork() == 0)
                {
                        for (j = 0; j < BIDDING_ROUNDS; j ++)
                        {
                                int  N = rand() %  N_ITEMS ;
                                sema_wait(&(common->sem_BIDS[N]));
                                int  R = rand() % (MAX_RAISE + 1);
                                sema_wait(&(common->sem_NBIDS[N]));
                                Bids[N] = Bids[N] + R;
                                NBids[N] = NBids[N] + 1 ;
                                sema_post(&(common->sem_BIDS[N]));
                                sema_post(&(common->sem_NBIDS[N]));

                        }
                        
                        exit(4);
                }
        }
        
        while(waitpid(-1,NULL,0) > 0);
        for (int i = 0 ; i < N_ITEMS; i++)
        {
                sema_destroy(&(common->sem_BIDS[i]));
                sema_destroy(&(common->sem_NBIDS[i]));
        }


        end_clock();
        for (int k = 0; k < N_ITEMS; k++)
        {       
                sum += Bids[k];
                sum_Bids += NBids[k]; 
                printf("Wartosc przedmiotu nr %d wynosi %d liczba podbic tego przedmiotu wynosi %d \n", k,Bids[k],NBids[k]);
        }
 
        printf("suma wartosci przedmitow wynosi: %d\n",sum);
        printf("suma podbic wszystkich uzytkownikow wynosi %d\n",sum_Bids );
//      for (int i = 0 ; i < N_ITEMS; i++)
//      {
//      sema_destroy(&(common->sem_BIDS[i]));
//      sema_destroy(&(common->sem_NBIDS[i]));
//      }


        return 0;
}
