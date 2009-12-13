From: Jan Engelhardt <jengelh@medozas.de>
Date: Sun, 13 Dec 2009 23:08:11 +0000
Subject: fstat seems broken on sparc64
Message-Id: <alpine.LSU.2.01.0912132357090.19051@obet.zrqbmnf.qr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,


I noticed 64-bit tar incorrectly creating symlinks, and isolated this to 
this testcase:

---
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>

int main(void)
{
	struct stat sb;
	int fd = open("foo", O_RDWR | O_CREAT, 0666);

	if (fd < 0)
		abort();
	if (fstat(fd, &sb) < 0)
		abort();
	printf("%lu.%lu\n", sb.st_mtim.tv_sec, sb.st_mtim.tv_nsec);
	if (stat("foo", &sb) < 0)
		abort();
	printf("%lu.%lu\n", sb.st_mtim.tv_sec, sb.st_mtim.tv_nsec);
	if (fstatat(AT_FDCWD, "foo", &sb, 0) < 0)
		abort();
	printf("%lu.%lu\n", sb.st_mtim.tv_sec, sb.st_mtim.tv_nsec);
	return 0;
}
---

Compile with -m64. The problem does not show up with -m32.

Linux ares 2.6.32 #16 SMP Sat Dec 5 21:02:04 CET 2009 sparc64 sparc64 
sparc64 GNU/Linux [sun4v]

This testcase will print, for example:

1260745109.0
1260745109.876573675
1260745109.876573675

So on a quick glance, fstat64 looks broken.
I am trying to look at it further, but I hope you can beat me to it ;-)


Jan
