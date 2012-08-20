From: David Miller <davem@davemloft.net>
Date: Mon, 20 Aug 2012 05:10:00 +0000
Subject: [PATCH 0/4] Crytpo hash drivers for sparc64 crypto instructions.
Message-Id: <20120819.221000.1440395237780126787.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org
Cc: linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au


SPARC-T4 and later support cryptographic instructions.

This patch series adds support for the hash digest algorithms.

This includes md5, sha1, sha224, sha256, sha384, and sha512.

Herbert, this depends upon sparc64 cpu feature detection
infrastructure that is going in via the sparc-next tree, so I intend
to commit this work there if you don't mind.

Signed-off-by: David S. Miller <davem@davemloft.net>

