From: David Miller <davem@davemloft.net>
Date: Thu, 11 Sep 2008 06:14:28 +0000
Subject: [PATCH 0/3]: More code sharing between PSYCHO and SABRE
Message-Id: <20080910.231428.78046311.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


These two PCI controllers are in large part the same hardware, only
some minor details are different.  Of significance is that SABRE
lacks a streaming cache.

So there is a lot of duplicated code between these two PCI controller
drivers.

These 3 patches try to start taking care of that problem, in order
to shrink the kernel size down a bit.  And, hopefully, this can lead
to further simplifications.

