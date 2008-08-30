From: David Miller <davem@davemloft.net>
Date: Sat, 30 Aug 2008 07:58:22 +0000
Subject: [PATCH 0/6]: Kill EBUS layer.
Message-Id: <20080830.005822.193690201.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Ok, this patch set does it.

The EBUS DMA library interfaces are split out into a
seperate header file, the drivers are converted, then
EBUS is killed off.
