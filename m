From: David Miller <davem@davemloft.net>
Date: Fri, 27 Sep 2013 21:09:30 +0000
Subject: [PATCH] sparc64: Fix buggy strlcpy() conversion in ldom_reboot().
Message-Id: <20130927.170930.2150547787428619935.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Commit 117a0c5fc9c2d06045bd217385b2b39ea426b5a6 ("sparc: kernel: using
strlcpy() instead of strcpy()") added a bug to ldom_reboot in
arch/sparc/kernel/ds.c

-		strcpy(full_boot_str + strlen("boot "), boot_command);
+				     strlcpy(full_boot_str + strlen("boot "), boot_command,
+				     			     sizeof(full_boot_str + strlen("boot ")));

That last sizeof() expression evaluates to sizeof(size_t) which is
not what was intended.

Also even the corrected:

     sizeof(full_boot_str) + strlen("boot ")

is not right as the destination buffer length is just plain
"sizeof(full_boot_str)" and that's what the final argument
should be.

Signed-off-by: David S. Miller <davem@davemloft.net>
---

I'll push this to -stable too since 3.9 and onward need this fix as
well.

 arch/sparc/kernel/ds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/ds.c b/arch/sparc/kernel/ds.c
index 62d6b15..4d9ac84 100644
--- a/arch/sparc/kernel/ds.c
+++ b/arch/sparc/kernel/ds.c
@@ -851,7 +851,7 @@ void ldom_reboot(const char *boot_command)
 
 		strcpy(full_boot_str, "boot ");
 		strlcpy(full_boot_str + strlen("boot "), boot_command,
-			sizeof(full_boot_str + strlen("boot ")));
+			sizeof(full_boot_str));
 		len = strlen(full_boot_str);
 
 		if (reboot_data_supported) {
-- 
1.7.11.7

