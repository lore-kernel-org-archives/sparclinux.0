From: David Miller <davem@davemloft.net>
Date: Mon, 09 Feb 2009 06:46:43 +0000
Subject: [PATCH 2/2]: sparc64: Fix probe_kernel_{read,write}().
Message-Id: <20090208.224643.170383946.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This is based upon a report from Chris Torek and his initial patch.
From Chris's report:

--------------------
This came up in testing kgdb, using the built-in tests -- turn
on CONFIG_KGDB_TESTS, then

    echo V1 > /sys/module/kgdbts/parameters/kgdbts

-- but it would affect using kgdb if you were debugging and looking
at bad pointers.
--------------------

When we get a copy_{from,to}_user() request and the %asi is set to
something other than ASI_AIUS (which is userspace) then we branch off
to a routine called memcpy_user_stub().  It just does a straight
memcpy since we are copying from kernel to kernel in this case.

The logic was that since source and destination are both kernel
pointers we don't need to have exception checks.

But for what probe_kernel_{read,write}() is trying to do, we have to
have the checks, otherwise things like kgdb bad kernel pointer
accesses don't do the right thing.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/lib/GENcopy_from_user.S |    2 +-
 arch/sparc/lib/GENcopy_to_user.S   |    2 +-
 arch/sparc/lib/NG2copy_from_user.S |    2 +-
 arch/sparc/lib/NG2copy_to_user.S   |    2 +-
 arch/sparc/lib/NGcopy_from_user.S  |    2 +-
 arch/sparc/lib/NGcopy_to_user.S    |    2 +-
 arch/sparc/lib/U1copy_from_user.S  |    2 +-
 arch/sparc/lib/U1copy_to_user.S    |    2 +-
 arch/sparc/lib/U3copy_to_user.S    |    2 +-
 arch/sparc/lib/copy_in_user.S      |   55 ++++++++++-------------------------
 10 files changed, 25 insertions(+), 48 deletions(-)

diff --git a/arch/sparc/lib/GENcopy_from_user.S b/arch/sparc/lib/GENcopy_from_user.S
index 9b0e58f..b7d0bd6 100644
--- a/arch/sparc/lib/GENcopy_from_user.S
+++ b/arch/sparc/lib/GENcopy_from_user.S
@@ -23,7 +23,7 @@
 #define PREAMBLE					\
 	rd		%asi, %g1;			\
 	cmp		%g1, ASI_AIUS;			\
-	bne,pn		%icc, memcpy_user_stub;		\
+	bne,pn		%icc, ___copy_in_user;		\
 	 nop
 #endif
 
diff --git a/arch/sparc/lib/GENcopy_to_user.S b/arch/sparc/lib/GENcopy_to_user.S
index ce79b49..780550e 100644
--- a/arch/sparc/lib/GENcopy_to_user.S
+++ b/arch/sparc/lib/GENcopy_to_user.S
@@ -27,7 +27,7 @@
 #define PREAMBLE					\
 	rd		%asi, %g1;			\
 	cmp		%g1, ASI_AIUS;			\
-	bne,pn		%icc, memcpy_user_stub;		\
+	bne,pn		%icc, ___copy_in_user;		\
 	 nop
 #endif
 
diff --git a/arch/sparc/lib/NG2copy_from_user.S b/arch/sparc/lib/NG2copy_from_user.S
index 01ac546..119ccb9 100644
--- a/arch/sparc/lib/NG2copy_from_user.S
+++ b/arch/sparc/lib/NG2copy_from_user.S
@@ -28,7 +28,7 @@
 #define PREAMBLE					\
 	rd		%asi, %g1;			\
 	cmp		%g1, ASI_AIUS;			\
-	bne,pn		%icc, memcpy_user_stub;		\
+	bne,pn		%icc, ___copy_in_user;		\
 	 nop
 #endif
 
diff --git a/arch/sparc/lib/NG2copy_to_user.S b/arch/sparc/lib/NG2copy_to_user.S
index c477e15..7fe1cce 100644
--- a/arch/sparc/lib/NG2copy_to_user.S
+++ b/arch/sparc/lib/NG2copy_to_user.S
@@ -37,7 +37,7 @@
 #define PREAMBLE					\
 	rd		%asi, %g1;			\
 	cmp		%g1, ASI_AIUS;			\
