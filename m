From: David Miller <davem@davemloft.net>
Date: Thu, 04 Aug 2011 09:02:50 +0000
Subject: [PATCH 0/7] More Niagara T3 related tweaks.
Message-Id: <20110804.020250.979859235761952341.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Report more CPU capabilities in ELF flags, and report them in
bootup logs and /proc/cpuinfo.  For example my /proc/cpuinfo
now has a line that reads:

cpucaps		: flush,stbar,swap,muldiv,v9,blkinit,n2,mul32,div32,v8plus,popc,vis,vis2,ASIBlkInit,fmaf,vis3,hpc

Don't use FPU for copies and clears of pages on Niagara T2, T2+, and
T3.  The Niagara T1 version is fast enough, and doesn't have the
potential overhead of FPU state save/restore. Unroll the loops a
little bit and use %asi register to decrease the overall cycle count.

If available use 'popc' for hweight*(), ffs(), __ffs(), and ffz().

More recent hypervisors have a new way to record the "reboot-cmd"
variable that is used to setup the boot command that will be used on
soft resets.  It's done purely via the hypervisor which allows
parallel boot, and also allows the boot string to propagate properly
into the next boot even if the service processor is down or in
degraded mode.

I intend to consolidate the code patching a little bit in the future.
We don't need all these different patch blob structures.  One with a
cleverly encoded instruction count will do.  Then we have one central
patching routine that takes "start_pointer, end_pointer".
