From: Alexey Nezhdanov <snake@penza-gsm.ru>
Date: Thu, 08 Apr 2004 12:29:59 +0000
Subject: Re: Can't boot linux on sun blade 2000
Message-Id: <200404081629.59880.snake@penza-gsm.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <200404071043.30060.snake@penza-gsm.ru>
In-Reply-To: <200404071043.30060.snake@penza-gsm.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I think that my mails were dropped due to 8-bit symbols in them.
Re-posting my answers:
==1st mail===================I have another question - since problem is very tough I can try installation 
with more recent (2.6.5) kernel. But I have to recompile it myself - so - can 
you give me some tips about this process or give some links to already 
compiled kernels?
==2nd mail================> > kbd_init: Assuming USB keyboard.
> >
> > usb.c: registered new driver usbdevfs
> > usb.c: registered new driver hub
> > host/usb-uhci.c: $Revision: 1.275 $ time 15:49:35 Nov 29 2003
> > host/usb-uhci.c: High bandwidth mode enabled
> > host/usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
> > host/usb-ohci.c: USB OHCI at membase 0x7fe01000000, IRQ 9,21f
> > host/usb-ohci.c: usb-00:05.3, PCI device 108e:1103
> > usb.c: new USB bus registered, assigned bus number 1
> > hub.c: USB hub found
> > hub.c: 4 ports detected
> > usb.c: registered new driver hid
> > hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
> > hid-core.c: USB HID support drivers
>
> Is it a USB keyboard? If it is, it isn't getting detected.
I'm starting using serial port connection with keyboard and mouse unplugged. 
Monitor stays black all the time of booting. If I'm switching to console then 
the result is same less that I can't do logging in this case.
==3rd mail=================
> On Tue, Apr 06, 2004 at 11:53:59PM -0700, Joshua Kwan wrote:
> > On Wed, Apr 07, 2004 at 10:43:30AM +0400, Alexey Nezhdanov wrote:
> > > <TFTP COUNTER (booting
> > > http://www.phunnypharm.org/pub/for/sparc-folks/disks-sparc/current/spar
> > >c64/tftpboot.img image)>
> >
> > You should really be using the Sarge tftboot images.
> > http://people.debian.org/~jbailey/d-i/sparc/daily/sparc64/netboot/boot.im
> >g
These sarge tftp boot images producing exactly the same effect.
> No, he shouldn't those images aren't tested very well. My woody images
> are.
Woody images do not boot *at*all*. Instead they produce junk and trash on the 
screen resulting either in "memory address not aligned" or "fast data MMU 
miss" error and hard hang. BTW sarge's cdrom boot also does this weird error.

> > > devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
> > > devfs: boot_options: 0x0
> >
> > This is the cause of all your problems.
> >
> > > VFS: Mounted root (ext2 filesystem).
> > > Warning: unable to open an initial console.
> >
> > Pass devfs=mount on the command line and it should Just Work.
> > Note that this crude hack isn't required in the latest images.
>
> That shouldn't matter with the image he is using.
Sadly, but yes.
==4th mail========================> Hi Alexey,
>
> I can't help you with the debian boot images but I have a version of Linux
> working just fine on my SunBlade 2000 (4GB RAM, 2*900 Mhz US-III+):
>
> [root@silvanost root]# uname -a
> Linux silvanost SMP Wed Sep 24 14:26:17 EDT 2003 sparc64 unknown
>
> [root@silvanost root]# cat /proc/cpuinfo
> cpu             : TI UltraSparc III+ (Cheetah+)
> fpu             : UltraSparc III+ integrated FPU
> promlib         : Version 3 Revision 10
> prom            : 4.10.11
> type            : sun4u
> ncpus probed    : 2
> ncpus active    : 2
> Cpu0Bogo        : 599.65
> Cpu0ClkTck      : 0000000035a4e900
> Cpu1Bogo        : 599.65
> Cpu1ClkTck      : 0000000035a4e900
> MMU Type        : Cheetah+
> State:
> CPU0:           online
> CPU1:           online
>
> The OS is Aurora 1.0 and the boot images were taken from the build-1.0
> directories. Although I have not used a TFTP install (I have a DVD-ROM in
> the machine), I know that the tftp64.img boot image works fine for me
> (grab a copy if you wish at:
> ftp://auroralinux.org/pub/aurora/build-1.0/en/os/sparc/images )
Unfortunately this image do not work as well (again "initial console not 
found").
>
> The differences I could spot between your attempts and my install are as
> follows:
> - You're using an old OBP (look for free patch 111292-16 on sunsolve).
Yeah I've seen several references that this problem sometimes get fixed with 
OBP update. But since I'm completely newbie in Sun tech I was moderately 
feared such way and choosed to try all less destructive ways before (If I 
will thrash OBP the system most brobably become unbootable and I will get a 
*very* serious troubles on my work). But now I think this is the only way 
that I can try. I will report here about of my [un]success.
>
> - The fact you're using OBP 4.5 coupled with the fact you have only 1GB
> RAM in your machine makes me think that perhaps you have the older (i.e:
> Non-CU) 750Mhz or 900Mhz US-III cpus. I don't know if that could make a
> difference..
>
> - Also, I installed Aurora using the 1.0 build ISO's whereas you're
> oviously netbooting your machine (can't know if that makes a difference in
> this case...). At any case, I installed Aurora using a serial port, just
> like you (the Aurora kernels didnd't like my console, always resulting in
> a 'Fast data accesss MMU miss' when booting).
Aurora ISO image weights ~700M and I can download such volume in a long term 
only but not now.
>
> Can't be of much help, here... I hope you get it working.
>
> Cheers,
>
> Vincent
>
> On Wed, 7 Apr 2004, Alexey Nezhdanov wrote:
> > Hello. I've already asked my question on debian-sparc and debian boot
> > maillists and got a lot of help but still can't solve the problem
> > entirely. The problem is (slightly edited minicom log):
> > =================
> > Resetting ...
> >
> >  TTYA not found.
> > TTYA not found.
> >
> > SUNW,Sun-Blade-1000 (UltraSPARC-III+) , Keyboard Present
> > Copyright 1998-2002 Sun Microsystems, Inc.  All rights reserved.
> > OpenBoot 4.5, 1024 MB memory installed, Serial #53064360.
> > Ethernet address 0:3:ba:29:b2:a8, Host ID: 8329b2a8.
===========================

Resume:
I've upgraded my OBP and POST to yesterday's version:
OBP 4.13.0 2004/01/19 18:27
POST 4.13.0 2004/03/15 19:13

Vincent pointed me that I have two video cards in my box and I removed one.
I've already tried to boot d-i beta3 cdrom, d-i beta3 tftp image d-i daily 
image (by 07.04.2004), aurora tftp64 image, woody tftp image and image from 
phunnypharm - all without success either with console boot or serial port 
connection boot.

Now I'm getting strong opinion that my box have some unusual hardware that 
kernel doesn't know about and searching for 2.6 tftp (preferrably) or small 
cdrom image. If you know about one - please send me a note about it.

I can provide additional information on request.

Thanks for your help.

-- 
Respectfully
Alexey Nezhdanov



