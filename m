From: Kees Cook <keescook@chromium.org>
Date: Wed, 02 Oct 2013 05:13:34 +0000
Subject: [PATCH] sparc: fix ldom_reboot buffer overflow harder
Message-Id: <20131002051334.GA2406@www.outflux.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Paul Gortmaker <paul.gortmaker@windriver.com>, Zhao Hongjiang <zhaohongjiang@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, sparclinux@vger.kernel.org, Brad Spengler <spender@grsecurity.net>

The length argument to strlcpy was still wrong. It could overflow the end of
full_boot_str by 5 bytes. Instead of strcat and strlcpy, just use snprint.

Reported-by: Brad Spengler <spender@grsecurity.net>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/sparc/kernel/ds.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/ds.c b/arch/sparc/kernel/ds.c
index 4d9ac84..dff60ab 100644
--- a/arch/sparc/kernel/ds.c
+++ b/arch/sparc/kernel/ds.c
@@ -849,9 +849,8 @@ void ldom_reboot(const char *boot_command)
 	if (boot_command && strlen(boot_command)) {
 		unsigned long len;
 
-		strcpy(full_boot_str, "boot ");
-		strlcpy(full_boot_str + strlen("boot "), boot_command,
-			sizeof(full_boot_str));
+		snprintf(full_boot_str, sizeof(full_boot_str), "boot %s",
+			 boot_command);
 		len = strlen(full_boot_str);
 
 		if (reboot_data_supported) {
-- 
1.7.9.5


-- 
Kees Cook
Chrome OS Security
