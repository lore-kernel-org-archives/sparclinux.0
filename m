From: Yisheng Xie <xieyisheng1@huawei.com>
Date: Thu, 31 May 2018 11:11:26 +0000
Subject: [PATCH v2 21/21] sparc64: use match_string() helper
Message-Id: <1527765086-19873-22-git-send-email-xieyisheng1@huawei.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
In-Reply-To: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: andy.shevchenko@gmail.com, Yisheng Xie <xieyisheng1@huawei.com>, "David S. Miller" <davem@davemloft.net>, Anthony Yznaga <anthony.yznaga@oracle.com>, Pavel Tatashin <pasha.tatashin@oracle.com>, sparclinux@vger.kernel.org

match_string() returns the index of an array for a matching string,
which can be used instead of open coded variant.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 arch/sparc/kernel/setup_64.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 7944b3c..7af8c7e 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -512,10 +512,9 @@ static unsigned long __init mdesc_cpu_hwcap_list(void)
 				break;
 			}
 		}
-		for (i = 0; i < ARRAY_SIZE(crypto_hwcaps); i++) {
-			if (!strcmp(prop, crypto_hwcaps[i]))
-				caps |= HWCAP_SPARC_CRYPTO;
-		}
+		i = match_string(crypto_hwcaps, ARRAY_SIZE(crypto_hwcaps), prop);
+		if (i >= 0)
+			caps |= HWCAP_SPARC_CRYPTO;
 
 		plen = strlen(prop) + 1;
 		prop += plen;
-- 
1.7.12.4

