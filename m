From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Thu, 14 Jan 2021 17:57:16 +0000
Subject: [PATCH 1/3] tty: hvcs: Drop unnecessary if block
Message-Id: <20210114175718.137483-2-u.kleine-koenig@pengutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20210114175718.137483-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20210114175718.137483-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Cc: sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "David S . Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

If hvcs_probe() succeeded dev_set_drvdata() is called with a non-NULL
value, and if hvcs_probe() failed hvcs_remove() isn't called.

So there is no way dev_get_drvdata() can return NULL in hvcs_remove() and
the check can just go away.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/hvc/hvcs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index 509d1042825a..3e0461285c34 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -825,9 +825,6 @@ static int hvcs_remove(struct vio_dev *dev)
 	unsigned long flags;
 	struct tty_struct *tty;
=20
-	if (!hvcsd)
-		return -ENODEV;
-
 	/* By this time the vty-server won't be getting any more interrupts */
=20
 	spin_lock_irqsave(&hvcsd->lock, flags);
--=20
2.29.2
