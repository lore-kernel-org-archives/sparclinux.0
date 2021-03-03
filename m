From: <gregkh@linuxfoundation.org>
Date: Wed, 03 Mar 2021 19:17:55 +0000
Subject: patch "tty: vcc, drop version dump" added to tty-testing
Message-Id: <16147990751818@kroah.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    tty: vcc, drop version dump

to my tty git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
in the tty-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the tty-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 43b849968559a1671fb313e271b0176d741d3a4c Mon Sep 17 00:00:00 2001
From: Jiri Slaby <jslaby@suse.cz>
Date: Tue, 2 Mar 2021 07:21:56 +0100
Subject: tty: vcc, drop version dump

The version number is artificial, no need to dump it to logs during
initialization.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: <sparclinux@vger.kernel.org>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Link: https://lore.kernel.org/r/20210302062214.29627-26-jslaby@suse.cz
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/vcc.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index 50bf9011a0c4..31b8a9a77375 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -14,16 +14,9 @@
 #include <asm/vio.h>
 #include <asm/ldc.h>
 
-#define DRV_MODULE_NAME		"vcc"
-#define DRV_MODULE_VERSION	"1.1"
-#define DRV_MODULE_RELDATE	"July 1, 2017"
-
-static char version[] -	DRV_MODULE_NAME ".c:v" DRV_MODULE_VERSION " (" DRV_MODULE_RELDATE ")";
-
 MODULE_DESCRIPTION("Sun LDOM virtual console concentrator driver");
 MODULE_LICENSE("GPL");
-MODULE_VERSION(DRV_MODULE_VERSION);
+MODULE_VERSION("1.1");
 
 struct vcc_port {
 	struct vio_driver_state vio;
@@ -1066,8 +1059,6 @@ static int vcc_tty_init(void)
 {
 	int rv;
 
-	pr_info("VCC: %s\n", version);
-
 	vcc_tty_driver = tty_alloc_driver(VCC_MAX_PORTS, VCC_TTY_FLAGS);
 	if (IS_ERR(vcc_tty_driver)) {
 		pr_err("VCC: TTY driver alloc failed\n");
-- 
2.30.1
