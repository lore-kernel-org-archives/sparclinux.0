From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Thu, 14 Jan 2021 17:57:17 +0000
Subject: [PATCH 2/3] tty: vcc: Drop unnecessary if block
Message-Id: <20210114175718.137483-3-u.kleine-koenig@pengutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20210114175718.137483-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20210114175718.137483-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Cc: sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "David S . Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

If vcc_probe() succeeded dev_set_drvdata() is called with a non-NULL
value, and if vcc_probe() failed vcc_remove() isn't called.

So there is no way dev_get_drvdata() can return NULL in vcc_remove() and
the check can just go away.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/vcc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index 9ffd42e333b8..d9b0dc6deae9 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -681,9 +681,6 @@ static int vcc_remove(struct vio_dev *vdev)
 {
 	struct vcc_port *port =3D dev_get_drvdata(&vdev->dev);
=20
-	if (!port)
-		return -ENODEV;
-
 	del_timer_sync(&port->rx_timer);
 	del_timer_sync(&port->tx_timer);
=20
--=20
2.29.2
