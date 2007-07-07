From: David Miller <davem@davemloft.net>
Date: Sat, 07 Jul 2007 06:02:27 +0000
Subject: Re: [BUG sparc64] 2.6.22-rc broke X on Ultra5
Message-Id: <20070706.230227.41633625.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <18002.44181.639121.720839@alkaid.it.uu.se>
In-Reply-To: <18002.44181.639121.720839@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dmitry Artamonow <mad_soft@inbox.ru>
Date: Fri, 6 Jul 2007 15:44:16 +0400

> Seems that your patch was not the only related change between -rc4 and -rc5.
> Anyway, X still doesn't work with -rc5 so probably problem is somewhere
> else. I sent you privately strace logs for X with 2.6.22-rc5.

Some more progress, there seems to be code in the X server that
hard-codes the I/O and MEM space sizes based upon the PCI
IDs of the Sun PCI host controller.  Barf...

Does it make further progress with the following patch?

diff --git a/arch/sparc64/kernel/pci_common.c b/arch/sparc64/kernel/pci_common.c
index 4249214..f8e5ffd 100644
--- a/arch/sparc64/kernel/pci_common.c
+++ b/arch/sparc64/kernel/pci_common.c
@@ -53,10 +53,6 @@ static int sun4u_read_pci_cfg(struct pci_bus *bus_dev, unsigned int devfn,
 	u16 tmp16;
 	u8 tmp8;
 
-	if (bus_dev = pbm->pci_bus && devfn = 0x00)
-		return pci_host_bridge_read_pci_cfg(bus_dev, devfn, where,
-						    size, value);
-
 	switch (size) {
 	case 1:
 		*value = 0xff;
@@ -108,9 +104,6 @@ static int sun4u_write_pci_cfg(struct pci_bus *bus_dev, unsigned int devfn,
 	unsigned char bus = bus_dev->number;
 	u32 *addr;
 
-	if (bus_dev = pbm->pci_bus && devfn = 0x00)
-		return pci_host_bridge_write_pci_cfg(bus_dev, devfn, where,
-						     size, value);
 	addr = sun4u_config_mkaddr(pbm, bus, devfn, where);
 	if (!addr)
 		return PCIBIOS_SUCCESSFUL;
