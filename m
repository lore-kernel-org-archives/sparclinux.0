From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Sat, 04 Dec 2004 23:16:41 +0000
Subject: Re: mmap breakage
Message-Id: <1102202201.15654.111.camel@duncow>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-ZKYRirAGop/74JRb/X1p"
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0412032354010.1963@bobcat>
In-Reply-To: <Pine.LNX.4.61.0412032354010.1963@bobcat>
To: sparclinux@vger.kernel.org


--=-ZKYRirAGop/74JRb/X1p
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

FWIW. I forgot to attach the program that demonstrates the behaviour.

Richard

On Sat, 2004-12-04 at 23:13, Richard Mortimer wrote:
> On Sat, 2004-12-04 at 05:22, Jurij Smakov wrote:

> Well I can demonstrate the behaviour (see attached test program) on sparc64 and i386. It allows mappings to be fully or partially replaced and even allows you to replace bits in the middle of a mapping.


> P.S. You can see the overwriting of mappings if you look at
> /proc/<pid>/maps. You will see that the second mapping has totally
> superceded the first and the third mapping has split the second one up.
> 
> 01000000-01002000 rw-p 00000000 00:0b 8               /dev/zero
> 01002000-01004000 rw-p 00000000 03:02 863336          /var/log/messages
> 01004000-01020000 rw-p 00004000 00:0b 8               /dev/zero
-- 
richm@oldelvet.org.uk

--=-ZKYRirAGop/74JRb/X1p
Content-Disposition: attachment; filename=mmaptest2.c
Content-Type: text/x-csrc; name=mmaptest2.c; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/mman.h>

int main()
{
	char *addr1;
	char *addr2;
	char *addr3;
	int fd1;
	int fd2;
	int fd3;
	fd1 = open("/var/log/syslog", O_RDONLY);
	fd2 = open("/dev/zero", O_RDWR);
	fd3 = open("/var/log/messages", O_RDONLY);
	addr1 = mmap((void*)0x1000000, 0x2000, PROT_READ, MAP_PRIVATE|MAP_FIXED, fd1,0);
	addr2 = mmap((void*)0x1000000, 0x20000, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, fd2,0);
	addr3 = mmap((void*)0x1002000, 0x2000, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, fd3,0);
	printf("addr1 is %p\n", addr1);
	printf("addr2 is %p\n", addr2);
	printf("addr3 is %p\n", addr3);

	sleep(100);
	return 0;
}

--=-ZKYRirAGop/74JRb/X1p--

