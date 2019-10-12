From: Eric Biggers <ebiggers@kernel.org>
Date: Sat, 12 Oct 2019 04:38:47 +0000
Subject: [RFT PATCH 0/3] crypto: sparc - convert to skcipher API
Message-Id: <20191012043850.340957-1-ebiggers@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Herbert Xu <herbert@gondor.apana.org.au>, linux-crypto@vger.kernel.org
Cc: sparclinux@vger.kernel.org, "David S . Miller" <davem@davemloft.net>

This series converts the glue code for the SPARC64 crypto opcodes
implementations of AES, Camellia, DES, and 3DES modes from the
deprecated "blkcipher" API to the "skcipher" API.  This is needed in
order for the blkcipher API to be removed.

I've compiled this patchset, and the conversion is very similar to that
which has been done for many other crypto drivers.  But I don't have the
hardware to test it, nor are SPARC64 crypto opcodes supported by QEMU.
So I really need someone with the hardware to test it.  You can do so by
setting:

CONFIG_CRYPTO_AES_SPARC64=y
CONFIG_CRYPTO_CAMELLIA_SPARC64=y
CONFIG_CRYPTO_DES_SPARC64=y
# CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
CONFIG_DEBUG_KERNEL=y
CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_ECB=y

Then boot and check for crypto self-test failures by running
'dmesg | grep alg'.

If there are test failures, please also check whether they were already
failing prior to this patchset.

Eric Biggers (3):
  crypto: sparc/aes - convert to skcipher API
  crypto: sparc/camellia - convert to skcipher API
  crypto: sparc/des - convert to skcipher API

 arch/sparc/crypto/aes_glue.c      | 310 +++++++++----------
 arch/sparc/crypto/camellia_glue.c | 217 ++++++-------
 arch/sparc/crypto/des_glue.c      | 499 ++++++++++++++----------------
 crypto/Kconfig                    |   5 +-
 4 files changed, 468 insertions(+), 563 deletions(-)

-- 
2.23.0
