From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Sat, 26 Aug 2017 06:12:05 +0000
Subject: [PATCH sparc-next] sparc64: vcc: Check for IS_ERR() instead of NULL
Message-Id: <20170826061205.nkfvekwgzpfgfuhh@mwanda>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

The tty_alloc_driver() function never returns NULL, it returns error
pointers on error.

Fixes: ce808b746325 ("sparc64: vcc: TTY driver initialization and cleanup")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index 5e608173b091..716729129e01 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -1086,9 +1086,9 @@ static int vcc_tty_init(void)
 	pr_info("VCC: %s\n", version);
 
 	vcc_tty_driver = tty_alloc_driver(VCC_MAX_PORTS, VCC_TTY_FLAGS);
-	if (!vcc_tty_driver) {
+	if (IS_ERR(vcc_tty_driver)) {
 		pr_err("VCC: TTY driver alloc failed\n");
-		return -ENOMEM;
+		return PTR_ERR(vcc_tty_driver);
 	}
 
 	vcc_tty_driver->driver_name = vcc_driver_name;
