From: David Miller <davem@davemloft.net>
Date: Thu, 30 Aug 2012 15:45:55 +0000
Subject: [PATCH 0/5] sparc64: AES driver improvements
Message-Id: <20120830.114555.1966388095294836244.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org
Cc: linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au


This patch series adds CTR mode support to the sparc64 AES driver
and then unrolls the loops that we can to get better performance.

Signed-off-by: David S. Miller <davem@davemloft.net>
