From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Mon, 02 Feb 2004 09:44:53 +0000
Subject: [sparc32] Remove spurious newline
Message-Id: <20040202094453.GC22498@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Wastes space when oopsing.  Please apply.  Thanks.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1550  -> 1.1551 
#	arch/sparc/kernel/traps.c	1.8     -> 1.9    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/02/02	wesolows@foobazco.org	1.1551
# Remove spurious empty line in backtrace.
# --------------------------------------------
#
diff -Nru a/arch/sparc/kernel/traps.c b/arch/sparc/kernel/traps.c
--- a/arch/sparc/kernel/traps.c	Mon Feb  2 01:25:56 2004
+++ b/arch/sparc/kernel/traps.c	Mon Feb  2 01:25:56 2004
@@ -121,7 +121,6 @@
 		      !(((unsigned long) rw) & 0x7)) {
 			printk("Caller[%08lx]", rw->ins[7]);
 			print_symbol(": %s\n", rw->ins[7]);
-			printk("\n");
 			rw = (struct reg_window *)rw->ins[6];
 		}
 	}


-- 
Keith M Wesolowski

	"The US Bill of Rights went too far. They should have stopped with:
	 'Congress shall make no law.'" --anon
