From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 12 May 2012 18:04:09 +0000
Subject: [PATCH 1/5] sparc32: fix warning in floopy glue
Message-Id: <1336845853-30388-1-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warning:
arch/sparc/include/asm/floppy_32.h:342:5: warning: 'op' may be used uninitialized in this function

The warning are legitimite and we can end up using op uninitialized.
This fixes build with my gcc on UP.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/floppy_32.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/floppy_32.h b/arch/sparc/include/asm/floppy_32.h
index f954856..491eb68 100644
--- a/arch/sparc/include/asm/floppy_32.h
+++ b/arch/sparc/include/asm/floppy_32.h
@@ -334,6 +334,7 @@ static int sun_floppy_init(void)
 	/* Look up irq in platform_device.
 	 * We try "SUNW,fdtwo" and "fd"
 	 */
+	op = NULL;
 	for_each_node_by_name(dp, "SUNW,fdtwo") {
 		op = of_find_device_by_node(dp);
 		if (op)
-- 
1.6.0.6

