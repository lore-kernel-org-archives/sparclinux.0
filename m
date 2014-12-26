From: David Miller <davem@davemloft.net>
Date: Fri, 26 Dec 2014 22:32:01 +0000
Subject: Re: Modifiying a T2000 and Radeon 6570 to work together.
Message-Id: <20141226.173201.851265724158672728.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CACwypyMwGXuN+oy-sZD2v2T_VaXR9ddYB63pfN5UFq5unkmFUg@mail.gmail.com>
In-Reply-To: <CACwypyMwGXuN+oy-sZD2v2T_VaXR9ddYB63pfN5UFq5unkmFUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: chase rayfield <cusbrar1@gmail.com>
Date: Wed, 24 Dec 2014 09:28:09 -0500

> 3.18.1 fails similarly but does actually boot up into a usable
> state... the GPU is not usable of course though.

3.18 works better because of the following commits:

commit 93a6423bd84d977bd768a001c6c3868e6a20b63a
Author: David S. Miller <davem@davemloft.net>
Date:   Tue Aug 12 23:22:39 2014 -0700

    sparc64: Expand PCI bridge probing debug logging.

commit 4afba24e5fc2626a3c604ec990539572f6662ff9
Author: David S. Miller <davem@davemloft.net>
Date:   Tue Aug 12 23:27:01 2014 -0700

    sparc64: Skip bogus PCI bridge ranges.

commit f1d25d37d316b8af202e51a4f82df01e12fe2661
Author: David S. Miller <davem@davemloft.net>
Date:   Tue Aug 12 23:29:09 2014 -0700

    sparc64: Properly claim resources as each PCI bus is probed.

The crash you see now is because radeon_read_bios() treats the
return value of pci_map_rom() like a virtual address, which
it is _not_.  It cannot be dereferenced, it cannot be passed
as a source pointer to kmemdup(), and this code is doing both
of those things.

It's an iomem pointer, and thus must be accessed with the
usual I/O accessors such as readl() et al.

The return value for pci_map_rom() is an "__iomem" pointer
so the static checkers should be throwing tons of warnings
for what radeon_read_bios() is doing.

Meelis Roos, CC:'d, was running into similar issues.

Please try the following patch:

diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeon/radeon_bios.c
index 63ccb8f..d27e4cc 100644
--- a/drivers/gpu/drm/radeon/radeon_bios.c
+++ b/drivers/gpu/drm/radeon/radeon_bios.c
@@ -76,7 +76,7 @@ static bool igp_read_bios_from_vram(struct radeon_device *rdev)
 
 static bool radeon_read_bios(struct radeon_device *rdev)
 {
-	uint8_t __iomem *bios;
+	uint8_t __iomem *bios, val1, val2;
 	size_t size;
 
 	rdev->bios = NULL;
@@ -86,15 +86,19 @@ static bool radeon_read_bios(struct radeon_device *rdev)
 		return false;
 	}
 
-	if (size = 0 || bios[0] != 0x55 || bios[1] != 0xaa) {
+	val1 = readb(&bios[0]);
+	val2 = readb(&bios[1]);
+
+	if (size = 0 || val1 != 0x55 || val2 != 0xaa) {
 		pci_unmap_rom(rdev->pdev, bios);
 		return false;
 	}
-	rdev->bios = kmemdup(bios, size, GFP_KERNEL);
+	rdev->bios = kzalloc(size, GFP_KERNEL);
 	if (rdev->bios = NULL) {
 		pci_unmap_rom(rdev->pdev, bios);
 		return false;
 	}
+	memcpy_fromio(rdev->bios, bios, size);
 	pci_unmap_rom(rdev->pdev, bios);
 	return true;
 }
