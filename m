From: William Lee Irwin III <wli@holomorphy.com>
Date: Wed, 22 Dec 2004 14:31:13 +0000
Subject: [sparc32] vm fault code handling
Message-Id: <20041222143113.GT771@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Convert arch/sparc/mm/fault.c to symbolic fault codes, default to minor
faults for unrecognized fault codes. Also treat VM_FAULT_OOM similarly
to VM_FAULT_SIGBUS in force_user_fault(), thereby fixing a latent bug.

Index: sparc32-2.6.10-rc3/arch/sparc/mm/fault.c
=================================--- sparc32-2.6.10-rc3.orig/arch/sparc/mm/fault.c	2004-10-07 04:01:27.000000000 -0700
+++ sparc32-2.6.10-rc3/arch/sparc/mm/fault.c	2004-12-21 08:10:56.962777738 -0800
@@ -294,16 +294,17 @@
 	 * the fault.
 	 */
 	switch (handle_mm_fault(mm, vma, address, write)) {
-	case 1:
-		current->min_flt++;
-		break;
-	case 2:
+	case VM_FAULT_SIGBUS:
+		goto do_sigbus;
+	case VM_FAULT_OOM:
+		goto out_of_memory;
+	case VM_FAULT_MAJOR:
 		current->maj_flt++;
 		break;
-	case 0:
-		goto do_sigbus;
+	case VM_FAULT_MINOR:
 	default:
-		goto out_of_memory;
+		current->min_flt++;
+		break;
 	}
 	up_read(&mm->mmap_sem);
 	return;
@@ -535,8 +536,11 @@
 		if(!(vma->vm_flags & (VM_READ | VM_EXEC)))
 			goto bad_area;
 	}
-	if (!handle_mm_fault(mm, vma, address, write))
+	switch (handle_mm_fault(mm, vma, address, write)) {
+	case VM_FAULT_SIGBUS:
+	case VM_FAULT_OOM:
 		goto do_sigbus;
+	}
 	up_read(&mm->mmap_sem);
 	return;
 bad_area:
