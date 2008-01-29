From: Mike Dalton <mwdalton@CS.Stanford.EDU>
Date: Tue, 29 Jan 2008 10:37:16 +0000
Subject: [PATCH] sparc32 __bzero() store missing __ex_table entry
Message-Id: <Pine.LNX.4.64.0801290222530.26076@xenon.Stanford.EDU>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi, I wanted to report a minor bug in Linux 2.6 sparc32. The __bzero 
function has entries in __ex_table for every store instruction except for one 
group at the end. As user pointers can be passed to this function, it 
looks like this last group of stores should also have an entry 
in __ex_table. I've included a patch adding the __ex_table entry. Please 
let me know if you can confirm that this a bug, or need more information.

Best regards,

Mike

diff -BbruN linux-2.6.24.orig/arch/sparc/lib/memset.S linux-2.6.24/arch/sparc/lib/memset.S
--- linux-2.6.24.orig/arch/sparc/lib/memset.S	2008-01-29 02:24:57.852038000 -0800
+++ linux-2.6.24/arch/sparc/lib/memset.S	2008-01-29 02:34:11.919050000 -0800
@@ -134,6 +134,7 @@
  	ZERO_LAST_BLOCKS(%o0, 0x48, %g2)
  	ZERO_LAST_BLOCKS(%o0, 0x08, %g2)
  13:
+	EXT(12b, 13b, 20f)
  	be	8f
  	 andcc	%o1, 4, %g0

