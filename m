From: Alexey Nezhdanov <snake@penza-gsm.ru>
Date: Fri, 09 Apr 2004 06:37:43 +0000
Subject: Re: Can't boot linux on sun blade 2000
Message-Id: <200404091037.43076.snake@penza-gsm.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <200404071043.30060.snake@penza-gsm.ru>
In-Reply-To: <200404071043.30060.snake@penza-gsm.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

9/04/2004 10:22 David S. Miller wrote:
> On Fri, 9 Apr 2004 08:10:36 +0400
>
> Alexey Nezhdanov <snake@penza-gsm.ru> wrote:
> >  0   pci    33            2  SUNW,Expert3D-Lite (display)  SUNW,375-0116
>
> Yeah, yank this out of the machine and use the
> m64 as your console.
Already tried. Same effect.

> Either that or Ben needs to start building the PROM fb
> console driver into the tree if he isn't already.
> I bet that's why the other distribution's kernel works.
I have not found any kernel that works. I've tried aurora's and sarge's but 
all finally gets to "WARNING: Unable to open initial console" message and 
hangs.

===Offtopic:===
I'm now trying to boot FreeBSD - if I can't boot linux - I can try to stay 
with GNU at least. But have no success of booting from swap partition yet:
I'm doing:
root@STAT # mount
/ on /dev/dsk/c1t1d0s0 
read/write/setuid/intr/largefiles/onerror=panic/dev804
.....
root@STAT # swap -l 
swapfile             dev  swaplo blocks   free
/dev/dsk/c1t1d0s1   118,1      16 2106416 2106416
root@STAT # swap -d /dev/dsk/c1t1d0s1
/dev/dsk/c1t1d0s1 was dump device --
invoking dumpadm(1M) -d swap to select new dump device
dumpadm: no swap devices are available
root@STAT # dd if=miniroot.ufs of=/dev/dsk/c1t1d0s1
root@STAT # init 0
ok boot diskX:Y

but have not found any correct X:Y combination. Every time I'm trying it - it 
boots Solaris complains that can't find root and reboots:

Rebooting with command: boot disk:1                                   
Boot device: /pci@8,600000/SUNW,qlc@4/fp@0,0/disk@1,0:1  File and args: 
SunOS Release 5.8 Version Generic_108528-29 64-bit
Copyright 1983-2003 Sun Microsystems, Inc.  All rights reserved.
Cannot assemble drivers for 
root /pci@8,600000/SUNW,qlc@4/fp@0,0/disk@w500000e01
Cannot mount root 
on /pci@8,600000/SUNW,qlc@4/fp@0,0/disk@w500000e010307b31,0:1s

panic[cpu0]/thread408000: vfs_mountroot: cannot mount root

0000000010407970 genunix:vfs_mountroot+70 (10436800, 0, 0, 104395c8, 10, 14)
  %l0-3: 0000000010436800 0000000010439f20 000000003e000000 0000000010436a28
  %l4-7: 0000000000000000 0000000010413868 00000000000beafd 0000000000000afd
0000000010407a20 genunix:main+8c (104101f0, 2000, 10407ec0, 10408030, fff2, 
100)
  %l0-3: 0000000000000001 0000000000000001 0000000000000015 0000000000000f36
  %l4-7: 0000000010429638 0000000010475c10 00000000000d7438 0000000000000540

skipping system dump - no dump device configured
rebooting...

Can anyone help me in this (offlist probably)?

-- 
Respectfully
Alexey Nezhdanov



