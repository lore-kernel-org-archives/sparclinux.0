From: David Miller <davem@davemloft.net>
Date: Thu, 11 Sep 2008 06:10:50 +0000
Subject: [PATCH 0/2]: Two sparc64 PCI controller tidies...
Message-Id: <20080910.231050.184782705.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Here are two cleanups I've just pushed to sparc-next-2.6

1) Get rid of pci_controller_info, it represents an abstraction
   that is only really necessary to be aware of for one
   of the PCI controller types.

2) Record OF device node instead of the raw PROM node in the
   PCI controller struct.
