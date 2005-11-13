From: Christopher Zimmermann <madroach@zakweb.de>
Date: Sun, 13 Nov 2005 19:31:44 +0000
Subject: Sun mouse using 5-byte MSC protocol
Message-Id: <20051113193144.GA3039@sparc>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I asked this question already two months ago.
Maybe now someone has an idea.

I use a Sun mouse which sends 5-byte MSC packets instead of the normal
3-byte ones. The current sermouse driver just drops the last two bytes
making the cursor move slow. I changed the driver to switch to the
5-byte protocol after dropping too many bytes.
Maybe someone knows a better method of probing for such mice. Please let
me know.
Unfortunately I don't have any "real" sun mouse sending 3-byte packets;
therefore I could not test if my modifications breaks support for those
sun mice.

Christopher

--- linux-2.6.15-rc1.orig/drivers/input/mouse/sermouse.c	2005-11-13 19:51:38.000000000 +0100
+++ linux-2.6.15-rc1/drivers/input/mouse/sermouse.c	2005-11-13 20:07:37.000000000 +0100
@@ -60,6 +60,16 @@
  * sermouse_process_msc() analyzes the incoming MSC/Sun bytestream and
  * applies some prediction to the data, resulting in 96 updates per
  * second, which is as good as a PS/2 or USB mouse.
+ * The first byte of the MSC protocol contains the button state of the
+ * mouse and has a certain format. If we expect the mouse button state
+ * byte, but receive one which doesn't look like one, we drop it.
+ * There are two variations of the MSC protocol for Sun mice. Some use
+ * a 3-byte protocol (SERIO_SUN), others use a 5-byte protocol (SERIO_MSC).
+ * First we try the 3-byte protocol. If the mouse uses a 5-byte one,
+ * the last two bytes will be dropped as bad bytes resulting in a slower
+ * mouse motion.
+ * If we receive more bad button state bytes than good ones, we will
+ * switch to the 5-byte protocol.
  */
 
 static void sermouse_process_msc(struct sermouse *sermouse, signed char data, struct pt_regs *regs)
@@ -67,12 +77,32 @@
 	struct input_dev *dev = sermouse->dev;
 	signed char *buf = sermouse->buf;
 
+	static unsigned char bad_byte;
+
 	input_regs(dev, regs);
 
 	switch (sermouse->count) {
 
 		case 0:
-			if ((data & 0xf8) != 0x80) return;
+			/* Check if the data looks like button state data */
+			if ((data & 0xf8) != 0x80) {
+				/* If we are currently using the 3-byte protocol
+				 * increment the bad_byte counter. If we received
+				 * more bad bytes than good ones, switch to the
+				 * 5-byte prococol. The user will notice this as
+				 * speedup of the mouse cursor :-) */
+				if(sermouse->type = SERIO_SUN && ++bad_byte > 20) {
+					sermouse->type = SERIO_MSC;
+					bad_byte = 0; /* I don't know, why I do this. */
+					printk(KERN_INFO
+						"sermouse.c: Switched to the 5-byte MSC mouse protocol.\n");
+				}
+				return;
+			}
+			/* Decrement the bad_byte counter so that a 3-byte Sun mouse
+			 * can make up for a bad button state byte it sent. */
+			if(sermouse->type = SERIO_SUN && bad_byte > 0) bad_byte--;
+			
 			input_report_key(dev, BTN_LEFT,   !(data & 4));
 			input_report_key(dev, BTN_RIGHT,  !(data & 1));
 			input_report_key(dev, BTN_MIDDLE, !(data & 2));
