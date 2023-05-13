#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>

#define BUFSIZE 10
FILE *proc_fp;

int main ()
{
char buf[5], bufor[BUFSIZ];
char polecenie[5];
int pid;
int status;

    while (1) {
        printf("Podaj polecenie do wykonania [d,s,x,e,q]:\n");
        fgets(buf, sizeof(buf), stdin);
        sscanf(buf, "%s", polecenie);
       
        
        pid = fork();
        if (pid==0) {
            if (polecenie[0]!='q'){
            printf("Tu potomek pid=%d\n", getpid());

            /* ... wykonanie polecenia potomka ... */

            switch (polecenie[0]) {
            case 'd': 
            printf("Przyjeto polecenie d\n");
            execlp("date", "date", NULL,(char*) 0);
            break; 
            case 's': 
            printf("Przyjeto polecenie s\n"); 
            execlp("sh", "sh", NULL,(char*) 0);
            break;
            case 'x': 
            printf("Przyjeto polecenie x\n"); 
            execlp("xclock", "xclock", "-update", "1", NULL,(char*) 0);
            break;
            case 'e': 
            printf("Przyjeto polecenie e\n");

            /*
            system("x=`zenity --file-selection`;  xedit $x");
            */

            proc_fp = popen("zenity --file-selection", "r");
            while(fgets(bufor, BUFSIZ, proc_fp) !=NULL)
             fputs(bufor, stdout);
            execlp("xedit", "xedit", proc_fp, NULL,(char*) 0);
            pclose(proc_fp);
  
          break;
            default:
            printf("Zly wybor\n");
            continue;
            }
            }
            exit(0); /* obowiazkowe zakonczenie potomka */
        }
        printf("Tu rodzic po utworzeniu potomka.\n");
        /* ... czekanie na potomka terminalowego ... */
        /* ... lub sprzatanie zombie okienkowego ... */
        switch (polecenie[0]) {
		case 'd': 
			waitpid(pid, &status, WNOHANG);
			break;
		case 's': 
			waitpid(pid, &status, WNOHANG);
			break;
		case 'x': 
			break;
		case 'e':
                        break; 		
                case 'q':
                        printf("Zakonczono program\n");
                        return 0;
               default:
                       printf("Zly wybor\n");
                       continue;
        }
    } /* nieskonczona petla rodzica */

}
