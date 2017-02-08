/*  vulp.c  */

#include <stdio.h>
#include <unistd.h>
#include <string.h>

int main()
{
	// Target File
	char * fn = "/tmp/std1";
	char buffer[60];
	FILE *fp;

	/* get user input */
	// Read from passwd_input or shadow_input file
	scanf("%50s", buffer );
	if(!access(fn, W_OK)){

		fp = fopen(fn, "a+");
		//Add a new user to the file if access is gianed
		fwrite("\n", sizeof(char), 1, fp); 
		fwrite(buffer, sizeof(char), strlen(buffer), fp);
		fclose(fp);
		printf("Done!\n");
	}
	else printf("No permission \n");
}
