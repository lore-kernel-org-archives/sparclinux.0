From: Dennis Jenkins <dennis.jenkins@sbcglobal.net>
Date: Fri, 04 Mar 2005 14:25:41 +0000
Subject: Re: [PATCH] sparc: fix compile failure ("struct resource" related)
Message-Id: <20050304142541.15941.qmail@web81301.mail.yahoo.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20050301134440.05ae1152.akpm@osdl.org>
In-Reply-To: <20050301134440.05ae1152.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


--- Chris Newport <crn@netunix.com> wrote:
> David S. Miller wrote:
> >>In general, you should not need to have the Sun
> firmware in your
> >>drivers, just upload them to the card and array
> from Solaris and they
> >>will stay there in nvram.
> >
> >Not true if you boot from the SOC/SOCAL disks, OBP
> will load it's
> >own firmware which is very slow and has tons of
> debugging enabled
> >in it.
> >  
> >
> Oook - that is EVIL.
> We really do not want to taint the kernel with Sun's
> FCode.

Well, for me, I boot Linux from a normal SCSI drive
attached to the same SCSI channel as the CDROM drive. 
I want to be able to use the FCAL disks for extra
storage (under /mnt/fcal or whatever).  However, I
also want to boot Solaris from time to time.  Solaris
lives on /dev/dsk/c3t0d0s0, the first FCAL drive in my
box.

I don't want OBP or Solaris blasting the FCAL firmware
 with their own private copies.

If we can't hack the forth code, I'm not opposed to
having the Linux kernel load the microcode.  However,
in the interest of keeping the kernel "pure", can we
recode the device driver to load the firmware from a
disk file and not put the firmware directly into the
kernel?  That way the kernel itself won't have Sun's
crap in it.

I realize that there might be a problem if the
SOCAL/FC4/FCAL/whatever driver is compiled into the
kernel and it inializes BEFORE VFS mounts "/"....  For
me, I use "modprobe" to load "socal.[slk]o" on the
fly, so my root FS is already mounted.  Maybe "initrd"
can help here?


==Dennis Jenkins
