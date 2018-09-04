From: Jaejoong Kim <climbbb.kim@gmail.com>
Date: Tue, 04 Sep 2018 02:44:35 +0000
Subject: [PATCH 09/25] tty: serial: kgdb_nmi: Change return type to void
Message-Id: <1536029091-4426-10-git-send-email-climbbb.kim@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
In-Reply-To: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-um@lists.infradead.org, netdev@vger.kernel.org, linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org, devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org, linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, sparclinux@vger.kernel.org, linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>

Since tty_port_install() always returns 0, the return type has changed
to void. Now apply this and remove the obsolete error check.

Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
---
 drivers/tty/serial/kgdb_nmi.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/tty/serial/kgdb_nmi.c b/drivers/tty/serial/kgdb_nmi.c
index 4029272..ed8f806 100644
--- a/drivers/tty/serial/kgdb_nmi.c
+++ b/drivers/tty/serial/kgdb_nmi.c
@@ -234,7 +234,6 @@ static const struct tty_port_operations kgdb_nmi_tty_port_ops = {
 static int kgdb_nmi_tty_install(struct tty_driver *drv, struct tty_struct *tty)
 {
 	struct kgdb_nmi_tty_priv *priv;
-	int ret;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -245,17 +244,9 @@ static int kgdb_nmi_tty_install(struct tty_driver *drv, struct tty_struct *tty)
 	tty_port_init(&priv->port);
 	priv->port.ops = &kgdb_nmi_tty_port_ops;
 	tty->driver_data = priv;
+	tty_port_install(&priv->port, drv, tty);
 
-	ret = tty_port_install(&priv->port, drv, tty);
-	if (ret) {
-		pr_err("%s: can't install tty port: %d\n", __func__, ret);
-		goto err;
-	}
 	return 0;
-err:
-	tty_port_destroy(&priv->port);
-	kfree(priv);
-	return ret;
 }
 
 static void kgdb_nmi_tty_cleanup(struct tty_struct *tty)
-- 
2.7.4