-	bne,pn		%icc, memcpy_user_stub;		\
+	bne,pn		%icc, ___copy_in_user;		\
 	 nop
 #endif
 
diff --git a/arch/sparc/lib/NGcopy_from_user.S b/arch/sparc/lib/NGcopy_from_user.S
index 39bb891..5d1e4d1 100644
--- a/arch/sparc/lib/NGcopy_from_user.S
+++ b/arch/sparc/lib/NGcopy_from_user.S
@@ -25,7 +25,7 @@
 #define PREAMBLE					\
 	rd		%asi, %g1;			\
 	cmp		%g1, ASI_AIUS;			\
-	bne,pn		%icc, memcpy_user_stub;		\
+	bne,pn		%icc, ___copy_in_user;		\
 	 nop
 #endif
 
diff --git a/arch/sparc/lib/NGcopy_to_user.S b/arch/sparc/lib/NGcopy_to_user.S
index bf62fc1..ff630dc 100644
--- a/arch/sparc/lib/NGcopy_to_user.S
+++ b/arch/sparc/lib/NGcopy_to_user.S
@@ -28,7 +28,7 @@
 #define PREAMBLE					\
 	rd		%asi, %g1;			\
 	cmp		%g1, ASI_AIUS;			\
-	bne,pn		%icc, memcpy_user_stub;		\
+	bne,pn		%icc, ___copy_in_user;		\
 	 nop
 #endif
 
diff --git a/arch/sparc/lib/U1copy_from_user.S b/arch/sparc/lib/U1copy_from_user.S
index f14efdd..a6ae2ea 100644
--- a/arch/sparc/lib/U1copy_from_user.S
+++ b/arch/sparc/lib/U1copy_from_user.S
@@ -23,7 +23,7 @@
 #define PREAMBLE					\
 	rd		%asi, %g1;			\
 	cmp		%g1, ASI_AIUS;			\
-	bne,pn		%icc, memcpy_user_stub;		\
+	bne,pn		%icc, ___copy_in_user;		\
 	 nop;						\
 
 #include "U1memcpy.S"
diff --git a/arch/sparc/lib/U1copy_to_user.S b/arch/sparc/lib/U1copy_to_user.S
index 59d531b..f4b970e 100644
--- a/arch/sparc/lib/U1copy_to_user.S
+++ b/arch/sparc/lib/U1copy_to_user.S
@@ -23,7 +23,7 @@
 #define PREAMBLE					\
 	rd		%asi, %g1;			\
 	cmp		%g1, ASI_AIUS;			\
-	bne,pn		%icc, memcpy_user_stub;		\
+	bne,pn		%icc, ___copy_in_user;		\
 	 nop;						\
 
 #include "U1memcpy.S"
diff --git a/arch/sparc/lib/U3copy_to_user.S b/arch/sparc/lib/U3copy_to_user.S
index b4cbfe5..ef1e493 100644
--- a/arch/sparc/lib/U3copy_to_user.S
+++ b/arch/sparc/lib/U3copy_to_user.S
@@ -23,7 +23,7 @@
 #define PREAMBLE					\
 	rd		%asi, %g1;			\
 	cmp		%g1, ASI_AIUS;			\
-	bne,pn		%icc, memcpy_user_stub;		\
+	bne,pn		%icc, ___copy_in_user;		\
 	 nop;						\
 
 #include "U3memcpy.S"
diff --git a/arch/sparc/lib/copy_in_user.S b/arch/sparc/lib/copy_in_user.S
index 884f464..302c0e6 100644
--- a/arch/sparc/lib/copy_in_user.S
+++ b/arch/sparc/lib/copy_in_user.S
@@ -3,6 +3,7 @@
  * Copyright (C) 1999, 2000, 2004 David S. Miller (davem@redhat.com)
  */
 
+#include <linux/linkage.h>
 #include <asm/asi.h>
 
 #define XCC xcc
@@ -27,18 +28,7 @@
 	 * to copy register windows around during thread cloning.
 	 */
 
