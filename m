From: Meelis Roos <mroos@linux.ee>
Date: Tue, 01 Sep 2009 07:33:08 +0000
Subject: Re: boot panic after oops from sysfs_new_dirent
Message-Id: <Pine.SOC.4.64.0909011032350.10835@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0908311646150.20934@math.ut.ee>
 <20090831.142215.111904849.davem@davemloft.net> <Pine.SOC.4.64.0909011003460.10184@math.ut.ee>
 <4A9CC9E9.2070609@kernel.org> <4A9CCD92.4090909@kernel.org>
In-Reply-To: <4A9CCD92.4090909@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tejun Heo <tj@kernel.org>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>

> Ummm.... one more question.  Is cpu0 missing?  Can you please post the
> output of "cat /proc/cpuinfo"?

Yes, there's no CPU numbered 0, the numbers come from hardware slots on 
backplane.

cpu             : TI UltraSparc II  (BlackBird)
fpu             : UltraSparc II integrated FPU
pmu             : ultra12
prom            : OBP 3.2.29 2001/06/18 17:28
type            : sun4u
ncpus probed    : 6
ncpus active    : 6
D$ parity tl1   : 0
I$ parity tl1   : 0
Cpu6ClkTck      : 000000000ec82e00
Cpu7ClkTck      : 000000000ec82e00
Cpu10ClkTck     : 000000000ec82e00
Cpu11ClkTck     : 000000000ec82e00
Cpu14ClkTck     : 000000000ec82e00
Cpu15ClkTck     : 000000000ec82e00
MMU Type        : Spitfire
State:
CPU6:           online
CPU7:           online
CPU10:          online
CPU11:          online
CPU14:          online
CPU15:          online


-- 
Meelis Roos (mroos@linux.ee)
