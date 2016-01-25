From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 25 Jan 2016 22:24:21 +0000
Subject: [PATCH v2 07/16] staging/lustre: Switch from is_compat_task to in_compat_syscall
Message-Id: <f9e0451f5867b0f7f6b4b6a225f76cc71fb66553.1453759363.git.luto@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1453759363.git.luto@kernel.org>
In-Reply-To: <cover.1453759363.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org, linux-arch <linux-arch@vger.kernel.org>, David Miller <davem@davemloft.net>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Chris Metcalf <cmetcalf@ezchip.com>, linux-parisc@vger.kernel.org, linux-mips@linux-mips.org, sparclinux@vger.kernel.org

AFAICT, lustre is trying to determine syscall bitness.  Use the new
accessor.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/staging/lustre/lustre/llite/llite_internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/lustre/lustre/llite/llite_internal.h b/drivers/staging/lustre/lustre/llite/llite_internal.h
index 845e992ca5fc..373470410e05 100644
--- a/drivers/staging/lustre/lustre/llite/llite_internal.h
+++ b/drivers/staging/lustre/lustre/llite/llite_internal.h
@@ -647,7 +647,7 @@ static inline int ll_need_32bit_api(struct ll_sb_info *sbi)
 #if BITS_PER_LONG = 32
 	return 1;
 #elif defined(CONFIG_COMPAT)
-	return unlikely(is_compat_task() || (sbi->ll_flags & LL_SBI_32BIT_API));
+	return unlikely(in_compat_syscall() || (sbi->ll_flags & LL_SBI_32BIT_API));
 #else
 	return unlikely(sbi->ll_flags & LL_SBI_32BIT_API);
 #endif
-- 
2.5.0

