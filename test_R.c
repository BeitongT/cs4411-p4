#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <time.h>

int main(int argc, char* argv[]) {

	int MAXTIME = strtol(argv[1], NULL, 10); 
	int FILESIZE = strtol(argv[2], NULL, 10);
	int i, start, lengthMax, length, count;
	char buffer[20]; 
	srand(time(NULL));

	int fd = open("trace_R.txt",O_RDWR | O_CREAT, 0644);

	for (i = 0; i < FILESIZE; i++) {
		sprintf(buffer,"W:0:%d\n", i);
		write(fd, buffer, strlen(buffer));
	}
	for (i = 0; i < FILESIZE; i++) {
		sprintf(buffer,"W:64:%d\n", i);
		write(fd, buffer, strlen(buffer));
	}
	count = MAXTIME;
	while (count--) {
		start = rand()%FILESIZE;
		sprintf(buffer,"R:0:%d\n", start);
		write(fd, buffer, strlen(buffer));
	}

	close(fd);
	return 0;
}
