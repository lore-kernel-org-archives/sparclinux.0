From: Marcel van Nies <morcles@gmail.com>
Date: Tue, 29 May 2012 23:28:31 +0000
Subject: Re: sparc32: some more testing
Message-Id: <CACEWtaCbKi+EAk1=jnJJkoKrvS6HR4xNz0DvwzynZoaEnoDt8w@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CACEWtaD1kfFocos0EaaZTWodas=YWcM3L-fFJR48JJApTDj2YA@mail.gmail.com>
In-Reply-To: <CACEWtaD1kfFocos0EaaZTWodas=YWcM3L-fFJR48JJApTDj2YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I looked a little further into the problems I see on my
SS20 with hypersparc cpus.  I got things like

Linux version 2.6.33-02580-g79da01d ...
...
Freeing unused kernel memory: 132k freed
Kernel panic - not syncing: Attempted to kill init!
[f00320f4 : do_group_exit+0x28/0xb4 ]
[f003c5a0 : get_signal_to_deliver+0x258/0x368 ]
[f00125b4 : do_signal+0x34/0x8cc ]
[f0013350 : do_notify_resume+0x2c/0x3c]
[f000fcec : signal_p+0x14/0x24 ]
[f000ee44 : srmmu_fault+0x58/0x68 ]
Press Stop-A (L1-A) to return to the boot prom
INFO: RCU detected CPU 0 stall (t%00 jiffies)
INFO: RCU detected CPU 0 stall (t000 jiffies)
INFO: RCU detected CPU 0 stall (t500 jiffies)
...

I could actually bisect it down to this:

commit 4d14a459857bd151ecbd14bcd37b4628da00792b
Author: David S. Miller <davem@davemloft.net>
Date:   Thu Dec 10 23:32:10 2009 -0800

    sparc: Stop trying to be so fancy and use __builtin_{memcpy,memset}()

    This mirrors commit ff60fab71bb3b4fdbf8caf57ff3739ffd0887396
    (x86: Use __builtin_memset and __builtin_memcpy for memset/memcpy)

    Signed-off-by: David S. Miller <davem@davemloft.net>

:040000 040000 3023748f5a1b5a02502e918352ecbe750c2323f7
e455c22b275b41621281f0423e1e3a312552968c M      arch

Prior to this commit, INIT does not segfault and the SS20 run's UP and SMP too.
I'll try to revert this commit on current sparc.git later.

Linux ross 2.6.32-03939-gfb34035 #28 SMP Wed May 30 01:13:55 CEST 2012
sparc sun4m ROSS HyperSparc RT625 or RT626 GNU/Linux

cpu             : ROSS HyperSparc RT625 or RT626
fpu             : ROSS HyperSparc combined IU/FPU
promlib         : Version 3 Revision 2
prom            : 2.25
type            : sun4m
ncpus probed    : 4
ncpus active    : 4
Cpu0Bogo        : 124.92
Cpu1Bogo        : 125.18
Cpu2Bogo        : 109.31
Cpu3Bogo        : 109.31
MMU type        : ROSS HyperSparc
contexts        : 4096
nocache total   : 5242880
nocache used    : 238592
State:
CPU0            : online
CPU1            : online
CPU2            : online
CPU3            : online

Thanks,
M
