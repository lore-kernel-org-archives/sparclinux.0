From: David Miller <davem@davemloft.net>
Date: Mon, 22 Sep 2008 12:13:02 +0000
Subject: Re: [PATCH]: Fix disappearing PCI devices
Message-Id: <20080922.051302.27372266.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080921.163315.125565921.davem@davemloft.net>
In-Reply-To: <20080921.163315.125565921.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Sun, 21 Sep 2008 22:06:58 +0300 (EEST)

> > Anyways, this patch below should fix the bug.  Let me know if it works.
> 
> Unfortunately it does not work. Here is "of_debug=3 debug" dmesg:

Ok, new patch to go on top of the previous fixes.

It's the same issue as was present in the of_device.c code.

I hope your PCI QFE cards will show up now :-)

diff --git a/arch/sparc64/kernel/pci.c b/arch/sparc64/kernel/pci.c
index 5509619..80dad76 100644
--- a/arch/sparc64/kernel/pci.c
+++ b/arch/sparc64/kernel/pci.c
@@ -425,7 +425,7 @@ struct pci_dev *of_create_pci_dev(struct pci_pbm_info *pbm,
 	dev->current_state = 4;		/* unknown power state */
 	dev->error_state = pci_channel_io_normal;
 
-	if (!strcmp(type, "pci") || !strcmp(type, "pciex")) {
+	if (!strcmp(node->name, "pci")) {
 		/* a PCI-PCI bridge */
 		dev->hdr_type = PCI_HEADER_TYPE_BRIDGE;
 		dev->rom_base_reg = PCI_ROM_ADDRESS1;
