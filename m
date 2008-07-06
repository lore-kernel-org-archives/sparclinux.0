From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Sun, 06 Jul 2008 22:16:07 +0000
Subject: O_DIRECT produces wrong output on sparc
Message-Id: <20080706221607.GA14571@palantir8>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="W/nzBZO5zC0uMSeA"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Most of the LTP tests on direct IO fail on my sparc32 machines.
I've testing on ext3 and ext2 filesystems, on SS10 and SS20, on 2.6.26-rc6
and on 2.6.21. All these use the esp driver.

I've been able to reproduce the problem with the program attached,
which gives the output in the 2nd attachment. The actual LTP tests re-uses
the same buffer and that output is worse, with old data interleaving the
new buffer contents.

The 2nd attachment shows that 0's have been written wrongly.
Am not sure where to look for the cause of this issue. Is it an empty DIO
that's being written, or partial DMA from an empty page?
Also, could someone try this on a sparc64 please.

As a side note, is there a way to disable direct IO on the architecture?
If I do not use O_DIRECT in the open call the data written is correct.

Cheers,
-- 
Martin

--W/nzBZO5zC0uMSeA
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="diotest.c"

/* */
#include <stdio.h>
#define __USE_XOPEN2K
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#define __USE_GNU
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <errno.h>


#define	BUFSIZE	8192
#define	NBLKS	10

int main(int argc, char *argv[])
{
	int	fd;
	int	i, n;
	char	*buf, *ptr;

	/* Open file */
	if ((fd = open("file", O_DIRECT|/*O_SYNC|*/O_RDWR|O_CREAT, 0666)) < 0) {
		perror("open failed: ");
		exit(-1);
	}

	/* From: Terje Eggestad (terje.eggestad@scali.no)
	 * Date: Sun Dec 16 2001 - 08:57:53 EST
	 *
	 * The problem is that the kernel that don't support O_DIRECT has
	 * erronous handling of the O_DIRECT flag. Meaning they happily accept
	 * it.
	 *
	 * In order to figure out if the running kernel support O_DIRECT you
	 * MUST attempt an unaligned read/write, if it succed the kernel DON'T
	 * support O_DIRECT.
	 *
	 * Martin Habets: man open states for O_DIRECT the buffer must be
	 * aligned to 512 bytes at least.
	 */
	ptr = malloc(16);
	buf = ptr;
	/* Got an aligned buffer? Make it unaligned. */
	if ((((unsigned) buf) & (512-1)) == 0) {
		buf = &ptr[8];
	}

	memset(buf, 1, 8);
	n = write(fd, buf, 8);
	if (n == -1) {
		if (errno != EINVAL) {
			perror("unaligned write");
			goto out;
		}
		printf("unaligned write failed, O_DIRECT is supported.\n");
	} else if (n == 8) { 
		printf("unaligned write suceeded, O_DIRECT is not supported.\n");
		goto out;
	}
	free(ptr);
	lseek(fd, 0, SEEK_SET);

	/* Allocate aligned buffer, Create output file. 
	 */
	n = posix_memalign((void **)&buf, 512, BUFSIZE*NBLKS);
	if (n != 0) {
		perror("posix_memalign() failed:");
		exit(-1);
	}
	for (i = 1; i < NBLKS; i++) {
		memset(&buf[i*BUFSIZE], (i % 256), BUFSIZE);
		n = write(fd, &buf[i*BUFSIZE], BUFSIZE);
		if (n != BUFSIZE) { 
			printf("write failed: %d %s\n", n, strerror(errno));
			break;
		}
/* This does not seem to help
		if (fsync(fd) != 0) {
			printf("sync failed: %s\n", strerror(errno));
			break;
		}
		sleep(1);
*/
	}

out:
	/* Cleanup */
	close(fd);
	free(buf);
	return 0;
}

--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="file.od"

$ od -A x -x file
000000 0101 0101 0101 0101 0101 0101 0101 0101
*
001e00 0000 0000 0000 0000 0000 0000 0000 0000
*
002000 0202 0202 0202 0202 0202 0202 0202 0202
*
003e00 0000 0000 0000 0000 0000 0000 0000 0000
*
003f80 0202 0202 0202 0202 0202 0202 0202 0202
*
004000 0303 0303 0303 0303 0303 0303 0303 0303
*
005e00 0000 0000 0000 0000 0000 0000 0000 0000
*
005fc0 0303 0303 0303 0303 0303 0303 0303 0303
*
006000 0404 0404 0404 0404 0404 0404 0404 0404
*
007e80 0000 0000 0000 0000 0000 0000 0000 0000
*
007f80 0404 0404 0404 0404 0404 0404 0404 0404
*
007fc0 0000 0000 0000 0000 0000 0000 0000 0000
*
008000 0505 0505 0505 0505 0505 0505 0505 0505
*
009e40 0000 0000 0000 0000 0000 0000 0000 0000
*
009e80 0505 0505 0505 0505 0505 0505 0505 0505
*
009f00 0000 0000 0000 0000 0000 0000 0000 0000
*
009f80 0505 0505 0505 0505 0505 0505 0505 0505
*
00a000 0606 0606 0606 0606 0606 0606 0606 0606
*
00be00 0000 0000 0000 0000 0000 0000 0000 0000
*
00c000 0707 0707 0707 0707 0707 0707 0707 0707
*
00de00 0000 0000 0000 0000 0000 0000 0000 0000
*
00de40 0707 0707 0707 0707 0707 0707 0707 0707
*
00de80 0000 0000 0000 0000 0000 0000 0000 0000
*
00dec0 0707 0707 0707 0707 0707 0707 0707 0707
*
00e000 0808 0808 0808 0808 0808 0808 0808 0808
*
010000 0909 0909 0909 0909 0909 0909 0909 0909
*
010e00 0000 0000 0000 0000 0000 0000 0000 0000
*
011600 0909 0909 0909 0909 0909 0909 0909 0909
*
011780 0000 0000 0000 0000 0000 0000 0000 0000
*
011940 0909 0909 0909 0909 0909 0909 0909 0909
*
011a00 0000 0000 0000 0000 0000 0000 0000 0000
*
011a80 0909 0909 0909 0909 0909 0909 0909 0909
*
011b40 0000 0000 0000 0000 0000 0000 0000 0000
*
011b80 0909 0909 0909 0909 0909 0909 0909 0909
*
011c40 0000 0000 0000 0000 0000 0000 0000 0000
*
012000

--W/nzBZO5zC0uMSeA--
