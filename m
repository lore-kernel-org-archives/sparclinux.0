From: David Miller <davem@davemloft.net>
Date: Fri, 27 Jul 2007 01:23:55 +0000
Subject: Re: [BUG sparc64] 2.6.22-rc broke X on Ultra5
Message-Id: <20070726.182355.15268786.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <18002.44181.639121.720839@alkaid.it.uu.se>
In-Reply-To: <18002.44181.639121.720839@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Thu, 26 Jul 2007 12:21:29 +0200 (MEST)

> strace lists that ioctl as IIOCNETDIF [_IO('I',2)], but that's an isdn ioctl,
> so I assume it's some X- or sparc-specific thing with the same representation.
 ...
> open("/proc/bus/pci/0000:00/00.0", O_RDWR) = 5
> ioctl(5, IIOCNETDIF, 0)                 = -1 ENOTTY (Inappropriate ioctl for device)

I think strace is mis-decoding 0x50434902 and 0x50434903 into those
ISDN ioctls for some reason, when in reality they are
PCIIOC_MMAP_IS_MEM and PCIIOC_WRITE_COMBINE.

If it really is passing those ISDN ioctls you'd get messages in
your kernel log from the compat ioctl() layer warning about that.

I doubt that's happening because I see them in the strace of Xorg on
my ultra5, although my X server doesn't attempt to use those ioctls
on the PCI controller, it only does them on the ATI graphics card
device.

Let's see why that might fail.

The open is successful, so the file is definitely registered and
there for the PCI controller.

But we can get that -ENOTTY if the ioctl handler is NULL for the file.

I enhanced my test program to run the same sequence X is, and the
ioctls do not fail on my ultra5, can you run the program below on
your's?

Thanks.

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

#include <stdio.h>

#include <errno.h>

#include <linux/pci.h>

int main(void)
{
	unsigned int x0, x8;
	int fd, err;

	fd = open("/proc/bus/pci/0000:00/00.0", O_RDWR);
	lseek(fd, 0, SEEK_SET);
	read(fd, &x0, 4);
	lseek(fd, 8, SEEK_SET);
	read(fd, &x8, 4);

	printf("x0:0x%08x\n", x0);
	printf("x8:0x%08x\n", x8);

	err = ioctl(fd, PCIIOC_MMAP_IS_MEM, 0);
	printf("PCIIOC_MMAP_IS_MEM: err=%d, errno=%d\n",
	       err, errno);

	err = ioctl(fd, PCIIOC_WRITE_COMBINE, 1);
	printf("PCIIOC_MMAP_WRITE_COMBINE: err=%d, errno=%d\n",
	       err, errno);

	close(fd);

	return 0;
}
