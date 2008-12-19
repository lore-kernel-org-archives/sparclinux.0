From: Chris Torek <chris.torek@windriver.com>
Date: Fri, 19 Dec 2008 02:08:57 +0000
Subject: replace incorrect memcpy_user_stub code
Message-Id: <200812190208.mBJ28vn13713@elf.torek.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I'll send this formatted against the old kernel, not sparc-next
(did get the latter all cloned up, but have not yet started working
with it).

This came up in testing kgdb, using the built-in tests -- turn
on CONFIG_KGDB_TESTS, then

    echo V1 > /sys/module/kgdbts/parameters/kgdbts

-- but it would affect using kgdb if you were debugging and looking
at bad pointers.

You will probably want to tweak it anyway (especially the comment
in the .S file: I thought use of KERNEL_DS was more rare than it
is, though it probably *should* be more rare than it is...).

Something else I noticed in passing: the EX and EX_LD/EX_ST macros
scattered throughout the various .S files make a fair bit of .fixup
code, all of which does the same thing.  At the cost of one symbol
in copy_in_user.S, you could just have one common two-instruction
retl-and-mov-1 fixup that they all share.

Note: I still get occasional

    CPU[2]: Returns from cpu_idle!

(the cpu number changes) doing the internal kgdb tests, so something
else is still not quite right.

Chris

From 59ec5fee8a6db009086e186468961586aec1c97c Mon Sep 17 00:00:00 2001
From: Chris Torek <chris.torek@windriver.com>
Date: Thu, 18 Dec 2008 18:07:45 -0700
Subject: [PATCH 1/1] replace incorrect memcpy_user_stub code

The memcpy_user_stub function is used when a copy to/from user call
is made with the "user" space revectored to point to kernel space.
This makes it almost the same as memcpy, but different in two ways,
including the return value: copy from/to user returns zero on success,
but nonzero on failure, including failures due to bad addresses.
The kernel probe-read / probe-write routines do this to access
addresses supplied by kgdb, so that bad pointers can be caught.
The existing stub simply called memcpy, then returned 0; bad pointers
resulted in a kernel panic.  We now use the same exception catching
mechanism as for regular user-space copies.

It might seem ideal to make a duplicate of memcpy but with exception
catching added, but there are numerous optimized memcpy variants, with
boot-time patching to use the best one; we would have to duplicate
all of them, and add more boot-time patching.  This routine is used
rarely, and mostly for debugging and compatibility code, so I just
put in a small, simple, and obviously correct version.

Signed-off-by: Chris Torek <chris.torek@windriver.com>
---
 arch/sparc64/lib/copy_in_user.S |   23 ++++++++++++++++-------
 1 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/sparc64/lib/copy_in_user.S b/arch/sparc64/lib/copy_in_user.S
index 650af3f..ba91c3e 100644
--- a/arch/sparc64/lib/copy_in_user.S
+++ b/arch/sparc64/lib/copy_in_user.S
@@ -105,15 +105,24 @@ ___copy_in_user:	/* %o0=dst, %o1=src, %o2=len */
 	/* Act like copy_{to,in}_user(), ie. return zero instead
 	 * of original destination pointer.  This is invoked when
 	 * copy_{to,in}_user() finds that %asi is kernel space.
+	 *
+	 * We can't quite use memcpy directly since we are supposed
+	 * to return nonzero on faults.  Could optimize these, but
+	 * this is used extremely rarely (probe_kernel_read/write).
 	 */
 	.globl		memcpy_user_stub
 	.type		memcpy_user_stub,#function
 memcpy_user_stub:
-	save		%sp, -192, %sp
-	mov		%i0, %o0
-	mov		%i1, %o1
-	call		memcpy
-	 mov		%i2, %o2
-	ret
-	 restore	%g0, %g0, %o0
+	brz,pn		%o2, 2f
+	 clr		%o3
+1:
+	EX(ldub [%o1 + %o3], %g1)
+	EX(stb %g1, [%o0 + %o3])
+	deccc		%o2
+	bgu,pt		%XCC, 1b
+	 inc		%o3
+2:
+	retl
+	 clr		%o0
+
 	.size		memcpy_user_stub, .-memcpy_user_stub
-- 
1.6.0.4.766.g6fc4a

