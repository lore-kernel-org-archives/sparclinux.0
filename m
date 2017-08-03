From: Jag Raman <jag.raman@oracle.com>
Date: Thu, 03 Aug 2017 17:44:03 +0000
Subject: [PATCH v1 11/13] sparc64: vcc: Add chars_in_buffer TTY operation
Message-Id: <cb633075e4a55aaf2f93546687ef96f77cdeec95.1501781770.git.jag.raman@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Add handler to support TTY chars_in_buffer operation

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/tty/vcc.c |   34 +++++++++++++++++++++++++++++-----
 1 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index e6aa35c..f7325f8 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -936,12 +936,36 @@ static int vcc_write_room(struct tty_struct *tty)
 	return num;
 }
 
+static int vcc_chars_in_buffer(struct tty_struct *tty)
+{
+	struct vcc_port *port;
+	u64 num;
+
+	if (unlikely(!tty)) {
+		pr_err("VCC: chars_in_buffer: Invalid TTY handle\n");
+		return -ENXIO;
+	}
+
+	port = vcc_get_ne(tty->index);
+	if (unlikely(!port)) {
+		pr_err("VCC: chars_in_buffer: Failed to find VCC port\n");
+		return -ENODEV;
+	}
+
+	num = port->chars_in_buffer;
+
+	vcc_put(port, false);
+
+	return num;
+}
+
 static const struct tty_operations vcc_ops = {
-	.open		= vcc_open,
-	.close		= vcc_close,
-	.hangup		= vcc_hangup,
-	.write		= vcc_write,
-	.write_room	= vcc_write_room,
+	.open			= vcc_open,
+	.close			= vcc_close,
+	.hangup			= vcc_hangup,
+	.write			= vcc_write,
+	.write_room		= vcc_write_room,
+	.chars_in_buffer	= vcc_chars_in_buffer,
 };
 
 #define VCC_TTY_FLAGS   (TTY_DRIVER_DYNAMIC_DEV | TTY_DRIVER_REAL_RAW)
-- 
1.7.1

