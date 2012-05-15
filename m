From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 15 May 2012 19:36:51 +0000
Subject: [RFC PATCH 3/3] sparc: introduce arch/sparc/Kbuild
Message-Id: <20120515193651.GC17309@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From 850652644b60709d7eae7d421fa6e18630f2bac8 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 15 May 2012 21:27:15 +0200
Subject: [PATCH 3/3] sparc: introduce arch/sparc/Kbuild

This allows us to do:

    make arch/sparc/

to build the core part of the sparc kernel.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

This will conflict with the BFP work you have in netdev,
but the resolution is trivial.
The assignment to core-y shall be moved
to Kbuild and the "arch/sparc/" part dropped.

RFC due to this known conflict.

	Sam


 arch/sparc/Kbuild   |    8 ++++++++
 arch/sparc/Makefile |    4 ++--
 2 files changed, 10 insertions(+), 2 deletions(-)
 create mode 100644 arch/sparc/Kbuild

diff --git a/arch/sparc/Kbuild b/arch/sparc/Kbuild
new file mode 100644
index 0000000..ff1585e
--- /dev/null
+++ b/arch/sparc/Kbuild
@@ -0,0 +1,8 @@
+#
+# core part of the sparc kernel
+#
+
+obj-y += kernel/
+obj-y += mm/
+obj-y += math-emu/
+
diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index a492815..b9a72e2 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -52,8 +52,8 @@ endif
 head-y                 := arch/sparc/kernel/head_$(BITS).o
 head-y                 += arch/sparc/kernel/init_task.o
 
-core-y                 += arch/sparc/kernel/
-core-y                 += arch/sparc/mm/ arch/sparc/math-emu/
+# See arch/sparc/Kbuild for the core part of the kernel
+core-y                 += arch/sparc/
 
 libs-y                 += arch/sparc/prom/
 libs-y                 += arch/sparc/lib/
-- 
1.6.0.6

