From: Vincent Cojot <coyote@step.polymtl.ca>
Date: Wed, 07 Apr 2004 21:03:28 +0000
Subject: Re: Can't boot linux on sun blade 2000
Message-Id: <Pine.GSO.4.58.0404071650190.24861@step.polymtl.ca>
List-Id: <sparclinux.vger.kernel.org>
References: <200404071043.30060.snake@penza-gsm.ru>
In-Reply-To: <200404071043.30060.snake@penza-gsm.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Hi Alexey,

I can't help you with the debian boot images but I have a version of Linux
working just fine on my SunBlade 2000 (4GB RAM, 2*900 Mhz US-III+):

[root@silvanost root]# uname -a
Linux silvanost SMP Wed Sep 24 14:26:17 EDT 2003 sparc64 unknown

[root@silvanost root]# cat /proc/cpuinfo
cpu             : TI UltraSparc III+ (Cheetah+)
fpu             : UltraSparc III+ integrated FPU
promlib         : Version 3 Revision 10
prom            : 4.10.11
type            : sun4u
ncpus probed    : 2
ncpus active    : 2
Cpu0Bogo        : 599.65
Cpu0ClkTck      : 0000000035a4e900
Cpu1Bogo        : 599.65
Cpu1ClkTck      : 0000000035a4e900
MMU Type        : Cheetah+
State:
CPU0:           online
CPU1:           online

The OS is Aurora 1.0 and the boot images were taken from the build-1.0
directories. Although I have not used a TFTP install (I have a DVD-ROM in
the machine), I know that the tftp64.img boot image works fine for me
(grab a copy if you wish at: ftp://auroralinux.org/pub/aurora/build-1.0/en/os/sparc/images )

The differences I could spot between your attempts and my install are as
follows:
- You're using an old OBP (look for free patch 111292-16 on sunsolve).

- The fact you're using OBP 4.5 coupled with the fact you have only 1GB
RAM in your machine makes me think that perhaps you have the older (i.e:
Non-CU) 750Mhz or 900Mhz US-III cpus. I don't know if that could make a
difference..

- Also, I installed Aurora using the 1.0 build ISO's whereas you're
oviously netbooting your machine (can't know if that makes a difference in
this case...). At any case, I installed Aurora using a serial port, just
like you (the Aurora kernels didnd't like my console, always resulting in
a 'Fast data accesss MMU miss' when booting).

Can't be of much help, here... I hope you get it working.

Cheers,

Vincent

On Wed, 7 Apr 2004, Alexey Nezhdanov wrote:

> Hello. I've already asked my question on debian-sparc and debian boot
> maillists and got a lot of help but still can't solve the problem entirely.
> The problem is (slightly edited minicom log):
> =================
> Resetting ...
>
>  TTYA not found.
> TTYA not found.
>
> SUNW,Sun-Blade-1000 (UltraSPARC-III+) , Keyboard Present
> Copyright 1998-2002 Sun Microsystems, Inc.  All rights reserved.
> OpenBoot 4.5, 1024 MB memory installed, Serial #53064360.
> Ethernet address 0:3:ba:29:b2:a8, Host ID: 8329b2a8.
>
