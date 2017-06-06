From: Palmer Dabbelt <palmer@dabbelt.com>
Date: Tue, 06 Jun 2017 19:10:20 +0000
Subject: [PATCH 4/7] score: Use lib/{ashldi3,ashrdi3,cmpdi2,lshrdi3,ucmpdi2}.c
Message-Id: <20170606191023.24581-5-palmer@dabbelt.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170523220546.16758-1-palmer@dabbelt.com>
 <20170606191023.24581-1-palmer@dabbelt.com>
In-Reply-To: <20170606191023.24581-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: monstr@monstr.eu, ralf@linux-mips.org, liqin.linux@gmail.com, lennox.wu@gmail.com, ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, geert@linux-m68k.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>

These files are functionally identical to the shared copies that I
recently added.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/score/Kconfig       |  5 +++++
 arch/score/lib/Makefile  |  3 ---
 arch/score/lib/ashldi3.c | 46 ----------------------------------------------
 arch/score/lib/ashrdi3.c | 48 ------------------------------------------------
 arch/score/lib/cmpdi2.c  | 44 --------------------------------------------
 arch/score/lib/libgcc.h  | 37 -------------------------------------
 arch/score/lib/lshrdi3.c | 47 -----------------------------------------------
 arch/score/lib/ucmpdi2.c | 38 --------------------------------------
 8 files changed, 5 insertions(+), 263 deletions(-)
 delete mode 100644 arch/score/lib/ashldi3.c
 delete mode 100644 arch/score/lib/ashrdi3.c
 delete mode 100644 arch/score/lib/cmpdi2.c
 delete mode 100644 arch/score/lib/libgcc.h
 delete mode 100644 arch/score/lib/lshrdi3.c
 delete mode 100644 arch/score/lib/ucmpdi2.c

diff --git a/arch/score/Kconfig b/arch/score/Kconfig
index 507d63181389..151ec2296d53 100644
--- a/arch/score/Kconfig
+++ b/arch/score/Kconfig
@@ -15,6 +15,11 @@ config SCORE
 	select MODULES_USE_ELF_REL
 	select CLONE_BACKWARDS
 	select CPU_NO_EFFICIENT_FFS
+	select GENERIC_ASHLDI3
+	select GENERIC_ASHRDI3
+	select GENERIC_CMPDI2
+	select GENERIC_LSHRDI3
+	select GENERIC_UCMPDI2
 
 choice
 	prompt "System type"
diff --git a/arch/score/lib/Makefile b/arch/score/lib/Makefile
index 553e30e81faf..ea3f3aba8c71 100644
--- a/arch/score/lib/Makefile
+++ b/arch/score/lib/Makefile
@@ -3,6 +3,3 @@
 #
 
 lib-y += string.o checksum.o checksum_copy.o
