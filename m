From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 21 Dec 2004 04:31:24 +0000
Subject: [3/3] fix mostek compile breakage (please send in real summaries, too)
Message-Id: <20041221043124.GA771@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Sent in by Art Haas:

I tried building an SMP kernel for my SS20 last night using the CVS
version of GCC. The build failed with this error:

arch/sparc/kernel/time.c:57: error: static declaration of 'mstk48t08_regs' follows non-static declaration
include/asm/mostek.h:131: error: previous declaration of 'mstk48t08_regs' was here

The patch below fixed this problem. The SMP kernel itself ultimately did
not link due to other problems, but as SMP on 32-bit Sparc is still broken,
I couldn't try and run what I'd built. Building of an SMP kernel was
just something to try and see if all the files would even compile, as
was not the case several months ago. BTW, the link error was:

kernel/built-in.o(.spinlock.text+0x4): In function '_write_trylock':
ksysfs.c: undefined reference to '_raw_write_trylock'.

Signed-off-by: Art Haas <ahaas@airmail.net>
Acked-by: William Irwin <wli@holomorphy.com>


Index: sparc32-2.6.10-rc3/include/asm-sparc/mostek.h
=================================--- sparc32-2.6.10-rc3.orig/include/asm-sparc/mostek.h	2004-12-16 06:20:01.000000000 -0800
+++ sparc32-2.6.10-rc3/include/asm-sparc/mostek.h	2004-12-20 19:28:17.975201226 -0800
@@ -127,7 +127,6 @@
 	char offset[6*1024];         /* Magic things may be here, who knows? */
 	struct mostek48t02 regs;     /* Here is what we are interested in.   */
 };
-extern struct mostek48t08 *mstk48t08_regs;
 
 extern enum sparc_clock_type sp_clock_typ;
 
