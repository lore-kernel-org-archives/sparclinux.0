From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 28 Dec 2005 20:43:21 +0000
Subject: Re: Sun mouse using 5-byte MSC protocol
Message-Id: <20051228.124321.47364383.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christopher Zimmermann <madroach@zakweb.de>
Date: Sun, 13 Nov 2005 20:31:44 +0100

> Unfortunately I don't have any "real" sun mouse sending 3-byte packets;
> therefore I could not test if my modifications breaks support for those
> sun mice.

I've made a slight modification to your patch, using a per-mouse
bad_bytes count.  If I have 2 mice, I don't one MSC one causing
the other to switch to MSC too :-)

I'll try to see if this breaks normal 3-byte protocol speaking
mice.

diff --git a/drivers/input/mouse/sermouse.c b/drivers/input/mouse/sermouse.c
index 4bf5843..7bfc2f3 100644
--- a/drivers/input/mouse/sermouse.c
+++ b/drivers/input/mouse/sermouse.c
@@ -52,6 +52,7 @@ struct sermouse {
 	signed char buf[8];
 	unsigned char count;
 	unsigned char type;
+	unsigned char bad_bytes;
 	unsigned long last;
 	char phys[32];
 };
@@ -72,7 +73,21 @@ static void sermouse_process_msc(struct 
 	switch (sermouse->count) {
 
 		case 0:
-			if ((data & 0xf8) != 0x80) return;
+			if ((data & 0xf8) != 0x80) {
+				if (sermouse->type = SERIO_SUN &&
+				    ++sermouse->bad_bytes > 20) {
+					sermouse->type = SERIO_MSC;
+					sermouse->bad_bytes = 0;
+					printk(KERN_INFO "sermouse.c: "
+					       "Switched to the 5-byte "
+					       "MSC mouse protocol.\n");
+				}
+				return;
+			}
+			if (sermouse->type = SERIO_SUN &&
+			    sermouse->bad_bytes > 0)
+				sermouse->bad_bytes--;
+
 			input_report_key(dev, BTN_LEFT,   !(data & 4));
 			input_report_key(dev, BTN_RIGHT,  !(data & 1));
 			input_report_key(dev, BTN_MIDDLE, !(data & 2));
