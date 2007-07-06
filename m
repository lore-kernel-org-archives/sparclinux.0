From: David Miller <davem@davemloft.net>
Date: Fri, 06 Jul 2007 09:33:59 +0000
Subject: Re: [BUG sparc64] 2.6.22-rc broke X on Ultra5
Message-Id: <20070706.023359.07643400.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <18002.44181.639121.720839@alkaid.it.uu.se>
In-Reply-To: <18002.44181.639121.720839@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Thu, 14 Jun 2007 10:13:46 +0200

> Same failure here with xorg-6.8.1 and 2.6.22-rc4 + this patch, unfortunately.
> 
> I've made an Xorg strace log for this kernel, and regular Xorg log files
> for 2.6.21 and this kernel, available in:
> 
> http://user.it.uu.se/~mikpe/linux/to-davem/xorg-log-2.6.22-rc4-davem1
> http://user.it.uu.se/~mikpe/linux/to-davem/Xorg.0.log-2.6.21
> http://user.it.uu.se/~mikpe/linux/to-davem/Xorg.0.log-2.6.22-rc4-davem1

I can see what's going wrong but not why :-)

X is trying to read the PCI_CLASS_REVISION, PCI_REVISION_ID, etc.
for the PCI controller and that's returning '0' in the byte which
should be 0x06 to indicate that it's a PCI host controller.

In fact, in the trace, each final byte is messed up somehow
for 4-byte reads.  I wrote a test program and I cannot reproduce
this weird behavior on my workstation (SB1500) and on every
single system these PCI config space accesses go through:

arch/sparc64/kernel/pci.c:pci_host_bridge_read_pci_cfg()

which returns constant data back, independant of the actual
PCI controller type underneath.

Puzzling eh? :-)

I'm going to fire back up my ultra5 and see if I can reproduce
this there in order to further debug.

What we see in the X server strace log is:

open("/proc/bus/pci/0000:00/00.0", O_RDWR) = 5
lseek(5, 0, SEEK_SET)                   = 0
read(5, "\216\20\0 ", 4)                = 4
lseek(5, 8, SEEK_SET)                   = 8
read(5, "\0\0\0\0", 4)                  = 4

That second read is the problem, from a good trace it is:

open("/proc/bus/pci/0000:00/00.0", O_RDWR) = 5
lseek(5, 0, SEEK_SET)                   = 0
read(5, "\216\20\0\240", 4)             = 4
lseek(5, 8, SEEK_SET)                   = 8
read(5, "\0\0\0\6", 4)                  = 4

Note that "\0\0\0\6" at offset 0x8 as I mentioned above.

I wrote a test program which tries to do exactly that sequence:

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

#include <stdio.h>

int main(void)
{
	unsigned int x0, x8;
	int fd;

	fd = open("/proc/bus/pci/0000:00/00.0", O_RDONLY);
	lseek(fd, 0, SEEK_SET);
	read(fd, &x0, 4);
	lseek(fd, 8, SEEK_SET);
	read(fd, &x8, 4);
	close(fd);

	printf("x0:0x%08x\n", x0);
	printf("x8:0x%08x\n", x8);

	return 0;
}

But that works properly on my SB1500, so I'll try this test program
next on my ultra5.  It should print:

x0:0x8e100080
x8:0x00000006

and an strace of that test program shows good reads:

open("/proc/bus/pci/0000:00/00.0", O_RDONLY) = 3
lseek(3, 0, SEEK_SET)                   = 0
read(3, "\216\20\0\200", 4)             = 4
lseek(3, 8, SEEK_SET)                   = 8
read(3, "\0\0\0\6", 4)                  = 4
close(3)                                = 0
