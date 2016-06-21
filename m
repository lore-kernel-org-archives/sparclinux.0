From: Meelis Roos <mroos@linux.ee>
Date: Tue, 21 Jun 2016 11:37:17 +0000
Subject: Re: Please upgrade your machines to sparc64
Message-Id: <alpine.LRH.2.20.1606211425370.20966@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <756b931c-35f9-e094-94bf-f12839b61d92@physik.fu-berlin.de>
In-Reply-To: <756b931c-35f9-e094-94bf-f12839b61d92@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> According to to Debian's popularity contest page [1], there are still 82 machines
> reporting to be running Debian's old, unsupported sparc port (32-bit userland,
> 64-bit kernel). Since popcon only reports machines where the users decided to
> opt-in, the number of unreported sparc installations will most certainly be
> higher.

I might have quite a number of machines there :) Most of my sparcs are 
running snapshot of debian sid from Jul 27, 2015, with systemd packages 
slightly earlier (218-something). Getting something newer on them would 
be good...

I have been planning to test the sparc64 port when I get some time, to 
see if it is ready enough to easily upgrade all the machines. From your 
description it seems that it is installable but not ready yet.

>   * when setting up the partitions, create a small (~1 GiB) boot partition
>     which is formatted with ext3 and mounted /boot; this is required for SILO
>     to work reliably and find the installed kernels

I have always wanted to know why? I understanrd there was OBP problem in 
old 32-bit sparc machines that was the reason for this suggestion, but I 
have impression that this is not the case for any sun4u era or later 
OBP.

I have installed most of my sparcs with single root only and never seen 
any problems (OK, my disks usually do not fill up much, most stay under 
10G total - but defintely use more from 1G from the start of the disks 
even for files under /boot).

And silo should support ext4 for years - I have multiple sparcs with 
ext4 root and no /boot and it all still works. Last commit about ext4 in 
silo git was from 2012 so I have the impression that it should work.

Does anyone remember the exact reasons we suggest separate /boot 
partition?

>   * after the machine has reset and is about to boot the installed system,
>     boot the machine with "Linux console=ttyS0,9600,8n1" where "Linux"
>     is the name of the configuration in SILO to be booted (defaults to
>     "Linux" - view available configurations by pressing <TAB>) and
>     console=ttyS0,9600,8n1 configures the serial console which is disabled
>     by default currently (I will look into changing this in the future)

Does <TAB> work in silo for anybody for filename completion?

I reported https://bugs.debian.org/cgi-bin/bugreport.cgi?bug'9480 in 
2004 and I am still seeing the same behaviour as far as I can remember.

-- 
Meelis Roos (mroos@linux.ee)
