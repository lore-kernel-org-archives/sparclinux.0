From: Mathieu Chouquet-Stringer <mchouque@free.fr>
Date: Sat, 06 Aug 2005 04:39:11 +0000
Subject: Re: [PATCH] Remove errno declaration in drivers/sbus/char/envctrl.c
Message-Id: <20050806043911.GA10647@localhost>
List-Id: <sparclinux.vger.kernel.org>
References: <20050804134803.GA32109@localhost>
In-Reply-To: <20050804134803.GA32109@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Aug 04, 2005 at 07:12:26AM -0700, David S. Miller wrote:
> [snip]
> Probably the best version of the fix would be to include
> linux/unistd.h instead of asm/unistd.h, so you might want
> to code that up and test it out.

Thanks for the feedback, what about the following then? It's compiled and
booted and I've realized than bbc_envctrl.c suffers from the same
thing, so here you go. Let me know if it makes sense...

Signed-off-by: Mathieu Chouquet-Stringer <mchouque@free.fr>

--- linux-2.6/drivers/sbus/char/envctrl.c	2005-07-25 20:28:43.000000000 -0400
+++ linux-2.6-mat/drivers/sbus/char/envctrl.c	2005-08-06 00:02:04.000000000 -0400
@@ -32,14 +32,12 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
+#include <linux/unistd.h>
 
 #include <asm/ebus.h>
 #include <asm/uaccess.h>
 #include <asm/envctrl.h>
 
-static int errno;
-#include <asm/unistd.h>
-
 #define ENVCTRL_MINOR	162
 
 #define PCF8584_ADDRESS	0x55
--- linux-2.6/drivers/sbus/char/bbc_envctrl.c	2005-07-25 20:28:43.000000000 -0400
+++ linux-2.6-mat/drivers/sbus/char/bbc_envctrl.c	2005-08-06 00:06:27.000000000 -0400
@@ -10,10 +10,9 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/unistd.h>
 #include <asm/oplib.h>
 #include <asm/ebus.h>
-static int errno;
-#include <asm/unistd.h>
 
 #include "bbc_i2c.h"
 #include "max1617.h"

-- 
Mathieu Chouquet-Stringer                   E-Mail: mchouque@free.fr
