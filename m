From: "Bjoern B. Brandenburg" <bbb@email.unc.edu>
Date: Thu, 08 May 2008 22:39:33 +0000
Subject: enabling lockdep causes boot failure on a SUN T2000
Message-Id: <48238125.7040900@email.unc.edu>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi all,

I've been having a hard time getting Linux (vanilla 2.6.24 and 2.6.25) 
to boot on our Niagara box.

With many configurations, the system gets "stuck" during boot when 
executing init from the initramfs (Ubuntu). I've been test-booting 
various configurations now for three days, and I've finally been able to 
narrow it down to what appears to be lockdep.

With lockdep disabled, the system boots fine and runs stable. With 
lockdep enabled on 2.6.24, the system starts executing the init scripts 
from the initramfs and then just sits there. With 2.6.25, the system 
also dies but I had more luck and could capture some debug output.

The case that works:
	config: http://www.cs.unc.edu/~bbb/linux/config-boots-fine
	boot:   http://www.cs.unc.edu/~bbb/linux/boot.ok.txt

The case that doesn't work:
	config: http://www.cs.unc.edu/~bbb/linux/config-stuck-initramfs
	boot:   http://www.cs.unc.edu/~bbb/linux/boot.fail.txt

The only difference is that I enabled lockdep (see diff below). This is 
problematic for us since we would like to use lockdep to debug a patch 
that we are working on.

Please let me know how we can help to debug this.

Thanks,
Bjoern


--- config-boots-fine   2008-05-08 17:39:44.000000000 -0400
+++ config-stuck-initramfs      2008-05-08 17:18:25.000000000 -0400
@@ -1,7 +1,7 @@
  #
  # Automatically generated make config: don't edit
  # Linux kernel version: 2.6.25
-# Thu May  8 17:21:04 2008
+# Thu May  8 16:58:26 2008
  #
  CONFIG_SPARC=y
  CONFIG_SPARC64=y
@@ -977,19 +979,24 @@
  CONFIG_DEBUG_PREEMPT=y
  # CONFIG_DEBUG_RT_MUTEXES is not set
  # CONFIG_RT_MUTEX_TESTER is not set
-# CONFIG_DEBUG_SPINLOCK is not set
-# CONFIG_DEBUG_MUTEXES is not set
-# CONFIG_DEBUG_LOCK_ALLOC is not set
-# CONFIG_PROVE_LOCKING is not set
+CONFIG_DEBUG_SPINLOCK=y
+CONFIG_DEBUG_MUTEXES=y
+CONFIG_DEBUG_LOCK_ALLOC=y
+CONFIG_PROVE_LOCKING=y
+CONFIG_LOCKDEP=y
  # CONFIG_LOCK_STAT is not set
+# CONFIG_DEBUG_LOCKDEP is not set
+CONFIG_TRACE_IRQFLAGS=y
  CONFIG_DEBUG_SPINLOCK_SLEEP=y
  CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
+CONFIG_STACKTRACE=y
  # CONFIG_DEBUG_KOBJECT is not set
  CONFIG_DEBUG_BUGVERBOSE=y
  CONFIG_DEBUG_INFO=y
  # CONFIG_DEBUG_VM is not set
  CONFIG_DEBUG_LIST=y
  # CONFIG_DEBUG_SG is not set
+CONFIG_FRAME_POINTER=y
  # CONFIG_BOOT_PRINTK_DELAY is not set
  # CONFIG_RCU_TORTURE_TEST is not set
  # CONFIG_BACKTRACE_SELF_TEST is not set
