From: Jaejoong Kim <climbbb.kim@gmail.com>
Date: Tue, 04 Sep 2018 02:44:49 +0000
Subject: [PATCH 23/25] tty: vcc: Change return type to void
Message-Id: <1536029091-4426-24-git-send-email-climbbb.kim@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
In-Reply-To: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-um@lists.infradead.org, netdev@vger.kernel.org, linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org, devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org, linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, sparclinux@vger.kernel.org, linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>

Since tty_standard_install() always returns 0, the return type has changed
to void. Now apply this and remove the obsolete error check.

Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
---
 drivers/tty/vcc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index 58b454c..ce32631 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -987,7 +987,6 @@ static int vcc_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	struct vcc_port *port_vcc;
 	struct tty_port *port_tty;
-	int ret;
 
 	if (unlikely(!tty)) {
 		pr_err("VCC: install: Invalid TTY handle\n");
@@ -997,9 +996,7 @@ static int vcc_install(struct tty_driver *driver, struct tty_struct *tty)
 	if (tty->index >= VCC_MAX_PORTS)
 		return -EINVAL;
 
-	ret = tty_standard_install(driver, tty);
-	if (ret)
-		return ret;
+	tty_standard_install(driver, tty);
 
 	port_tty = kzalloc(sizeof(struct tty_port), GFP_KERNEL);
 	if (!port_tty)
-- 
2.7.4