-	.globl		___copy_in_user
-	.type		___copy_in_user,#function
-___copy_in_user:	/* %o0=dst, %o1=src, %o2=len */
-	/* Writing to %asi is _expensive_ so we hardcode it.
-	 * Reading %asi to check for KERNEL_DS is comparatively
-	 * cheap.
-	 */
-	rd		%asi, %g1
-	cmp		%g1, ASI_AIUS
-	bne,pn		%icc, memcpy_user_stub
-	 nop
-
+ENTRY(___copy_in_user)	/* %o0=dst, %o1=src, %o2=len */
 	cmp		%o2, 0
 	be,pn		%XCC, 85f
 	 or		%o0, %o1, %o3
@@ -49,22 +39,24 @@ ___copy_in_user:	/* %o0=dst, %o1=src, %o2=len */
 	/* 16 < len <= 64 */
 	andcc		%o3, 0x7, %g0
 	bne,pn		%XCC, 90f
-	 sub		%o0, %o1, %o3
+	 nop
 
 	andn		%o2, 0x7, %o4
 	and		%o2, 0x7, %o2
 1:	subcc		%o4, 0x8, %o4
 	EX(ldxa [%o1] %asi, %o5)
-	EX(stxa %o5, [%o1 + %o3] ASI_AIUS)
+	EX(stxa %o5, [%o0] %asi)
+	add		%o1, 0x8, %o1
 	bgu,pt		%XCC, 1b
-	 add		%o1, 0x8, %o1
+	 add		%o0, 0x8, %o0
 	andcc		%o2, 0x4, %g0
 	be,pt		%XCC, 1f
 	 nop
 	sub		%o2, 0x4, %o2
 	EX(lduwa [%o1] %asi, %o5)
-	EX(stwa %o5, [%o1 + %o3] ASI_AIUS)
+	EX(stwa %o5, [%o0] %asi)
 	add		%o1, 0x4, %o1
+	add		%o0, 0x4, %o0
 1:	cmp		%o2, 0
 	be,pt		%XCC, 85f
 	 nop
@@ -74,14 +66,15 @@ ___copy_in_user:	/* %o0=dst, %o1=src, %o2=len */
 80:	/* 0 < len <= 16 */
 	andcc		%o3, 0x3, %g0
 	bne,pn		%XCC, 90f
-	 sub		%o0, %o1, %o3
+	 nop
 
 82:
 	subcc		%o2, 4, %o2
 	EX(lduwa [%o1] %asi, %g1)
-	EX(stwa %g1, [%o1 + %o3] ASI_AIUS)
+	EX(stwa %g1, [%o0] %asi)
+	add		%o1, 4, %o1
 	bgu,pt		%XCC, 82b
-	 add		%o1, 4, %o1
+	 add		%o0, 4, %o0
 
 85:	retl
 	 clr		%o0
@@ -90,26 +83,10 @@ ___copy_in_user:	/* %o0=dst, %o1=src, %o2=len */
 90:
 	subcc		%o2, 1, %o2
 	EX(lduba [%o1] %asi, %g1)
-	EX(stba %g1, [%o1 + %o3] ASI_AIUS)
+	EX(stba %g1, [%o0] %asi)
+	add		%o1, 1, %o1
 	bgu,pt		%XCC, 90b
-	 add		%o1, 1, %o1
+	 add		%o0, 1, %o0
 	retl
 	 clr		%o0
-
-	.size		___copy_in_user, .-___copy_in_user
-
-	/* Act like copy_{to,in}_user(), ie. return zero instead
-	 * of original destination pointer.  This is invoked when
-	 * copy_{to,in}_user() finds that %asi is kernel space.
-	 */
-	.globl		memcpy_user_stub
-	.type		memcpy_user_stub,#function
-memcpy_user_stub:
-	save		%sp, -192, %sp
-	mov		%i0, %o0
-	mov		%i1, %o1
-	call		memcpy
-	 mov		%i2, %o2
-	ret
-	 restore	%g0, %g0, %o0
-	.size		memcpy_user_stub, .-memcpy_user_stub
+ENDPROC(___copy_in_user)
-- 
1.6.1.2.253.ga34a

