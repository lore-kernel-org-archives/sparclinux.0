From: "Art Haas" <ahaas@airmail.net>
Date: Sun, 19 Dec 2004 16:06:43 +0000
Subject: [PATCH] Fix for structure declaration error
Message-Id: <20041219160643.GN32704@artsapartment.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi.

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

Art Haas

=== include/asm-sparc/mostek.h 1.4 vs edited ==--- 1.4/include/asm-sparc/mostek.h	2004-12-08 22:21:53 -06:00
+++ edited/include/asm-sparc/mostek.h	2004-12-19 09:42:27 -06:00
@@ -128,7 +128,6 @@
 	char offset[6*1024];         /* Magic things may be here, who knows? */
 	struct mostek48t02 regs;     /* Here is what we are interested in.   */
 };
-extern struct mostek48t08 *mstk48t08_regs;
 
 extern enum sparc_clock_type sp_clock_typ;
 
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
