From: David Miller <davem@davemloft.net>
Date: Sun, 21 Sep 2008 07:29:46 +0000
Subject: [PATCH 1/1]: sparc: arch/sparc/kernel/pmc.c -- extra #include?
Message-Id: <20080921.002946.171050386.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I just applied the following patch sent to me privately from David
Brownell to sparc-next-2.6

From: David Brownell <david-b@pacbell.net>

sparc: arch/sparc/kernel/pmc.c -- extra #include?

I have no SPARC compiler handy to verify, but it looks like this
is another file that doesn't need <linux/miscdevices.h> ...

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/pmc.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/pmc.c b/arch/sparc/kernel/pmc.c
index 814eb3c..2afcfab 100644
--- a/arch/sparc/kernel/pmc.c
+++ b/arch/sparc/kernel/pmc.c
@@ -8,7 +8,6 @@
 #include <linux/fs.h>
 #include <linux/errno.h>
 #include <linux/init.h>
-#include <linux/miscdevice.h>
 #include <linux/pm.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -24,7 +23,6 @@
  * #define PMC_NO_IDLE
  */
 
-#define PMC_MINOR	MISC_DYNAMIC_MINOR
 #define PMC_OBPNAME	"SUNW,pmc"
 #define PMC_DEVNAME "pmc"
 
-- 
1.5.6.5

