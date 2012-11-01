From: Meelis Roos <mroos@linux.ee>
Date: Thu, 01 Nov 2012 19:22:19 +0000
Subject: sparc64 crypto static linking problem
Message-Id: <alpine.SOC.1.00.1211012117400.16377@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

While trying 3.7.0-rc3-00075-g1e207eb on sparc64, I configured sparc64 
versionis of the ciphers. Modular where my original cipher was modular 
and static where my original cipher was static (config snippet below). 
This results in linking error when multiple thing are static:

 LD      arch/sparc/crypto/built-in.o
arch/sparc/crypto/aes-sparc64.o:(.rodata+0x0): multiple definition of `__mod_of_device_table'
arch/sparc/crypto/md5-sparc64.o:(.rodata+0x0): first defined here
arch/sparc/crypto/crc32c-sparc64.o:(.rodata+0x0): multiple definition of `__mod_of_device_table'
arch/sparc/crypto/md5-sparc64.o:(.rodata+0x0): first defined here


CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_SPARC64=y
# CONFIG_CRYPTO_GHASH is not set
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MD5_SPARC64=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_RMD128 is not set
# CONFIG_CRYPTO_RMD160 is not set
# CONFIG_CRYPTO_RMD256 is not set
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA1_SPARC64=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA256_SPARC64=m
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_SHA512_SPARC64 is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_SPARC64=y
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=m
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_CAMELLIA_SPARC64 is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_DES_SPARC64=m
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_SALSA20 is not set
# CONFIG_CRYPTO_SEED is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_TWOFISH is not set


-- 
Meelis Roos (mroos@linux.ee)
