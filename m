From: David Miller <davem@davemloft.net>
Date: Sat, 30 Aug 2008 10:19:06 +0000
Subject: [PATCH 0/6]: Make sparc64 PCI controller drivers true drivers.
Message-Id: <20080830.031906.193690423.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


The sparc64 PCI controllers are probed using this contrived scheme
where we have this fixed table and this wonky probing loop that checks
the model string, compatible property, etc.

There is no reason for this, we have nice openfirmware device driver
probing infrastructure so we should use it and remove this ugly
by-hand probing code.
