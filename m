From: Jaejoong Kim <climbbb.kim@gmail.com>
Date: Tue, 04 Sep 2018 02:44:30 +0000
Subject: [PATCH 04/25] s390: char: tty3270: Change return type to void
Message-Id: <1536029091-4426-5-git-send-email-climbbb.kim@gmail.com>
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
 drivers/s390/char/tty3270.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
index 5b8af27..2915f95 100644
--- a/drivers/s390/char/tty3270.c
+++ b/drivers/s390/char/tty3270.c
@@ -1017,12 +1017,7 @@ static int tty3270_install(struct tty_driver *driver, struct tty_struct *tty)
 	raw3270_activate_view(&tp->view);
 
 port_install:
-	rc = tty_port_install(&tp->port, driver, tty);
-	if (rc) {
-		raw3270_put_view(&tp->view);
-		return rc;
-	}
-
+	tty_port_install(&tp->port, driver, tty);
 	tty->driver_data = tp;
 
 	return 0;
-- 
2.7.4
