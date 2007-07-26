From: Mikael Pettersson <mikpe@it.uu.se>
Date: Thu, 26 Jul 2007 10:21:29 +0000
Subject: Re: [BUG sparc64] 2.6.22-rc broke X on Ultra5
Message-Id: <200707261021.l6QALTpq026128@harpo.it.uu.se>
List-Id: <sparclinux.vger.kernel.org>
References: <18002.44181.639121.720839@alkaid.it.uu.se>
In-Reply-To: <18002.44181.639121.720839@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 25 Jul 2007 23:35:50 -0700 (PDT), David Miller wrote:
> Ok, I'm still hunting this down.
> 
> I would not have believed the behavior handled in the patch
> below unless I saw it firsthand myself.  Aparently the
> UltraSparc-IIi and UltraSparc-IIe host controllers will only
> return correct values in the host controller PCI space if you
> access them at their natural size.  So f.e. accessing two
> sequential 16-bit objects as a 32-bit word doesn't work.
> 
> Anyways, my test program passes with the patch below, please
> give it a spin with your X problems...  it's against 2.6.23-rc1
> but should apply with only minor line offsets to 2.6.22
> 
> Thanks.
> 
> commit cff2c41772272f70524486f99991d0102dee0640
> Author: David S. Miller <davem@sunset.davemloft.net>
> Date:   Wed Jul 25 23:30:16 2007 -0700
> 
>     [SPARC64]: Fix sun4u PCI config space accesses on sun4u.
>     
>     Don't provide fake PCI config space for sun4u.
>     
>     Also, put back the funny host controller space handling that
>     at least Sabre needs.  You have to read PCI host controller
>     registers at their nature size otherwise you get zeros instead
>     of correct values.

With this patch X seems a bit happier: it finds the PCI stuff
and doesn't complain about broken resources like before. But it
fails to access the host bridge due to an "inappropriate ioctl":

write(0, "(II) Primary Device is: PCI 01:0"..., 36) = 36
write(0, "(II) ATI:  Candidate \"Device\" se"..., 52) = 52
lseek(5, 64, SEEK_SET)                  = 64
read(5, "\10\0\0\0", 4)                 = 4
close(5)                                = 0
stat64("/proc/bus/pci/00", 0xfffcb330)  = -1 ENOENT (No such file or directory)
open("/proc/bus/pci/0000:00/00.0", O_RDWR) = 5
ioctl(5, IIOCNETDIF, 0)                 = -1 ENOTTY (Inappropriate ioctl for device)

strace lists that ioctl as IIOCNETDIF [_IO('I',2)], but that's an isdn ioctl,
so I assume it's some X- or sparc-specific thing with the same representation.

I rebooted into 2.6.21 and in that kernel X issues IIOCNETDIF, IIOCNETSCF,
IIOCNETAIF, and a bunch of 0x50434900 ioctls on the host bridge, and they
all succeed, whereas with 2.6.23-rc1 they all get ENOTTY.

I've uploaded Xorg, kernel, and strace logs for 2.6.23-rc1 + your patch
to <http://user.it.uu.se/~mikpe/linux/to-davem/>, in case you can find
something interesting there.

BTW, with this patch your test program now prints

x0:0x8e1000a0
x8:0x00000006

i.e., bit 5 of x0 is now set for some reason.

/Mikael
