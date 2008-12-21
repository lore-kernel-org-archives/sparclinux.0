From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 21 Dec 2008 20:45:59 +0000
Subject: [PATCH] sparc: fix hardirq.h removal fallout
Message-Id: <20081221204559.GB18284@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

When hardirq.h are removed from asm-generic/local.h a few
bits fails to build.  Fix these upfront.
Reported by Alexey.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
---

When I removed hardirq.h from local.h I had to apply
a similar patch like this to drivers/base/topology.c
but I assume this is dealt with before the removal
hits mainline.

Based on the assumption that the topology.c change
is not sparc specific but I did not test this.

The following changes are sparc specific and needed for
sparc64 when hardirq is removed form local.h.

	Sam

 arch/sparc/kernel/mdesc.c |    1 +
 arch/sparc/kernel/sysfs.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
index dde52bc..3c539a6 100644
--- a/arch/sparc/kernel/mdesc.c
+++ b/arch/sparc/kernel/mdesc.c
@@ -11,6 +11,7 @@
 #include <linux/mm.h>
 #include <linux/miscdevice.h>
 
+#include <asm/cpudata.h>
 #include <asm/hypervisor.h>
 #include <asm/mdesc.h>
 #include <asm/prom.h>
diff --git a/arch/sparc/kernel/sysfs.c b/arch/sparc/kernel/sysfs.c
index 84e5ce1..d28f496 100644
--- a/arch/sparc/kernel/sysfs.c
+++ b/arch/sparc/kernel/sysfs.c
@@ -8,6 +8,7 @@
 #include <linux/percpu.h>
 #include <linux/init.h>
 
+#include <asm/cpudata.h>
 #include <asm/hypervisor.h>
 #include <asm/spitfire.h>
 
-- 
1.6.0.2.GIT

