From: Jaejoong Kim <climbbb.kim@gmail.com>
Date: Tue, 04 Sep 2018 02:44:42 +0000
Subject: [PATCH 16/25] isdn: capi: Change return type to void
Message-Id: <1536029091-4426-17-git-send-email-climbbb.kim@gmail.com>
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
 drivers/isdn/capi/capi.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
index ef5560b..08daf3a 100644
--- a/drivers/isdn/capi/capi.c
+++ b/drivers/isdn/capi/capi.c
@@ -999,13 +999,11 @@ static int
 capinc_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	struct capiminor *mp = capiminor_get(tty->index);
-	int ret = tty_standard_install(driver, tty);
 
-	if (ret = 0)
-		tty->driver_data = mp;
-	else
-		capiminor_put(mp);
-	return ret;
+	tty_standard_install(driver, tty);
+	tty->driver_data = mp;
+
+	return 0;
 }
 
 static void capinc_tty_cleanup(struct tty_struct *tty)
-- 
2.7.4
