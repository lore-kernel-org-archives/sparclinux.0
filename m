From: Meelis Roos <mroos@linux.ee>
Date: Tue, 13 Jan 2009 10:01:59 +0000
Subject: current git does not compile on sparc64 (__raw_spin_is_locked
Message-Id: <Pine.SOC.4.64.0901131200330.10489@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Just did make mrproper, git-pull, make oldconfig on old config.

  CC      arch/sparc/kernel/sparc_ksyms_64.o
In file included from 
/home/mroos/compile/linux-2.6/arch/sparc/include/asm/spinlock.h:4,
                 from arch/sparc/kernel/sparc_ksyms_64.c:12:
/home/mroos/compile/linux-2.6/arch/sparc/include/asm/spinlock_64.h:24:1: 
error: "__raw_spin_is_locked" redefined
In file included from include/linux/spinlock.h:90,
                 from include/linux/seqlock.h:29,
                 from include/linux/time.h:8,
                 from include/linux/stat.h:60,
                 from include/linux/module.h:10,
                 from arch/sparc/kernel/sparc_ksyms_64.c:8:
include/linux/spinlock_up.h:60:1: error: this is the location of the 
previous definition
In file included from 
/home/mroos/compile/linux-2.6/arch/sparc/include/asm/spinlock.h:4,
                 from arch/sparc/kernel/sparc_ksyms_64.c:12:
/home/mroos/compile/linux-2.6/arch/sparc/include/asm/spinlock_64.h:26:1: 
error: "__raw_spin_unlock_wait" redefined
In file included from include/linux/spinlock.h:90,
                 from include/linux/seqlock.h:29,
                 from include/linux/time.h:8,
                 from include/linux/stat.h:60,
                 from include/linux/module.h:10,
                 from arch/sparc/kernel/sparc_ksyms_64.c:8:
include/linux/spinlock_up.h:72:1: error: this is the location of the 
previous definition
In file included from 
/home/mroos/compile/linux-2.6/arch/sparc/include/asm/spinlock.h:4,
                 from arch/sparc/kernel/sparc_ksyms_64.c:12:
/home/mroos/compile/linux-2.6/arch/sparc/include/asm/spinlock_64.h:30: 
error: expected identifier or '(' before 'do'
/home/mroos/compile/linux-2.6/arch/sparc/include/asm/spinlock_64.h:30: 
error: expected identifier or '(' before 'while'
/home/mroos/compile/linux-2.6/arch/sparc/include/asm/spinlock_64.h:49: 
error: expected identifier or '(' before '{' token
/home/mroos/compile/linux-2.6/arch/sparc/include/asm/spinlock_64.h:62: 
error: expected identifier or '(' before 'do'
/home/mroos/compile/linux-2.6/arch/sparc/include/asm/spinlock_64.h:62: 
error: expected identifier or '(' before 'while'
In file included from 
/home/mroos/compile/linux-2.6/arch/sparc/include/asm/spinlock.h:4,
                 from arch/sparc/kernel/sparc_ksyms_64.c:12:
/home/mroos/compile/linux-2.6/arch/sparc/include/asm/spinlock_64.h:220:1: 
error: "__raw_read_can_lock" redefined
In file included from include/linux/spinlock.h:90,
                 from include/linux/seqlock.h:29,
                 from include/linux/time.h:8,
                 from include/linux/stat.h:60,
                 from include/linux/module.h:10,
                 from arch/sparc/kernel/sparc_ksyms_64.c:8:
include/linux/spinlock_up.h:69:1: error: this is the location of the 
previous definition
In file included from 
/home/mroos/compile/linux-2.6/arch/sparc/include/asm/spinlock.h:4,
                 from arch/sparc/kernel/sparc_ksyms_64.c:12:
/home/mroos/compile/linux-2.6/arch/sparc/include/asm/spinlock_64.h:221:1: 
error: "__raw_write_can_lock" redefined
In file included from include/linux/spinlock.h:90,
                 from include/linux/seqlock.h:29,
                 from include/linux/time.h:8,
                 from include/linux/stat.h:60,
                 from include/linux/module.h:10,
                 from arch/sparc/kernel/sparc_ksyms_64.c:8:
include/linux/spinlock_up.h:70:1: error: this is the location of the 
previous definition
make[1]: *** [arch/sparc/kernel/sparc_ksyms_64.o] Error 1


-- 
Meelis Roos (mroos@linux.ee)
