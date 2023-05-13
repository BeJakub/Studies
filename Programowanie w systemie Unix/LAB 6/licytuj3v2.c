#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/wait.h>

#define OPENING_BID 100 // poczatkowa cena przedmiotu
#define MAX_RAISE 10 // maksymalna warto§é podbicia licytacji
#define BIDDING_ROUNDS 1000000 // liczba rund licytacji
#define ITEMS 20 // liczba przedmiotów licytacji
#define N_AGENTS 20 // liczba agent�ow
// struktura zawierajaca tablice wyników licytacji
struct BidsAndBids {
    long int Bids [ITEMS];
    int NBids [ITEMS];
};

int main(void) {
        // inicjalizacja generatora liczb pseudolosowych za pomoca numeru biezacego procesu
    srand(getpid());
    // utworzenie obszaru pamieci wspólnej o odpowiednim rozmiarze
    int shmid = shmget(IPC_PRIVATE, sizeof(struct BidsAndBids), IPC_CREAT | 0666);
    if (shmid < 0) {
        //perror("shmget");
        return 1;
    }
    // odwzorowanie obszaru pamieci wspólnej do przestrzeni adresowej procesu
    struct BidsAndBids *bids_and_bids = shmat(shmid, NULL, 0);
    // if (bids_and_nbids == (void *)-1) {
        //perror("shmat");
        // return 1;
    // }
    // inicializacia tablicy cen przedmiotów oraz tablicy liczników podbié
    for (int i = 0; i < ITEMS; i++) {
        bids_and_bids->Bids[i] = OPENING_BID;
        bids_and_bids->NBids[i] = 0;
    }
    int sumOfBids = 0;
    // przeprowadzenie zadanej liczby rund licytaci
    for(int l=0; l < N_AGENTS; l++) {
        if(fork() == 0) {
        for (int i = 0; i < BIDDING_ROUNDS; i++) {
            sumOfBids = i + 1;
            // wybór losowego przedmiootulicytacji
            int item = rand() % ITEMS;
            // generowanie losowej wartosci podbicia licytacji
            int raise = rand() % (MAX_RAISE + 1);
            // zwiekszenie ceny wybranego przedmiotu o podbicie
            bids_and_bids->Bids[item] += raise;
            }
        exit(0);
        }
    }

    for(int i=0;i<N_AGENTS; i++) {
        wait(NULL);
    }

    long int sum = 0;
    for (int i = 0; i < ITEMS; i ++) {
        printf("Cena koncowa: %ld \n", bids_and_bids->Bids[i]);
        sum += bids_and_bids->Bids[i];
    }
    printf("Suma cen: %.2ld \n", sum);
    return 0;
}
