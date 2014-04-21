From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 Apr 2014 17:12:31 +0000
Subject: [PATCH 19/24] sparc: fix sparse warnings in of_device_common.c
Message-Id: <1398100356-19794-19-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warnings (both sparc32 and sparc64):
of_device_common.c:13:14: warning: symbol 'irq_of_parse_and_map' was not declared. Should it be static?
of_device_common.c:24:5: warning: symbol 'of_address_to_resource' was not declared. Should it be static?
of_device_common.c:37:14: warning: symbol 'of_iomap' was not declared. Should it be static?

Add missing includes.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/of_device_common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/of_device_common.c b/arch/sparc/kernel/of_device_common.c
index 3241f56..de0ee39 100644
--- a/arch/sparc/kernel/of_device_common.c
+++ b/arch/sparc/kernel/of_device_common.c
@@ -5,8 +5,10 @@
 #include <linux/mod_devicetable.h>
 #include <linux/errno.h>
 #include <linux/irq.h>
-#include <linux/of_device.h>
 #include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
 
 #include "of_device_common.h"
 
-- 
1.8.3.1

