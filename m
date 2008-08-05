From: Alexander Beregalov <a.beregalov@gmail.com>
Date: Tue, 05 Aug 2008 21:18:37 +0000
Subject: [PATCH] sparc: serio/i8042-sparcio.h: fix warning
Message-Id: <20080805211837.GE17320@orion>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Alexander Beregalov <a.beregalov@gmail.com>

sparc: i8042-sparcio.h: fix warning

drivers/input/serio/i8042-sparcio.h:95: warning: 'sparc_i8042_driver'
defined but not used

Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---

 drivers/input/serio/i8042-sparcio.h |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/input/serio/i8042-sparcio.h b/drivers/input/serio/i8042-sparcio.h
index d9ca558..66bafe3 100644
--- a/drivers/input/serio/i8042-sparcio.h
+++ b/drivers/input/serio/i8042-sparcio.h
@@ -41,6 +41,8 @@ static inline void i8042_write_command(int val)
 	writeb(val, kbd_iobase + 0x64UL);
 }
 
+#ifdef CONFIG_PCI
+
 #define OBP_PS2KBD_NAME1	"kb_ps2"
 #define OBP_PS2KBD_NAME2	"keyboard"
 #define OBP_PS2MS_NAME1		"kdmouse"
@@ -101,9 +103,6 @@ static struct of_platform_driver sparc_i8042_driver = {
 
 static int __init i8042_platform_init(void)
 {
-#ifndef CONFIG_PCI
-	return -ENODEV;
-#else
 	struct device_node *root = of_find_node_by_path("/");
 
 	if (!strcmp(root->name, "SUNW,JavaStation-1")) {
@@ -131,17 +130,25 @@ static int __init i8042_platform_init(void)
 	i8042_reset = 1;
 
 	return 0;
-#endif /* CONFIG_PCI */
 }
 
 static inline void i8042_platform_exit(void)
 {
-#ifdef CONFIG_PCI
 	struct device_node *root = of_find_node_by_path("/");
 
 	if (strcmp(root->name, "SUNW,JavaStation-1"))
 		of_unregister_driver(&sparc_i8042_driver);
-#endif
 }
 
+#else /* !CONFIG_PCI */
+static int __init i8042_platform_init(void)
+{
+	return -ENODEV;
+}
+
+static inline void i8042_platform_exit(void)
+{
+}
+#endif /* !CONFIG_PCI */
+
 #endif /* _I8042_SPARCIO_H */
