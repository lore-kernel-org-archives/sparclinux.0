From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Mon, 02 Feb 2004 09:43:47 +0000
Subject: [sparc32] Copy full soft PMD in fault handler
Message-Id: <20040202094347.GB22498@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

sparc_do_fault assumes that pmd_val(*pmd) = pmd_val(*pmd_k) will
duplicate a PMD entry.  With large soft-PMDs this doesn't work.

Is this ok?  Specifically I'm wondering whether it's necessary to use
swap here is in pmd_set.  The comment in the i386 handler "Do _not_
use "tsk" here. We might be inside an interrupt in the middle of a
task switch.." doesn't make me feel too good about this function's
health and well-being either, since we use tsk.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1551  -> 1.1552 
#	arch/sparc/mm/fault.c	1.15    -> 1.16   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/02/02	wesolows@foobazco.org	1.1552
# Copy all 16 sub-pmd-entries, not just the first one.
# --------------------------------------------
#
diff -Nru a/arch/sparc/mm/fault.c b/arch/sparc/mm/fault.c
--- a/arch/sparc/mm/fault.c	Mon Feb  2 01:25:54 2004
+++ b/arch/sparc/mm/fault.c	Mon Feb  2 01:25:54 2004
@@ -392,7 +392,7 @@
 
 		if (pmd_present(*pmd) || !pmd_present(*pmd_k))
 			goto bad_area_nosemaphore;
-		pmd_val(*pmd) = pmd_val(*pmd_k);
+		*pmd = *pmd_k;
 		return;
 	}
 }


-- 
Keith M Wesolowski
