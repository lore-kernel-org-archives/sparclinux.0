From: David Miller <davem@davemloft.net>
Date: Mon, 17 Jan 2011 04:30:09 +0000
Subject: Re: [PATCH 0/22] Make SVGA oriented FBs work on multi-domain PCI
Message-Id: <20110116.203009.28806331.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110111.154846.233419170.davem@davemloft.net>
In-Reply-To: <20110111.154846.233419170.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Alex Buell <alex.buell@munted.org.uk>
Date: Wed, 12 Jan 2011 23:43:02 +0000

> Jan 12 21:53:27 sodium pci@8,700000: PCI Error, primary error type[Master Abort]
> Jan 12 21:53:27 sodium kernel: /pci@8,700pci@8,pci@8,700000: PCter Aborpci@8,700000: PCI Error, primary error type[Master Abort]
> Jan 12 21:53:27 sodium kernel: /pci@8,700000: bytemask[0080] was_block(0) space(Memory)
> Jan 12 21:53:27 sodium kernel: /pci@8,700000: PCI AFAR [00000000000a00a8]
> Jan 12 21:53:27 sodium kernel: /pci@8,700000: PCI Secondary errors [(Master Abort)]
> Jan 12 21:53:27 sodium kernel: /pci@8,700000: PCI Error, primary error type[Master Abort]

The address we're using seems right, but for some reason the device
is giving a master abort when we try to access the legacy VGA memory.

I did a little bit of research, and there is a bit in the VGA I/O
register set that needs to be set otherwise the VGA card will not
respond to video memory accesses.

Can you test to see if the following patch makes a difference?

diff --git a/drivers/video/s3fb.c b/drivers/video/s3fb.c
index 4b8f215..00152f6 100644
--- a/drivers/video/s3fb.c
+++ b/drivers/video/s3fb.c
@@ -1053,6 +1053,13 @@ static int __devinit s3_pci_probe(struct pci_dev *dev, const struct pci_device_i
 	vga_wcrt(par->state.vgabase, 0x38, cr38);
 	vga_wcrt(par->state.vgabase, 0x39, cr39);
 
+	/* Ensure that the card will respond to legacy VGA memory
+	 * accesses.
+	 */
+	regval = vga_r(par->state.vgabase, VGA_MIS_R);
+	regval |= VGA_MIS_ENB_MEM_ACCESS;
+	vga_w(par->state.vgabase, VGA_MIS_W, regval);
+
 	strcpy(info->fix.id, s3_names [par->chip]);
 	info->fix.mmio_start = 0;
 	info->fix.mmio_len = 0;
