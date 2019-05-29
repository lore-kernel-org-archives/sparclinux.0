From: Meelis Roos <mroos@linux.ee>
Date: Wed, 29 May 2019 19:08:26 +0000
Subject: [bisected] DEBUG_PAGEALLOC hangs on sparc64
Message-Id: <86e9d84e-cffa-0bae-f575-7cf6789f5fb8@linux.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

When we debugged Ricks patches, he suggested that it might be
CONFIG_DEBUG_PAGEALLOC that is broken and suggested I bisect it.

I did. It was not as simple as I had hoped. Initially I saw the problem with
current kernel on V445 when I turned on DEBUG_PAGEALLOC. I could go down to
4.16 on thismachine and no lower (older kernels did not support gcc-8) and
it was still broken with 4.16.

Next I took V440 with old userspace (gcc 4.9.3) and tried with that. After finding
out that CONFIG_HIBERNATION disables/hides DEBUG_PAGEALLOC, I was able to turn on
DEBUG_PAGEALLOC. 4.0 was good, 4.16 was bad, so I started bisecting. On good commits,
everything worked. On bad commits, it hangs slightly after the first scsi disk
detection (the exact line varies slightly) and Ricks debug patches for his patch
showed that it was probably the first vfree() that hangs (please correct me if
I got it wrong!).

Bisecting led me to 4.9 merge window and this patch that broke it:

a74ad5e660a9ee1d071665e7e8ad822784a2dc7f is the first bad commit
commit a74ad5e660a9ee1d071665e7e8ad822784a2dc7f
Author: David S. Miller <davem@davemloft.net>
Date:   Thu Oct 27 09:04:54 2016 -0700

     sparc64: Handle extremely large kernel TLB range flushes more gracefully.
     
     When the vmalloc area gets fragmented, and because the firmware
     mapping area sits between where modules live and the vmalloc area, we
     can sometimes receive requests for enormous kernel TLB range flushes.
     
     When this happens the cpu just spins flushing billions of pages and
     this triggers the NMI watchdog and other problems.
     
     We took care of this on the TSB side by doing a linear scan of the
     table once we pass a certain threshold.
     
     Do something similar for the TLB flush, however we are limited by
     the TLB flush facilities provided by the different chip variants.
     
     First of all we use an (mostly arbitrary) cut-off of 256K which is
     about 32 pages.  This can be tuned in the future.
     
     The huge range code path for each chip works as follows:
     
     1) On spitfire we flush all non-locked TLB entries using diagnostic
        acceses.
     
     2) On cheetah we use the "flush all" TLB flush.
     
     3) On sun4v/hypervisor we do a TLB context flush on context 0, which
        unlike previous chips does not remove "permanent" or locked
        entries.
     
     We could probably do something better on spitfire, such as limiting
     the flush to kernel TLB entries or even doing range comparisons.
     However that probably isn't worth it since those chips are old and
     the TLB only had 64 entries.
     
     Reported-by: James Clarke <jrtc27@jrtc27.com>
     Tested-by: James Clarke <jrtc27@jrtc27.com>
     Signed-off-by: David S. Miller <davem@davemloft.net>

:040000 040000 c55bfc4f1f2140c55c7e00c122794d102025a6eb 0ffe14322d0813244aa7ba2bdc94680eceeccf49 M      arch

This is the CPU in V440:
$ cat /proc/cpuinfo
cpu             : TI UltraSparc IIIi (Jalapeno)
fpu             : UltraSparc IIIi integrated FPU
pmu             : ultra3i
prom            : OBP 4.30.4.a 2010/01/06 14:45
type            : sun4u
ncpus probed    : 4
ncpus active    : 4
D$ parity tl1   : 0
I$ parity tl1   : 0
cpucaps         : flush,stbar,swap,muldiv,v9,ultra3,mul32,div32,v8plus,vis,vis2
Cpu0ClkTck      : 000000004c5a8240
Cpu1ClkTck      : 000000004c5a8240
Cpu2ClkTck      : 000000004c5a8240
Cpu3ClkTck      : 000000004c5a8240
MMU Type        : Cheetah+
MMU PGSZs       : 8K,64K,512K,4MB
State:
CPU0:           online
CPU1:           online
CPU2:           online
CPU3:           online


-- 
Meelis Roos (mroos@linux.ee)
