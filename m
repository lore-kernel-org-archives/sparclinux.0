From: Mikael Pettersson <mikpe@it.uu.se>
Date: Tue, 27 Mar 2007 07:42:11 +0000
Subject: [PATCH 2.6.21-rc5] sparc64: gcc-4.2.0 20070317 -Werror failure
Message-Id: <200703270742.l2R7gBGv016635@harpo.it.uu.se>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Compiling 2.6.21-rc5 with gcc-4.2.0 20070317 (prerelease)
for sparc64 fails as follows:

  gcc -Wp,-MD,arch/sparc64/kernel/.time.o.d  -nostdinc -isystem /home/mikpe/pkgs/linux-sparc64/gcc-4.2.0/lib/gcc/sparc64-unknown-linux-gnu/4.2.0/include -D__KERNEL__ -Iinclude  -include include/linux/autoconf.h -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Os -m64 -pipe -mno-fpu -mcpu=ultrasparc -mcmodel=medlow -ffixed-g4 -ffixed-g5 -fcall-used-g7 -Wno-sign-compare -Wa,--undeclared-regs -fomit-frame-pointer  -fno-stack-protector -Wdeclaration-after-statement -Wno-pointer-sign -Werror   -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(time)"  -D"KBUILD_MODNAME=KBUILD_STR(time)" -c -o arch/sparc64/kernel/time.o arch/sparc64/kernel/time.c
cc1: warnings being treated as errors
arch/sparc64/kernel/time.c: In function 'kick_start_clock':
arch/sparc64/kernel/time.c:559: warning: overflow in implicit constant conversion
make[1]: *** [arch/sparc64/kernel/time.o] Error 1
make: *** [arch/sparc64/kernel] Error 2

gcc gets unhappy when the MSTK_SET macro's u8 __val variable
is updated with &= ~0xff (MSTK_YEAR_MASK). Making the constant
unsigned fixes the problem.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

--- linux-2.6.21-rc5/include/asm-sparc64/mostek.h.~1~	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6.21-rc5/include/asm-sparc64/mostek.h	2007-03-26 20:43:21.000000000 +0200
@@ -89,7 +89,7 @@ extern void __iomem *mstk48t02_regs;
 #define	MSTK_DOW_MASK	0x07
 #define	MSTK_DOM_MASK	0x3f
 #define	MSTK_MONTH_MASK	0x1f
-#define	MSTK_YEAR_MASK	0xff
+#define	MSTK_YEAR_MASK	0xffU
 
 /* Binary coded decimal conversion macros. */
 #define MSTK_REGVAL_TO_DECIMAL(x)  (((x) & 0x0F) + 0x0A * ((x) >> 0x04))
