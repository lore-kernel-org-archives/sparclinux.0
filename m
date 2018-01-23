From: Corentin Labbe <clabbe@baylibre.com>
Date: Tue, 23 Jan 2018 14:33:14 +0000
Subject: [PATCH] sparc64: fix typo in CONFIG_CRYPTO_DES_SPARC64 => CONFIG_CRYPTO_CAMELLIA_SPARC64
Message-Id: <1516717994-24407-1-git-send-email-clabbe@baylibre.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, herbert@gondor.apana.org.au
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>

This patch fixes the typo CONFIG_CRYPTO_DES_SPARC64 => CONFIG_CRYPTO_CAMELLIA_SPARC64

Fixes: 81658ad0d923 ("sparc64: Add CAMELLIA driver making use of the new camellia opcodes.")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/sparc/crypto/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/crypto/Makefile b/arch/sparc/crypto/Makefile
index 818d3aa5172e..d257186c27d1 100644
--- a/arch/sparc/crypto/Makefile
+++ b/arch/sparc/crypto/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_CRYPTO_MD5_SPARC64) += md5-sparc64.o
 
 obj-$(CONFIG_CRYPTO_AES_SPARC64) += aes-sparc64.o
 obj-$(CONFIG_CRYPTO_DES_SPARC64) += des-sparc64.o
-obj-$(CONFIG_CRYPTO_DES_SPARC64) += camellia-sparc64.o
+obj-$(CONFIG_CRYPTO_CAMELLIA_SPARC64) += camellia-sparc64.o
 
 obj-$(CONFIG_CRYPTO_CRC32C_SPARC64) += crc32c-sparc64.o
 
-- 
2.13.6

