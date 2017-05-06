From: Geliang Tang <geliangtang@gmail.com>
Date: Sat, 06 May 2017 15:40:20 +0000
Subject: [PATCH] sparc: use memdup_user_nul in sun4m LED driver
Message-Id: <870186e3b1d678cc96c902c26032ef9ce89c337c.1493783414.git.geliangtang@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <6baf3aa45d0b5e0fd016b508bac905ebf8443aac.1493779294.git.geliangtang@gmail.com>
In-Reply-To: <6baf3aa45d0b5e0fd016b508bac905ebf8443aac.1493779294.git.geliangtang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>, Ingo Molnar <mingo@kernel.org>
Cc: Geliang Tang <geliangtang@gmail.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Use memdup_user_nul() helper instead of open-coding to simplify the code.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 arch/sparc/kernel/led.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/sparc/kernel/led.c b/arch/sparc/kernel/led.c
index 44a3ed9..e278bf5 100644
--- a/arch/sparc/kernel/led.c
+++ b/arch/sparc/kernel/led.c
@@ -70,16 +70,9 @@ static ssize_t led_proc_write(struct file *file, const char __user *buffer,
 	if (count > LED_MAX_LENGTH)
 		count = LED_MAX_LENGTH;
 
-	buf = kmalloc(sizeof(char) * (count + 1), GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	if (copy_from_user(buf, buffer, count)) {
-		kfree(buf);
-		return -EFAULT;
-	}
-
-	buf[count] = '\0';
+	buf = memdup_user_nul(buffer, count);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
 
 	/* work around \n when echo'ing into proc */
 	if (buf[count - 1] = '\n')
-- 
2.9.3

