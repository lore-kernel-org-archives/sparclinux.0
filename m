From: Robert Reif <reif@earthlink.net>
Date: Sun, 12 Oct 2008 03:59:06 +0000
Subject: [PATCH] fix sparc32 build errors
Message-Id: <48F1760A.9030309@earthlink.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------000900070405040200000606"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------000900070405040200000606
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable

arch/sparc/kernel/sun4d_smp.c: In function =91smp4d_callin=92:
arch/sparc/kernel/sun4d_smp.c:101: error: implicit declaration of=20
function =91notify_cpu_starting=92
arch/sparc/kernel/sun4m_smp.c: In function =91smp4m_callin=92:
arch/sparc/kernel/sun4m_smp.c:74: error: implicit declaration of=20
function =91notify_cpu_starting=92

Signed-off-by: Robert Reif <reif@earthlink.net>



--------------000900070405040200000606
Content-Type: text/plain;
 name="cpu.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpu.diff.txt"

diff --git a/arch/sparc/kernel/sun4d_smp.c b/arch/sparc/kernel/sun4d_smp.c
index ce3d45d..7a6a5e7 100644
--- a/arch/sparc/kernel/sun4d_smp.c
+++ b/arch/sparc/kernel/sun4d_smp.c
@@ -20,6 +20,7 @@
 #include <linux/swap.h>
 #include <linux/profile.h>
 #include <linux/delay.h>
+#include <linux/cpu.h>
 
 #include <asm/ptrace.h>
 #include <asm/atomic.h>
diff --git a/arch/sparc/kernel/sun4m_smp.c b/arch/sparc/kernel/sun4m_smp.c
index 0c564ba..5fc386d 100644
--- a/arch/sparc/kernel/sun4m_smp.c
+++ b/arch/sparc/kernel/sun4m_smp.c
@@ -17,6 +17,7 @@
 #include <linux/swap.h>
 #include <linux/profile.h>
 #include <linux/delay.h>
+#include <linux/cpu.h>
 
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>

--------------000900070405040200000606--
