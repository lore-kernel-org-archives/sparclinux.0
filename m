From: Jiri Slaby <jslaby@suse.cz>
Date: Tue, 02 Mar 2021 06:21:57 +0000
Subject: [PATCH 27/44] tty: vcc, use name strings directly
Message-Id: <20210302062214.29627-27-jslaby@suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <20210302062214.29627-1-jslaby@suse.cz>
In-Reply-To: <20210302062214.29627-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Do not define global variables for driver/device names, use the strings
directly.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 drivers/tty/vcc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index 31b8a9a77375..a6cdbd170a61 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -52,8 +52,6 @@ struct vcc_port {
 #define VCC_CTL_BREAK		-1
 #define VCC_CTL_HUP		-2
 
-static const char vcc_driver_name[] = "vcc";
-static const char vcc_device_node[] = "vcc";
 static struct tty_driver *vcc_tty_driver;
 
 static struct vcc_port *vcc_table[VCC_MAX_PORTS];
@@ -1065,8 +1063,8 @@ static int vcc_tty_init(void)
 		return PTR_ERR(vcc_tty_driver);
 	}
 
-	vcc_tty_driver->driver_name = vcc_driver_name;
-	vcc_tty_driver->name = vcc_device_node;
+	vcc_tty_driver->driver_name = "vcc";
+	vcc_tty_driver->name = "vcc";
 
 	vcc_tty_driver->minor_start = VCC_MINOR_START;
 	vcc_tty_driver->type = TTY_DRIVER_TYPE_SYSTEM;
-- 
2.30.1
