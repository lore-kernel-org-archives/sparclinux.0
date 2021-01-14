From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Thu, 14 Jan 2021 17:57:18 +0000
Subject: [PATCH 3/3] tty: vcc: Drop impossible to hit WARN_ON
Message-Id: <20210114175718.137483-4-u.kleine-koenig@pengutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20210114175718.137483-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20210114175718.137483-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Cc: sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "David S . Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

vcc_get() returns the port that has provided port->index. As the port that
is about to be removed isn't removed yet this trivially will find this
port. So simplify the call to not assign an identical value to the port
pointer and drop the warning that is never hit.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/vcc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index d9b0dc6deae9..e2d6205f83ce 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -692,12 +692,9 @@ static int vcc_remove(struct vio_dev *vdev)
 		tty_vhangup(port->tty);
=20
 	/* Get exclusive reference to VCC, ensures that there are no other
-	 * clients to this port
+	 * clients to this port. This cannot fail.
 	 */
-	port =3D vcc_get(port->index, true);
-
-	if (WARN_ON(!port))
-		return -ENODEV;
+	vcc_get(port->index, true);
=20
 	tty_unregister_device(vcc_tty_driver, port->index);
=20
--=20
2.29.2
