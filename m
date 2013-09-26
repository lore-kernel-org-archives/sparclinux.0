From: Meelis Roos <mroos@linux.ee>
Date: Thu, 26 Sep 2013 13:12:55 +0000
Subject: include/linux/version.h not updated (Was: SILO always tells it loaded kernel version 3.6.0)
Message-Id: <alpine.SOC.1.00.1309261601050.11084@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1309260234380.22367@math.ut.ee> <20130926.002304.2121420558807412031.davem@davemloft.net> <alpine.SOC.1.00.1309261347030.11084@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1309261347030.11084@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>

Background: SILO bootloader on sparc64 tells it is loading 3.6.0 when 
actually it is 3.12.0-rc2.

> On U10:
> 
> ok boot
> Boot device: scsidisk  File and args: 
> SILO Version 1.4.14
> boot: test
> Allocated 64 Megs of memory at 0x40000000 for kernel
> Uncompressing image...
> Loaded kernel version 3.6.0
> 
> PROMLIB: Sun IEEE Boot Prom 'OBP 3.31.0 2001/07/25 20:36'
> PROMLIB: Root node compatible: 
> Initializing cgroup subsys cpu
> Linux version 3.11.0-dirty (mroos@u10) (gcc version 4.6.4 (Debian 4.6.4-4) ) #47 Wed Sep 25 16:01:09 EEST 2013

SILO gets the version from struch HdrS in the image.

vmlinux contains HdrS^@^C^F^@, so ver_linux is 00 03 06 0 that is 3.6.0. 
So it's in our image and silo is correct.

It seems to be LINUX_VERSION_CODE in head_64.S - maybe it is nor 
recompiled? No, head_64.o is from yesterday.

grep -r for LINUX_VERSION_CODE results in different values:

./include/generated/uapi/linux/version.h:#define LINUX_VERSION_CODE 199424
./include/linux/version.h:#define LINUX_VERSION_CODE 198144

-rw-r--r-- 1 mroos mroos 97 Sep 20 21:56 include/generated/uapi/linux/version.h
-rw-r--r-- 1 mroos mroos 97 Aug 10  2012 ./include/linux/version.h

As it happens, 198144 is the value from Aug 10 2012 and it happens to be 
00030600 hex. Here is the culprit, we are not rebuilding 
include/linux/version.h.

-- 
Meelis Roos (mroos@linux.ee)
