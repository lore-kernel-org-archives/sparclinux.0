From: Ed L Cashin <ecashin@uga.edu>
Date: Wed, 10 Mar 2004 18:27:49 +0000
Subject: strange exit paths for do_sparc64_fault?
Message-Id: <87n06oiml6.fsf@uga.edu>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi.  In my patch to 2.6.0-test11 I have added a new semaphore "S".
The mmap_sem sometimes nests within S if a process is of a certain
kind (that has non-NULL current->macc_info).  I've included a patch
below to help show what I'm talking about.

I'm observing a situation where in do_sparc64_fault, this semaphore is
taken but never released.  I've matched every up_read(&mm->mmap_sem)
with a release of my semaphore, though.

Is there a situation where the mmap_sem is taken on entering
do_sparc64_fault but released outside of do_sparc64_fault?  That would
explain what I'm seeing.  I should mention that I only see this when
there's significant contention for memory, i.e., pgsteal is
increasing. 


--- /tmp/2.6.0-test11.orig/arch/sparc64/mm/fault.c	Wed Mar 10 13:04:08 2004
+++ macc-sparc64/arch/sparc64/mm/fault.c	Wed Mar 10 12:59:07 2004
@@ -18,6 +18,8 @@
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/macc.h>
+#include <linux/dbg.h>
 
 #include <asm/page.h>
 #include <asm/pgtable.h>
@@ -345,6 +358,8 @@ asmlinkage void do_sparc64_fault(struct 
 		address &= 0xffffffff;
 	}
 
+	/* to avoid deadlock, get the sync mutex first if we're in a macc family */
+	get_macc_sync(current->pid, current->macc_info);
 	down_read(&mm->mmap_sem);
 	vma = find_vma(mm, address);
 	if (!vma)
@@ -432,6 +447,7 @@ good_area:
 	}
 
 	up_read(&mm->mmap_sem);
+	put_macc_sync(current->pid, current->macc_info);
 	goto fault_done;
 
 	/*
@@ -441,6 +457,7 @@ good_area:
 bad_area:
 	insn = get_fault_insn(regs, insn);
 	up_read(&mm->mmap_sem);
+	put_macc_sync(current->pid, current->macc_info);
 
 handle_kernel_fault:
 	do_kernel_fault(regs, si_code, fault_code, insn, address);
@@ -454,6 +471,7 @@ handle_kernel_fault:
 out_of_memory:
 	insn = get_fault_insn(regs, insn);
 	up_read(&mm->mmap_sem);
+	put_macc_sync(current->pid, current->macc_info);
 	printk("VM: killing process %s\n", current->comm);
 	if (!(regs->tstate & TSTATE_PRIV))
 		do_exit(SIGKILL);
@@ -466,6 +484,7 @@ intr_or_no_mm:
 do_sigbus:
 	insn = get_fault_insn(regs, insn);
 	up_read(&mm->mmap_sem);
+	put_macc_sync(current->pid, current->macc_info);
 
 	/*
 	 * Send a sigbus, regardless of whether we were in kernel

-- 
--Ed L Cashin            |   PGP public key:
  ecashin@uga.edu        |   http://noserose.net/e/pgp/