-
-# libgcc-style stuff needed in the kernel
-obj-y += ashldi3.o ashrdi3.o cmpdi2.o lshrdi3.o ucmpdi2.o
diff --git a/arch/score/lib/ashldi3.c b/arch/score/lib/ashldi3.c
deleted file mode 100644
index 15691a910431..000000000000
--- a/arch/score/lib/ashldi3.c
+++ /dev/null
@@ -1,46 +0,0 @@
-/*
- * arch/score/lib/ashldi3.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see the file COPYING, or write
- * to the Free Software Foundation, Inc.,
- * 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#include <linux/module.h>
-#include "libgcc.h"
-
-long long __ashldi3(long long u, word_type b)
-{
-	DWunion uu, w;
-	word_type bm;
-
-	if (b = 0)
-		return u;
-
-	uu.ll = u;
-	bm = 32 - b;
-
-	if (bm <= 0) {
-		w.s.low = 0;
-		w.s.high = (unsigned int) uu.s.low << -bm;
-	} else {
-		const unsigned int carries = (unsigned int) uu.s.low >> bm;
-
-		w.s.low = (unsigned int) uu.s.low << b;
-		w.s.high = ((unsigned int) uu.s.high << b) | carries;
-	}
-
-	return w.ll;
-}
-EXPORT_SYMBOL(__ashldi3);
diff --git a/arch/score/lib/ashrdi3.c b/arch/score/lib/ashrdi3.c
deleted file mode 100644
index d9814a5d8d30..000000000000
--- a/arch/score/lib/ashrdi3.c
+++ /dev/null
@@ -1,48 +0,0 @@
-/*
- * arch/score/lib/ashrdi3.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see the file COPYING, or write
- * to the Free Software Foundation, Inc.,
- * 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#include <linux/module.h>
-#include "libgcc.h"
-
-long long __ashrdi3(long long u, word_type b)
-{
-	DWunion uu, w;
-	word_type bm;
-
-	if (b = 0)
-		return u;
-
-	uu.ll = u;
-	bm = 32 - b;
-
-	if (bm <= 0) {
-		/* w.s.high = 1..1 or 0..0 */
-		w.s.high -		    uu.s.high >> 31;
-		w.s.low = uu.s.high >> -bm;
-	} else {
-		const unsigned int carries = (unsigned int) uu.s.high << bm;
-
-		w.s.high = uu.s.high >> b;
-		w.s.low = ((unsigned int) uu.s.low >> b) | carries;
-	}
-
-	return w.ll;
-}
-EXPORT_SYMBOL(__ashrdi3);
diff --git a/arch/score/lib/cmpdi2.c b/arch/score/lib/cmpdi2.c
deleted file mode 100644
index 1ed5290c66ed..000000000000
--- a/arch/score/lib/cmpdi2.c
+++ /dev/null
@@ -1,44 +0,0 @@
-/*
- * arch/score/lib/cmpdi2.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see the file COPYING, or write
- * to the Free Software Foundation, Inc.,
- * 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#include <linux/module.h>
-#include "libgcc.h"
-
-word_type __cmpdi2(long long a, long long b)
-{
-	const DWunion au = {
-		.ll = a
-	};
-	const DWunion bu = {
-		.ll = b
-	};
-
-	if (au.s.high < bu.s.high)
-		return 0;
-	else if (au.s.high > bu.s.high)
-		return 2;
-
-	if ((unsigned int) au.s.low < (unsigned int) bu.s.low)
-		return 0;
-	else if ((unsigned int) au.s.low > (unsigned int) bu.s.low)
-		return 2;
-
-	return 1;
-}
-EXPORT_SYMBOL(__cmpdi2);
diff --git a/arch/score/lib/libgcc.h b/arch/score/lib/libgcc.h
deleted file mode 100644
index 0f12543d9f31..000000000000
--- a/arch/score/lib/libgcc.h
+++ /dev/null
@@ -1,37 +0,0 @@
-/*
- * arch/score/lib/libgcc.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see the file COPYING, or write
- * to the Free Software Foundation, Inc.,
- * 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-
-#ifndef __ASM_LIBGCC_H
-#define __ASM_LIBGCC_H
-
-#include <asm/byteorder.h>
-
-typedef int word_type __attribute__((mode(__word__)));
-
-struct DWstruct {
-	int low, high;
-};
-
-typedef union {
-	struct DWstruct s;
-	long long ll;
-} DWunion;
-
-#endif /* __ASM_LIBGCC_H */
diff --git a/arch/score/lib/lshrdi3.c b/arch/score/lib/lshrdi3.c
deleted file mode 100644
index ce21175fd791..000000000000
--- a/arch/score/lib/lshrdi3.c
+++ /dev/null
@@ -1,47 +0,0 @@
-/*
- * arch/score/lib/lshrdi3.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see the file COPYING, or write
- * to the Free Software Foundation, Inc.,
- * 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-
-#include <linux/module.h>
-#include "libgcc.h"
-
-long long __lshrdi3(long long u, word_type b)
-{
-	DWunion uu, w;
-	word_type bm;
-
-	if (b = 0)
-		return u;
-
-	uu.ll = u;
-	bm = 32 - b;
-
-	if (bm <= 0) {
-		w.s.high = 0;
-		w.s.low = (unsigned int) uu.s.high >> -bm;
-	} else {
-		const unsigned int carries = (unsigned int) uu.s.high << bm;
-
-		w.s.high = (unsigned int) uu.s.high >> b;
-		w.s.low = ((unsigned int) uu.s.low >> b) | carries;
-	}
-
-	return w.ll;
-}
-EXPORT_SYMBOL(__lshrdi3);
diff --git a/arch/score/lib/ucmpdi2.c b/arch/score/lib/ucmpdi2.c
deleted file mode 100644
index b15241e0b079..000000000000
--- a/arch/score/lib/ucmpdi2.c
+++ /dev/null
@@ -1,38 +0,0 @@
-/*
- * arch/score/lib/ucmpdi2.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see the file COPYING, or write
- * to the Free Software Foundation, Inc.,
- * 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#include <linux/module.h>
-#include "libgcc.h"
-
-word_type __ucmpdi2(unsigned long long a, unsigned long long b)
-{
-	const DWunion au = {.ll = a};
-	const DWunion bu = {.ll = b};
-
-	if ((unsigned int) au.s.high < (unsigned int) bu.s.high)
-		return 0;
-	else if ((unsigned int) au.s.high > (unsigned int) bu.s.high)
-		return 2;
-	if ((unsigned int) au.s.low < (unsigned int) bu.s.low)
-		return 0;
-	else if ((unsigned int) au.s.low > (unsigned int) bu.s.low)
-		return 2;
-	return 1;
-}
-EXPORT_SYMBOL(__ucmpdi2);
-- 
2.13.0

