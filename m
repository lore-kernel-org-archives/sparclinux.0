From: David Miller <davem@davemloft.net>
Date: Wed, 13 Aug 2014 06:33:56 +0000
Subject: [PATCH 0/3] sparc64: Fix PCI ROM mapping
Message-Id: <20140812.233356.387652625397698400.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


PCI ROM mapping often doesn't work because we don't claim the resources
we probe as we import the PCI bus hierarchy into the kernel from the OF
device tree.

The first two patches make the PCI bus range probing easier to
diagnose when problems occur by adding more info to the
"ofpci_debug=1" mechanism.

The second patch deals with a PCI bus resource quirk that I
encountered on some PCI Express systems.

The third patch adds the necessary pci_claim_resource() calls.

Signed-off-by: David S. Miller <davem@davemloft.net>
