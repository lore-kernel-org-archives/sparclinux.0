From: Bill Pemberton <wfp5p@virginia.edu>
Date: Mon, 19 Nov 2012 18:24:54 +0000
Subject: [PATCH 345/493] sparc: remove use of __devinitdata
Message-Id: <1353349642-3677-345-git-send-email-wfp5p@virginia.edu>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devinitdata is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: "David S. Miller" <davem@davemloft.net> 
Cc: sparclinux@vger.kernel.org 
---
 arch/sparc/kernel/apc.c | 2 +-
 arch/sparc/kernel/ds.c  | 2 +-
 arch/sparc/kernel/ldc.c | 2 +-
 arch/sparc/mm/init_64.c | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/kernel/apc.c b/arch/sparc/kernel/apc.c
index 6bb8de6..348fa1a 100644
--- a/arch/sparc/kernel/apc.c
+++ b/arch/sparc/kernel/apc.c
@@ -31,7 +31,7 @@
 #define APC_DEVNAME "apc"
 
 static u8 __iomem *regs;
-static int apc_no_idle __devinitdata = 0;
+static int apc_no_idle = 0;
 
 #define apc_readb(offs)		(sbus_readb(regs+offs))
 #define apc_writeb(val, offs) 	(sbus_writeb(val, regs+offs))
diff --git a/arch/sparc/kernel/ds.c b/arch/sparc/kernel/ds.c
index 2f30f5a..b218331 100644
--- a/arch/sparc/kernel/ds.c
+++ b/arch/sparc/kernel/ds.c
@@ -29,7 +29,7 @@
 #define DRV_MODULE_VERSION	"1.0"
 #define DRV_MODULE_RELDATE	"Jul 11, 2007"
 
-static char version[] __devinitdata +static char version[]  	DRV_MODULE_NAME ".c:v" DRV_MODULE_VERSION " (" DRV_MODULE_RELDATE ")\n";
 MODULE_AUTHOR("David S. Miller (davem@davemloft.net)");
 MODULE_DESCRIPTION("Sun LDOM domain services driver");
diff --git a/arch/sparc/kernel/ldc.c b/arch/sparc/kernel/ldc.c
index 81d92fc..9fcc6b4 100644
--- a/arch/sparc/kernel/ldc.c
+++ b/arch/sparc/kernel/ldc.c
@@ -27,7 +27,7 @@
 #define DRV_MODULE_VERSION	"1.1"
 #define DRV_MODULE_RELDATE	"July 22, 2008"
 
-static char version[] __devinitdata +static char version[]  	DRV_MODULE_NAME ".c:v" DRV_MODULE_VERSION " (" DRV_MODULE_RELDATE ")\n";
 #define LDC_PACKET_SIZE		64
 
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index e035e3e..c3b7242 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -87,8 +87,8 @@ static unsigned long cpu_pgsz_mask;
 
 #define MAX_BANKS	32
 
-static struct linux_prom64_registers pavail[MAX_BANKS] __devinitdata;
-static int pavail_ents __devinitdata;
+static struct linux_prom64_registers pavail[MAX_BANKS];
+static int pavail_ents;
 
 static int cmp_p64(const void *a, const void *b)
 {
-- 
1.8.0

