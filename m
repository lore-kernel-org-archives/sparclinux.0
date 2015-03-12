From: Scott Wood <scottwood@freescale.com>
Date: Thu, 12 Mar 2015 03:13:47 +0000
Subject: [PATCH 12/22] sparc: %pF is only for function pointers
Message-Id: <1426130037-17956-12-git-send-email-scottwood@freescale.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1426130037-17956-1-git-send-email-scottwood@freescale.com>
In-Reply-To: <1426130037-17956-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: trivial@kernel.org, linux-kernel@vger.kernel.org
Cc: Scott Wood <scottwood@freescale.com>, sparclinux@vger.kernel.org

Use %pS for actual addresses, otherwise you'll get bad output
on arches like ppc64 where %pF expects a function descriptor.  Even on
other architectures, refrain from setting a bad example that people
copy.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/kernel/ds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/ds.c b/arch/sparc/kernel/ds.c
index f87a55d..4ff835f 100644
--- a/arch/sparc/kernel/ds.c
+++ b/arch/sparc/kernel/ds.c
@@ -875,7 +875,7 @@ void ldom_power_off(void)
 
 static void ds_conn_reset(struct ds_info *dp)
 {
-	printk(KERN_ERR "ds-%llu: ds_conn_reset() from %pf\n",
+	printk(KERN_ERR "ds-%llu: ds_conn_reset() from %ps\n",
 	       dp->id, __builtin_return_address(0));
 }
 
-- 
2.1.0

