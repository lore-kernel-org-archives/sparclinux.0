From: David Miller <davem@davemloft.net>
Date: Wed, 24 Jan 2018 23:23:31 +0000
Subject: [GIT] Sparc
Message-Id: <20180124.182331.182228728089431656.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get this sparc Makefile typo fix.

Thank you.

The following changes since commit 0d665e7b109d512b7cae3ccef6e8654714887844:

  mm, page_vma_mapped: Drop faulty pointer arithmetics in check_pte() (2018-01-21 17:44:47 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to aebb48f5e465772576359c1705c4a84abea92027:

  sparc64: fix typo in CONFIG_CRYPTO_DES_SPARC64 => CONFIG_CRYPTO_CAMELLIA_SPARC64 (2018-01-24 16:47:55 -0500)

----------------------------------------------------------------
Corentin Labbe (1):
      sparc64: fix typo in CONFIG_CRYPTO_DES_SPARC64 => CONFIG_CRYPTO_CAMELLIA_SPARC64

 arch/sparc/crypto/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
