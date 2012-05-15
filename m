From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 15 May 2012 20:14:32 +0000
Subject: [PATCH] sparc: remove obsolete documentation
Message-Id: <20120515201432.GA32383@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From d79758c663e3b71f705b3d7935ba24a14620ead7 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 15 May 2012 22:10:22 +0200
Subject: [PATCH] sparc: remove obsolete documentation

When we killed btfixup this readme no longer has any value.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

This should have been in previous batch of patches.
But I forgot about it again.

There is nothing of value in this document anymore,
and I did not see any benefit writing up something.

I assume git will delete the directory - at least it did so
at my side.

	Sam

 Documentation/sparc/README-2.5 |   46 ----------------------------------------
 1 files changed, 0 insertions(+), 46 deletions(-)
 delete mode 100644 Documentation/sparc/README-2.5

diff --git a/Documentation/sparc/README-2.5 b/Documentation/sparc/README-2.5
deleted file mode 100644
index 806fe49..0000000
--- a/Documentation/sparc/README-2.5
+++ /dev/null
@@ -1,46 +0,0 @@
-BTFIXUP
--------
-
-To build new kernels you have to issue "make image". The ready kernel
-in ELF format is placed in arch/sparc/boot/image. Explanation is below.
-
-BTFIXUP is a unique feature of Linux/sparc among other architectures,
-developed by Jakub Jelinek (I think... Obviously David S. Miller took
-part, too). It allows to boot the same kernel at different 
-sub-architectures, such as sun4c, sun4m, sun4d, where SunOS uses
-different kernels. This feature is convinient for people who you move
-disks between boxes and for distrution builders.
-
-To function, BTFIXUP must link the kernel "in the draft" first,
-analyze the result, write a special stub code based on that, and
-build the final kernel with the stub (btfix.o).
-
-Kai Germaschewski improved the build system of the kernel in the 2.5 series
-significantly. Unfortunately, the traditional way of running the draft
-linking from architecture specific Makefile before the actual linking
-by generic Makefile is nearly impossible to support properly in the
-new build system. Therefore, the way we integrate BTFIXUP with the
-build system was changed in 2.5.40. Now, generic Makefile performs
-the draft linking and stores the result in file vmlinux. Architecture
-specific post-processing invokes BTFIXUP machinery and final linking
-in the same way as other architectures do bootstraps.
-
-Implications of that change are as follows.
-
-1. Hackers must type "make image" now, instead of just "make", in the same
-   way as s390 people do now. It is analogous to "make bzImage" on i386.
-   This does NOT affect sparc64, you continue to use "make" to build sparc64
-   kernels.
-
-2. vmlinux is not the final kernel, so RPM builders have to adjust
-   their spec files (if they delivered vmlinux for debugging).
-   System.map generated for vmlinux is still valid.
-
-3. Scripts that produce a.out images have to be changed. First, if they
-   invoke make, they have to use "make image". Second, they have to pick up
-   the new kernel in arch/sparc/boot/image instead of vmlinux.
-
-4. Since we are compliant with Kai's build system now, make -j is permitted.
-
--- Pete Zaitcev
-zaitcev@yahoo.com
-- 
1.6.0.6

