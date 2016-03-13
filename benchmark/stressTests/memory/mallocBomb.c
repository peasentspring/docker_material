#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <unistd.h>
#include <errno.h>
#include <limits.h>


int main(int argc,char **argv[])
{

	int count = 0;
        if(argc == 1)
                printf("Usage : ./mallocBomb <[infinite] -i>  or ./mallocBomb <itterations>");
        else
        {
                int i=0,k=0;
		
                if(strcmp((const char *)argv[1],"-i") == 0)
                {
                        while(1)
                        {
//	if(strcmp((const char *)argv[2],"-v") == 0)
//			    {
//				    printf("Itteration count : %d\n",count++);
//			    }
			    
                            if(calloc(1,1024) != NULL)
			    {
				if (k %1000 == 0)
				printf("count is %d", i);
				    if(errno == EAGAIN)
				    {
					    printf("WARNING EAGAIN: Limit on the total number of processes has been reached\n");
				    }
				    else if(errno == ENOMEM)
				    {
					    printf("WARNING ENOMEM: There is not enough swamp space\n");
				    }
				i++;
				k++;
			    }
                        }
                }
                else
                {
                        k =atoi((const char *)argv[1]);

                        for(i=0; i < k; i++)
                        {
			    if(strcmp((const char *)argv[2],"-v") == 0)
			    {
				    printf("Itteration count : %d\n",i+1);
			    }
			    
                            if(calloc(1,1024) != NULL)
			    {
				    if(errno == EAGAIN)
				    {
					    printf("WARNING EAGAIN: Limit on the total number of processes has been reached\n");
				    }
				    else if(errno == ENOMEM)
				    {
					    printf("WARNING ENOMEM: There is not enough swamp space\n");
				    }
			    }
                        }
                }
        }
        return 0;
}
