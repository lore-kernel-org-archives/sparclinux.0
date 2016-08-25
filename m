From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 25 Aug 2016 08:24:00 +0000
Subject: [PATCH 2/2] sparc: Delete an unnecessary initialisation in led_proc_write()
Message-Id: <e09211e6-4aae-68f8-b912-c1415b4539f0@users.sourceforge.net>
List-Id: <sparclinux.vger.kernel.org>
References: <0ca0235c-ddb9-0534-3bde-b4aaa48da92e@users.sourceforge.net>
In-Reply-To: <0ca0235c-ddb9-0534-3bde-b4aaa48da92e@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 25 Aug 2016 09:55:22 +0200

The local variable "buf" will be set to an appropriate value a bit later.
Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/sparc/kernel/led.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/led.c b/arch/sparc/kernel/led.c
index 7444e4a..d6671af 100644
--- a/arch/sparc/kernel/led.c
+++ b/arch/sparc/kernel/led.c
@@ -64,7 +64,7 @@ static int led_proc_open(struct inode *inode, struct file *file)
 static ssize_t led_proc_write(struct file *file, const char __user *buffer,
 			      size_t count, loff_t *ppos)
 {
-	char *buf = NULL;
+	char *buf;
 
 	if (count > LED_MAX_LENGTH)
 		count = LED_MAX_LENGTH;
-- 
2.9.3

