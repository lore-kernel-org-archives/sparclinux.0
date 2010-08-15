From: David Miller <davem@davemloft.net>
Date: Sun, 15 Aug 2010 07:26:58 +0000
Subject: Re: Serial console issue with 2.6.32
Message-Id: <20100815.002658.27793549.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201003151809.27436.elendil@planet.nl>
In-Reply-To: <201003151809.27436.elendil@planet.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Frans Pop <elendil@planet.nl>
Date: Wed, 2 Jun 2010 19:53:34 +0200

> On Wednesday 26 May 2010, David Miller wrote:
>> --------------------
>> sunserial: Don't call add_preferred_console() when console= is
>> specified.
> 
> Thanks for the patch David. I've tried to test with it, but for some reason 
> the box does not boot at all with .34 (both with and without the patch) if 
> I pass console=ttyS0. If I don't pass the parameter it boots fine.

Ok, I think I really got it this time :-)  Please add this patch on
top of the existing stuff.

--------------------
sparc: Really fix "console=" for serial consoles.

If a video head and keyboard are hooked up, specifying "console=ttyS0"
or similar to use a serial console will not work properly.

The key issue is that we must register all serial console capable
devices with register_console(), otherwise the command line specified
device won't be found.  The sun serial drivers would only register
themselves as console devices if the OpenFirmware specified console
device node matched.  To fix this part we now unconditionally get
the serial console register by setting serial_drv->cons always.

Secondarily we must not add_preferred_console() using the firmware
provided console setting if the user gaven an override on the kernel
command line using "console="  The "primary framebuffer" matching
logic was always triggering o n openfirmware device node match, make
it not when a command line override was given.

Reported-by: Frans Pop <elendil@planet.nl>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/fb.h |    4 ++++
 drivers/serial/suncore.c    |   15 +++++++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/include/asm/fb.h b/arch/sparc/include/asm/fb.h
index e834880..2173432 100644
--- a/arch/sparc/include/asm/fb.h
+++ b/arch/sparc/include/asm/fb.h
@@ -1,5 +1,6 @@
 #ifndef _SPARC_FB_H_
 #define _SPARC_FB_H_
+#include <linux/console.h>
 #include <linux/fb.h>
 #include <linux/fs.h>
 #include <asm/page.h>
@@ -18,6 +19,9 @@ static inline int fb_is_primary_device(struct fb_info *info)
 	struct device *dev = info->device;
 	struct device_node *node;
 
+	if (console_set_on_cmdline)
+		return 0;
+
 	node = dev->of_node;
 	if (node &&
 	    node = of_console_device)
diff --git a/drivers/serial/suncore.c b/drivers/serial/suncore.c
index 544f2e2..6381a02 100644
--- a/drivers/serial/suncore.c
+++ b/drivers/serial/suncore.c
@@ -55,7 +55,12 @@ EXPORT_SYMBOL(sunserial_unregister_minors);
 int sunserial_console_match(struct console *con, struct device_node *dp,
 			    struct uart_driver *drv, int line, bool ignore_line)
 {
-	if (!con || of_console_device != dp)
+	if (!con)
+		return 0;
+
+	drv->cons = con;
+
+	if (of_console_device != dp)
 		return 0;
 
 	if (!ignore_line) {
@@ -69,12 +74,10 @@ int sunserial_console_match(struct console *con, struct device_node *dp,
 			return 0;
 	}
 
-	con->index = line;
-	drv->cons = con;
-
-	if (!console_set_on_cmdline)
+	if (!console_set_on_cmdline) {
+		con->index = line;
 		add_preferred_console(con->name, line, NULL);
-
+	}
 	return 1;
 }
 EXPORT_SYMBOL(sunserial_console_match);
-- 
1.7.2.1

