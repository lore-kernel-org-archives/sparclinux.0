From: Bob Picco <bob.picco@oracle.com>
Date: Tue, 09 Sep 2014 21:12:27 +0000
Subject: Re: [PATCH] sparc64: sun4v TLB error power off events
Message-Id: <20140909211227.GO24131@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <1410104858-22046-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410104858-22046-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:	[Tue Sep 09 2014, 03:22:37PM EDT]
> From: Bob Picco <bpicco@meloft.net>
> Date: Sun,  7 Sep 2014 11:47:38 -0400
> 
> > We've witnessed a few TLB events causing the machine to power off because
> > of prom_halt. In one case it was some nfs related area during rmmod. Another
> > was an mmapper of /dev/mem. A more recent one is an ITLB issue with
> > a bad pagesize which could be a hardware bug. Bugs happen but we should
> > attempt to not power off the machine and/or hang it when possible.
> 
> prom_halt() should not power off the machine, but rather drop us to
> the OF command line "ok" prompt.
I didn't know this. This would be ideal.

For my nearly P0 T4-2 it always powers off.
> 
> Why doesn't it do that?
Don't know.
> 
> We properly do a >tl1 vs. tl1 etrap call, so we should be at trap
> level zero when we call into the prom to "exit".
I agree.

I just ran a quick experiment on my T5-2 which is supported hardware. The
kernel is 3.17-rc3 without any modification from me - well ixgbe. As root mmap
of /dev/mem at address 0UL. It powered off:
4 GNU/Linux
[root@t5-2 ~]# [31732.360547] SUN4V-DTLB: Error at TPC[fffffc01001cac48], tl 1
[31732.371659] SUN4V-DTLB: TPC<0xfffffc01001cac48>
[31732.380652] SUN4V-DTLB: O7[100970]
[31732.387418] SUN4V-DTLB: O7<0x100970>
[31732.394548] SUN4V-DTLB: vaddr[fffffc0100028000] ctx[1634] pte[9a00000000000610] error[2]

Message from syslogd@t5-2 at Sep  9 16:53:25 ...
 kernel:[31732.360547] SUN4V-DTLB: Error at TPC[fffffc01001cac48], tl 1

Message from syslogd@t5-2 at Sep  9 16:53:25 ...
 kernel:[31732.371659] SUN4V-DTLB: TPC<0xfffffc01001cac48>

Message from syslogd@t5-2 at Sep  9 16:53:25 ...
 kernel:[31732.380652] SUN4V-DTLB: O7[102014-09-09 20:35:34     SP> NOTICE:  Host is off
. Some firmware widget we are unaware of?

Should you like the code it is below.

thanx,

bob

<<CLIP HERE>>

#define _GNU_SOURCE
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <fcntl.h>

#define PGSIZE (8192)

void main(int argc, char **argv)
{
	unsigned long addr;
	char buf[PGSIZE];
	void *mmap_addr;
	ssize_t size;
	off_t offset;
	int rc, fd;

	if (argc != 2)
		fprintf(stderr, "%s: 0xaddress\n", argv[0]), exit(1);

	rc = sscanf(argv[1], "%lx", &addr);
	if (rc != 1)
		fprintf(stderr, "%s: address-format-invalid\n", argv[0]),
			exit(1);

	fd = open("/dev/mem", O_RDONLY);
	if (fd < 0)
		fprintf(stderr, "%s: failed to open /dev/mem\n", argv[0]),
			exit(1);

	offset = addr;
	size = PGSIZE;
	mmap_addr = mmap(NULL, size, PROT_READ, MAP_SHARED, fd, offset);

	if (mmap_addr = MAP_FAILED)
		fprintf(stderr, "%s: failed mmap offset=0x%lx\n", argv[0],
			offset), exit(1);

	memcpy(buf, mmap_addr, sizeof (buf));

	(void) munmap(mmap_addr, size);
	close(fd);
}

