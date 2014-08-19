From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@laposte.net>
Date: Tue, 19 Aug 2014 21:09:37 +0000
Subject: [PATCH] sparc: i8042-sparcio.h: fix unused kbd_res warning
Message-Id: <1408482577-17837-1-git-send-email-vincent.stehle@laposte.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, sparclinux@vger.kernel.org
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@laposte.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "David S. Miller" <davem@davemloft.net>

kbd_res is used only when CONFIG_PCI is defined; condition its declaration as
well. This fixes the following compilation warning:

  drivers/input/serio/i8042-sparcio.h:20:25: warning: ‘kbd_res’ defined but not used [-Wunused-variable]

Signed-off-by: Vincent Stehlé <vincent.stehle@laposte.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
---

Hi,

This can be seen with e.g. sparc alldefconfig.

Best regards,

V.

 drivers/input/serio/i8042-sparcio.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/serio/i8042-sparcio.h b/drivers/input/serio/i8042-sparcio.h
index d6aa4c6..93cb791 100644
--- a/drivers/input/serio/i8042-sparcio.h
+++ b/drivers/input/serio/i8042-sparcio.h
@@ -17,7 +17,6 @@ static int i8042_aux_irq = -1;
 #define I8042_MUX_PHYS_DESC "sparcps2/serio%d"
 
 static void __iomem *kbd_iobase;
-static struct resource *kbd_res;
 
 #define I8042_COMMAND_REG	(kbd_iobase + 0x64UL)
 #define I8042_DATA_REG		(kbd_iobase + 0x60UL)
@@ -44,6 +43,8 @@ static inline void i8042_write_command(int val)
 
 #ifdef CONFIG_PCI
 
+static struct resource *kbd_res;
+
 #define OBP_PS2KBD_NAME1	"kb_ps2"
 #define OBP_PS2KBD_NAME2	"keyboard"
 #define OBP_PS2MS_NAME1		"kdmouse"
-- 
2.1.0.rc1

