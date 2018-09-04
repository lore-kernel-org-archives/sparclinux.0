From: Jaejoong Kim <climbbb.kim@gmail.com>
Date: Tue, 04 Sep 2018 02:44:39 +0000
Subject: [PATCH 13/25] usb: xhci: dbc: Change return type to void
Message-Id: <1536029091-4426-14-git-send-email-climbbb.kim@gmail.com>
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
 drivers/usb/host/xhci-dbgtty.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index aff79ff..18d661c 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -174,8 +174,9 @@ static int dbc_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 	struct dbc_port		*port = driver->driver_state;
 
 	tty->driver_data = port;
+	tty_port_install(&port->port, driver, tty);
 
-	return tty_port_install(&port->port, driver, tty);
+	return 0;
 }
 
 static int dbc_tty_open(struct tty_struct *tty, struct file *file)
-- 
2.7.4
