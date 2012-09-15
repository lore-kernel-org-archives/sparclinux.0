From: David Miller <davem@davemloft.net>
Date: Sat, 15 Sep 2012 16:57:06 +0000
Subject: [PATCH] sparc64: Add auto-loading mechanism to crypto-opcode drivers.
Message-Id: <20120915.125706.1132916862650769138.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Just simply provide a device table containing an entry for sun4v cpus,
the capability mask checks in the drivers themselves will take care of
the rest.

This makes the bootup logs on pre-T4 cpus slightly more verbose, with
each driver indicating lack of support for the associated opcode(s).

But this isn't too much of a real problem.

I toyed with the idea of using explicit entries with compatability
fields of "SPARC-T4", "SPARC-T5", etc. but all future cpus will have
some subset of these opcodes available and this would just be one more
pointless thing to do as each new cpu is released with a new string.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/crypto/Makefile     |   16 ++++++++--------
 arch/sparc/crypto/crop_devid.c |   14 ++++++++++++++
 2 files changed, 22 insertions(+), 8 deletions(-)
 create mode 100644 arch/sparc/crypto/crop_devid.c

diff --git a/arch/sparc/crypto/Makefile b/arch/sparc/crypto/Makefile
index 5d469d8..6ae1ad5 100644
--- a/arch/sparc/crypto/Makefile
+++ b/arch/sparc/crypto/Makefile
@@ -13,13 +13,13 @@ obj-$(CONFIG_CRYPTO_DES_SPARC64) += camellia-sparc64.o
 
 obj-$(CONFIG_CRYPTO_CRC32C_SPARC64) += crc32c-sparc64.o
 
-sha1-sparc64-y := sha1_asm.o sha1_glue.o
-sha256-sparc64-y := sha256_asm.o sha256_glue.o
-sha512-sparc64-y := sha512_asm.o sha512_glue.o
-md5-sparc64-y := md5_asm.o md5_glue.o
+sha1-sparc64-y := sha1_asm.o sha1_glue.o crop_devid.o
+sha256-sparc64-y := sha256_asm.o sha256_glue.o crop_devid.o
+sha512-sparc64-y := sha512_asm.o sha512_glue.o crop_devid.o
+md5-sparc64-y := md5_asm.o md5_glue.o crop_devid.o
 
-aes-sparc64-y := aes_asm.o aes_glue.o
-des-sparc64-y := des_asm.o des_glue.o
-camellia-sparc64-y := camellia_asm.o camellia_glue.o
+aes-sparc64-y := aes_asm.o aes_glue.o crop_devid.o
+des-sparc64-y := des_asm.o des_glue.o crop_devid.o
+camellia-sparc64-y := camellia_asm.o camellia_glue.o crop_devid.o
 
-crc32c-sparc64-y := crc32c_asm.o crc32c_glue.o
+crc32c-sparc64-y := crc32c_asm.o crc32c_glue.o crop_devid.o
diff --git a/arch/sparc/crypto/crop_devid.c b/arch/sparc/crypto/crop_devid.c
new file mode 100644
index 0000000..5f5724a
--- /dev/null
+++ b/arch/sparc/crypto/crop_devid.c
@@ -0,0 +1,14 @@
+#include <linux/module.h>
+#include <linux/of_device.h>
+
+/* This is a dummy device table linked into all of the crypto
+ * opcode drivers.  It serves to trigger the module autoloading
+ * mechanisms in userspace which scan the OF device tree and
+ * load any modules which have device table entries that
+ * match OF device nodes.
+ */
+static const struct of_device_id crypto_opcode_match[] = {
+	{ .name = "cpu", .compatible = "sun4v", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, crypto_opcode_match);
-- 
1.7.10.4

