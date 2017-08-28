From: Bhumika Goyal <bhumirks@gmail.com>
Date: Mon, 28 Aug 2017 18:40:44 +0000
Subject: [PATCH] sparc64: vcc: make ktermios const
Message-Id: <1503944924-28141-1-git-send-email-bhumirks@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: julia.lawall@lip6.fr, davem@davemloft.net, gregkh@linuxfoundation.org, jslaby@suse.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>

Make this const as it is not modified anywhere.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/tty/vcc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index 5e60817..f7e07e1 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -102,7 +102,7 @@ struct vcc_port {
  * add anything that will cause echoing or we'll go into recursive
  * loop echoing chars back and forth with the console drivers.
  */
-static struct ktermios vcc_tty_termios = {
+static const struct ktermios vcc_tty_termios = {
 	.c_iflag = IGNBRK | IGNPAR,
 	.c_oflag = OPOST,
 	.c_cflag = B38400 | CS8 | CREAD | HUPCL,
-- 
1.9.1

