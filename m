From: Meelis Roos <mroos@linux.ee>
Date: Thu, 26 Sep 2013 12:12:44 +0000
Subject: Re: SILO always tells it loaded kernel version 3.6.0
Message-Id: <alpine.SOC.1.00.1309261347030.11084@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1309260234380.22367@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1309260234380.22367@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> > Just a curious thing I noticed: in the past, SILO told what version of 
> > kernel it loaded. Nowadays with newer kernels, it always tells
> > Loaded kernel version 3.6.0
> > asi it would be stuck in 3.6.0. Is it something silo does strangely or 
> > do we put bad magic number into kernel image nowadays?
> 
> Works fine here:
> 
> SILO Version 1.4.14
> boot: linux.311
> Allocated 64 Megs of memory at 0x40000000 for kernel
> Loaded kernel version 3.11.0

Strange. Of my online machines, U1 and T2000 give correct kernel number, 
while U2, U10, E450, E220R, Netra X1, Fire V100, Fire V210 give wrong. 
Of them, most are at 3.6.0 and E450 is at 3.4.0. All are running Debian 
unstable and updating after each new kernel is booted up.

Some correlation with PROM version - 3.35 OK, 4.30.4.d all older and 
inbetween ones are wrong (including 4.30.4.a). Probably not the factor.


On E450:

Rebooting with command: boot                                          
Boot device: disk  File and args: 
SILO Version 1.4.14
boot: test
Allocated 64 Megs of memory at 0x40000000 for kernel
Uncompressing image...
Loaded kernel version 3.4.0

[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 3.30.0 2003/11/11 10:41'
[    0.000000] PROMLIB: Root node compatible: sun4u
[    0.000000] Linux version 3.12.0-rc2-00083-g4b97280 (mroos@karusmari) (gcc version 4.6.4 (Debian 4.6.4-4) ) #23 SMP Thu Sep 26 12:37:37 EEST 2013


On U1:

Boot device: disk  File and args:
SILO Version 1.4.14
boot:
Allocated 64 Megs of memory at 0x40000000 for kernel
Uncompressing image...
Loaded kernel version 3.12.0

[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 3.35.0 2004/04/19 12:15'
[    0.000000] PROMLIB: Root node compatible: 
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.12.0-rc2 (mroos@melon) (gcc version 4.6.4 (Debian 4.6.4-4) ) #20 Tue3

On U10:

ok boot
Boot device: scsidisk  File and args: 
SILO Version 1.4.14
boot: test
Allocated 64 Megs of memory at 0x40000000 for kernel
Uncompressing image...
Loaded kernel version 3.6.0

PROMLIB: Sun IEEE Boot Prom 'OBP 3.31.0 2001/07/25 20:36'
PROMLIB: Root node compatible: 
Initializing cgroup subsys cpu
Linux version 3.11.0-dirty (mroos@u10) (gcc version 4.6.4 (Debian 4.6.4-4) ) #47 Wed Sep 25 16:01:09 EEST 2013

Netra X1:

Boot device: disk  File and args:                                     
SILO Version 1.4.14
boot: 
Allocated 64 Megs of memory at 0x40000000 for kernel
Uncompressing image...
Loaded kernel version 3.6.0

[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.0.9 2001/05/17 21:52'
[    0.000000] PROMLIB: Root node compatible: sun4u
[    0.000000] Linux version 3.12.0-rc2 (mroos@deegu) (gcc version 4.6.4 (Debian 4.6.4-4) ) #98 Tue3


Fire V100:

Boot device: disk  File and args:                                     
SILO Version 1.4.14
boot: 
Allocated 64 Megs of memory at 0x40000000 for kernel
Uncompressing image...
Loaded kernel version 3.6.0

[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.0.18 2002/05/23 18:22'
[    0.000000] PROMLIB: Root node compatible: sun4u
[    0.000000] Linux version 3.12.0-rc2 (mroos@janku) (gcc version 4.6.4 (Debian 4.6.4-4) ) #89 Tue3

Fire V210:

Rebooting with command: boot                                          
Boot device: disk  File and args: 
SILO Version 1.4.14
boot: test
Allocated 64 Megs of memory at 0x40000000 for kernel
Uncompressing image...
Loaded kernel version 3.6.0

[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.30.4.a 2010/01/06 14:48'
[    0.000000] PROMLIB: Root node compatible: 
[    0.000000] Linux version 3.11.0-rc5 (mroos@v210) (gcc version 4.6.4 (Debian 4.6.4-4) ) #90 SMP Mon Aug 12 08:35:54 EEST 2013

E220R:

Boot device: disk  File and args:                                     
SILO Version 1.4.14
boot: 
Allocated 64 Megs of memory at 0x40000000 for kernel
Uncompressing image...
Loaded kernel version 3.6.0

[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 3.31.0 2001/07/25 20:31'
[    0.000000] PROMLIB: Root node compatible: 
[    0.000000] Linux version 3.12.0-rc2-00033-g22356f4 (mroos@e220r) (gcc version 4.6.4 (Debian 4.6.4-4) ) #20 SMP Wed Sep 25 13:25:09 EE3

U2:

Rebooting with command: boot                                          
Boot device: disk  File and args: 
SILO Version 1.4.14
boot: 
Allocated 64 Megs of memory at 0x40000000 for kernel
Uncompressing image...
Loaded kernel version 3.6.0

[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 3.25.0 1999/12/03 11:35'
[    0.000000] PROMLIB: Root node compatible: 
[    0.000000] Linux version 3.12.0-rc2 (mroos@u2) (gcc version 4.6.4 (Debian 4.6.4-4) ) #57 SMP Tue Sep 24 09:15:55 EEST 2013

T2000:

Boot device: disk  File and args: 
SILO Version 1.4.14
boot: test
Allocated 64 Megs of memory at 0x40000000 for kernel
Uncompressing image...
Loaded kernel version 3.11.0

[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.30.4.d 2011/07/06 14:29'
[    0.000000] PROMLIB: Root node compatible: sun4v
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.11.0 (mroos@t2000) (gcc version 4.6.3 (Debian 4.6.3-14) ) #3 SMP Wed Sep 18 18:39:49 EEST 2013
 
-- 
Meelis Roos (mroos@linux.ee)
