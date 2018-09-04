From: Jaejoong Kim <climbbb.kim@gmail.com>
Date: Tue, 04 Sep 2018 02:44:40 +0000
Subject: [PATCH 14/25] Bluetooth: Change return type to void
Message-Id: <1536029091-4426-15-git-send-email-climbbb.kim@gmail.com>
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
 net/bluetooth/rfcomm/tty.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 5e44d84..b654420 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -710,7 +710,6 @@ static int rfcomm_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	struct rfcomm_dev *dev;
 	struct rfcomm_dlc *dlc;
-	int err;
 
 	dev = rfcomm_dev_get(tty->index);
 	if (!dev)
@@ -725,11 +724,7 @@ static int rfcomm_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 	set_bit(RFCOMM_TTY_ATTACHED, &dev->flags);
 
 	/* install the tty_port */
-	err = tty_port_install(&dev->port, driver, tty);
-	if (err) {
-		rfcomm_tty_cleanup(tty);
-		return err;
-	}
+	tty_port_install(&dev->port, driver, tty);
 
 	/* take over the tty_port reference if the port was created with the
 	 * flag RFCOMM_RELEASE_ONHUP. This will force the release of the port
-- 
2.7.4
