From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Date: Tue, 29 Jun 2010 07:29:01 +0000
Subject: [PATCH] sparc: remove homegrown L1_CACHE_ALIGN macro
Message-Id: <20100629162149Z.fujita.tomonori@lab.ntt.co.jp>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Let's use the standard L1_CACHE_ALIGN macro instead.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
---
 arch/sparc/include/asm/cache.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/include/asm/cache.h b/arch/sparc/include/asm/cache.h
index 0588b8c..69358b5 100644
--- a/arch/sparc/include/asm/cache.h
+++ b/arch/sparc/include/asm/cache.h
@@ -11,7 +11,6 @@
 
 #define L1_CACHE_SHIFT 5
 #define L1_CACHE_BYTES 32
-#define L1_CACHE_ALIGN(x) ((((x)+(L1_CACHE_BYTES-1))&~(L1_CACHE_BYTES-1)))
 
 #ifdef CONFIG_SPARC32
 #define SMP_CACHE_BYTES_SHIFT 5
-- 
1.6.5

