From: David Miller <davem@davemloft.net>
Date: Wed, 19 Dec 2012 23:45:45 +0000
Subject: [PATCH 0/5] Sparc64 crypto bug fixes.
Message-Id: <20121219.154545.1821202669042594869.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Several new tests added for DES and AES in the crypto
layer testmgr showed several bugs in the sparc64 T4
crypto opcode support.

I'll queue these up for -stable too.

Signed-off-by: David S. Miller <davem@davemloft.net>
