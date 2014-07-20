From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 Jul 2014 11:38:58 +0000
Subject: [PATCH 1/6] sparcspkr: use sbus_*() primitives for IO
Message-Id: <1405856343-3762-1-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The memory are mapped using of_ioremap() which is
an indication this is sbus memory.
Shift all uses of inb/outb to the sbus variants.

The inb/outb methods uses ASI_PHYS_BYPASS_EC_E_L,
whereas sbus_ variants uses ASI_PHYS_BYPASS_EC_E.

The difference is if the reads/writes are done in
native or little endian.
But for byte reads/writes there is no difference
so this does not matter for inb/outb - and this
driver only uses the byte variants.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/input/misc/sparcspkr.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/input/misc/sparcspkr.c b/drivers/input/misc/sparcspkr.c
index 65fd315..179ff1c 100644
--- a/drivers/input/misc/sparcspkr.c
+++ b/drivers/input/misc/sparcspkr.c
@@ -86,13 +86,13 @@ static int bbc_spkr_event(struct input_dev *dev, unsigned int type, unsigned int
 	spin_lock_irqsave(&state->lock, flags);
 
 	if (count) {
-		outb(0x01,                 info->regs + 0);
-		outb(0x00,                 info->regs + 2);
-		outb((count >> 16) & 0xff, info->regs + 3);
-		outb((count >>  8) & 0xff, info->regs + 4);
-		outb(0x00,                 info->regs + 5);
+		sbus_writeb(0x01,                 info->regs + 0);
+		sbus_writeb(0x00,                 info->regs + 2);
+		sbus_writeb((count >> 16) & 0xff, info->regs + 3);
+		sbus_writeb((count >>  8) & 0xff, info->regs + 4);
+		sbus_writeb(0x00,                 info->regs + 5);
 	} else {
-		outb(0x00,                 info->regs + 0);
+		sbus_writeb(0x00,                 info->regs + 0);
 	}
 
 	spin_unlock_irqrestore(&state->lock, flags);
@@ -123,15 +123,15 @@ static int grover_spkr_event(struct input_dev *dev, unsigned int type, unsigned
 
 	if (count) {
 		/* enable counter 2 */
-		outb(inb(info->enable_reg) | 3, info->enable_reg);
+		sbus_writeb(sbus_readb(info->enable_reg) | 3, info->enable_reg);
 		/* set command for counter 2, 2 byte write */
-		outb(0xB6, info->freq_regs + 1);
+		sbus_writeb(0xB6, info->freq_regs + 1);
 		/* select desired HZ */
-		outb(count & 0xff, info->freq_regs + 0);
-		outb((count >> 8) & 0xff, info->freq_regs + 0);
+		sbus_writeb(count & 0xff, info->freq_regs + 0);
+		sbus_writeb((count >> 8) & 0xff, info->freq_regs + 0);
 	} else {
 		/* disable counter 2 */
-		outb(inb_p(info->enable_reg) & 0xFC, info->enable_reg);
+		sbus_writeb(sbus_readb(info->enable_reg) & 0xFC, info->enable_reg);
 	}
 
 	spin_unlock_irqrestore(&state->lock, flags);
-- 
1.9.3

