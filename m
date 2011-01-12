From: David Miller <davem@davemloft.net>
Date: Wed, 12 Jan 2011 04:51:03 +0000
Subject: Re: [PATCH 0/22] Make SVGA oriented FBs work on multi-domain PCI
Message-Id: <20110111.205103.266092678.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110111.154846.233419170.davem@davemloft.net>
In-Reply-To: <20110111.154846.233419170.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Tue, 11 Jan 2011 20:27:19 -0800 (PST)

> From: David Miller <davem@davemloft.net>
> Date: Tue, 11 Jan 2011 18:29:45 -0800 (PST)
> 
>> Oh... I see what is happening.  save_vga() sets this value using it's
>> own heuristics, when VGA_SAVE_FONTS is set, but in a way that won't
>> work in multi-domain PCI situations.
>> 
>> So we need to set this up in the drivers just like we do for the
>> 'vgabase' member.
>> 
>> I'll work on some patches to fix this.
> 
> Alex, give this a try.

Sorry, forgot the patch, here it is :-)

diff --git a/drivers/video/arkfb.c b/drivers/video/arkfb.c
index f63fdf7..3b2f6f5 100644
--- a/drivers/video/arkfb.c
+++ b/drivers/video/arkfb.c
@@ -535,13 +535,13 @@ static int arkfb_open(struct fb_info *info, int user)
 
 	mutex_lock(&(par->open_lock));
 	if (par->ref_count = 0) {
-		void __iomem *vgabase = par->state.vgabase;
-
-		memset(&(par->state), 0, sizeof(struct vgastate));
-		par->state.vgabase = vgabase;
 		par->state.flags = VGA_SAVE_MODE | VGA_SAVE_FONTS | VGA_SAVE_CMAP;
+		par->state.depth = 0;
+		par->state.num_attr = 0;
 		par->state.num_crtc = 0x60;
+		par->state.num_gfx = 0;
 		par->state.num_seq = 0x30;
+		par->state.vidstate = NULL;
 		save_vga(&(par->state));
 	}
 
@@ -947,12 +947,36 @@ static struct fb_ops arkfb_ops = {
 
 /* ------------------------------------------------------------------------- */
 
+static void __devinit ark_init_vgastate(struct pci_dev *dev, struct vgastate *state)
+{
+	struct pci_bus_region bus_reg;
+	struct resource vga_res;
+
+	bus_reg.start = 0;
+	bus_reg.end = 64 * 1024;
+
+	memset(&vga_res, 0, sizeof(vga_res));
+	vga_res.flags = IORESOURCE_IO;
+
+	pcibios_bus_to_resource(dev, &vga_res, &bus_reg);
+
+	state->vgabase = (void __iomem *) vga_res.start;
+
+	bus_reg.start = 0xa0000;
+	bus_reg.end = bus_reg.start + (8 * 8192);
+
+	memset(&vga_res, 0, sizeof(vga_res));
+	vga_res.flags = IORESOURCE_MEM;
+
+	pcibios_bus_to_resource(dev, &vga_res, &bus_reg);
+
+	state->membase = vga_res.start;
+	state->memsize = 8 * 8192;
+}
 
 /* PCI probe */
 static int __devinit ark_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	struct pci_bus_region bus_reg;
-	struct resource vga_res;
 	struct fb_info *info;
 	struct arkfb_info *par;
 	int rc;
@@ -1008,14 +1032,7 @@ static int __devinit ark_pci_probe(struct pci_dev *dev, const struct pci_device_
 		goto err_iomap;
 	}
 
-	bus_reg.start = 0;
-	bus_reg.end = 64 * 1024;
-
-	vga_res.flags = IORESOURCE_IO;
-
-	pcibios_bus_to_resource(dev, &vga_res, &bus_reg);
-
-	par->state.vgabase = (void __iomem *) vga_res.start;
+	ark_init_vgastate(dev, &par->state);
 
 	/* FIXME get memsize */
 	regval = vga_rseq(par->state.vgabase, 0x10);
diff --git a/drivers/video/s3fb.c b/drivers/video/s3fb.c
index 64ef7b3..4b8f215 100644
--- a/drivers/video/s3fb.c
+++ b/drivers/video/s3fb.c
@@ -379,13 +379,13 @@ static int s3fb_open(struct fb_info *info, int user)
 
 	mutex_lock(&(par->open_lock));
 	if (par->ref_count = 0) {
-		void __iomem *vgabase = par->state.vgabase;
-
-		memset(&(par->state), 0, sizeof(struct vgastate));
-		par->state.vgabase = vgabase;
 		par->state.flags = VGA_SAVE_MODE | VGA_SAVE_FONTS | VGA_SAVE_CMAP;
+		par->state.depth = 0;
+		par->state.num_attr = 0;
 		par->state.num_crtc = 0x70;
+		par->state.num_gfx = 0;
 		par->state.num_seq = 0x20;
+		par->state.vidstate = NULL;
 		save_vga(&(par->state));
 	}
 
@@ -929,13 +929,37 @@ static int __devinit s3_identification(struct s3fb_info *par)
 	return CHIP_UNKNOWN;
 }
 
+static void __devinit s3fb_init_vgastate(struct pci_dev *dev, struct vgastate *state)
+{
+	struct pci_bus_region bus_reg;
+	struct resource vga_res;
+
+	bus_reg.start = 0;
+	bus_reg.end = 64 * 1024;
+
+	memset(&vga_res, 0, sizeof(vga_res));
+	vga_res.flags = IORESOURCE_IO;
+
+	pcibios_bus_to_resource(dev, &vga_res, &bus_reg);
+
+	state->vgabase = (void __iomem *) vga_res.start;
+
+	bus_reg.start = 0xa0000;
+	bus_reg.end = bus_reg.start + (8 * 8192);
+
+	memset(&vga_res, 0, sizeof(vga_res));
+	vga_res.flags = IORESOURCE_MEM;
+
+	pcibios_bus_to_resource(dev, &vga_res, &bus_reg);
+
+	state->membase = vga_res.start;
+	state->memsize = 8 * 8192;
+}
 
 /* PCI probe */
 
 static int __devinit s3_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	struct pci_bus_region bus_reg;
-	struct resource vga_res;
 	struct fb_info *info;
 	struct s3fb_info *par;
 	int rc;
@@ -985,14 +1009,7 @@ static int __devinit s3_pci_probe(struct pci_dev *dev, const struct pci_device_i
 		goto err_iomap;
 	}
 
-	bus_reg.start = 0;
-	bus_reg.end = 64 * 1024;
-
-	vga_res.flags = IORESOURCE_IO;
-
-	pcibios_bus_to_resource(dev, &vga_res, &bus_reg);
-
-	par->state.vgabase = (void __iomem *) vga_res.start;
+	s3fb_init_vgastate(dev, &par->state);
 
 	/* Unlock regs */
 	cr38 = vga_rcrt(par->state.vgabase, 0x38);
diff --git a/drivers/video/vt8623fb.c b/drivers/video/vt8623fb.c
index 74df7a8..be70c14 100644
--- a/drivers/video/vt8623fb.c
+++ b/drivers/video/vt8623fb.c
@@ -292,13 +292,13 @@ static int vt8623fb_open(struct fb_info *info, int user)
 
 	mutex_lock(&(par->open_lock));
 	if (par->ref_count = 0) {
-		void __iomem *vgabase = par->state.vgabase;
-
-		memset(&(par->state), 0, sizeof(struct vgastate));
-		par->state.vgabase = vgabase;
 		par->state.flags = VGA_SAVE_MODE | VGA_SAVE_FONTS | VGA_SAVE_CMAP;
+		par->state.depth = 0;
+		par->state.num_attr = 0;
 		par->state.num_crtc = 0xA2;
+		par->state.num_gfx = 0;
 		par->state.num_seq = 0x50;
+		par->state.vidstate = NULL;
 		save_vga(&(par->state));
 	}
 
@@ -656,13 +656,37 @@ static struct fb_ops vt8623fb_ops = {
 	.fb_get_caps    = svga_get_caps,
 };
 
+static void __devinit vt8623_init_vgastate(struct pci_dev *dev, struct vgastate *state)
+{
+	struct pci_bus_region bus_reg;
+	struct resource vga_res;
+
+	bus_reg.start = 0;
+	bus_reg.end = 64 * 1024;
+
+	memset(&vga_res, 0, sizeof(vga_res));
+	vga_res.flags = IORESOURCE_IO;
+
+	pcibios_bus_to_resource(dev, &vga_res, &bus_reg);
+
+	state->vgabase = (void __iomem *) vga_res.start;
+
+	bus_reg.start = 0xa0000;
+	bus_reg.end = bus_reg.start + (8 * 8192);
+
+	memset(&vga_res, 0, sizeof(vga_res));
+	vga_res.flags = IORESOURCE_MEM;
+
+	pcibios_bus_to_resource(dev, &vga_res, &bus_reg);
+
+	state->membase = vga_res.start;
+	state->memsize = 8 * 8192;
+}
 
 /* PCI probe */
 
 static int __devinit vt8623_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	struct pci_bus_region bus_reg;
-	struct resource vga_res;
 	struct fb_info *info;
 	struct vt8623fb_info *par;
 	unsigned int memsize1, memsize2;
@@ -721,14 +745,7 @@ static int __devinit vt8623_pci_probe(struct pci_dev *dev, const struct pci_devi
 		goto err_iomap_2;
 	}
 
-	bus_reg.start = 0;
-	bus_reg.end = 64 * 1024;
-
-	vga_res.flags = IORESOURCE_IO;
-
-	pcibios_bus_to_resource(dev, &vga_res, &bus_reg);
-
-	par->state.vgabase = (void __iomem *) vga_res.start;
+	vt8623_init_vgastate(dev, &par->state);
 
 	/* Find how many physical memory there is on card */
 	memsize1 = (vga_rseq(par->state.vgabase, 0x34) + 1) >> 1;
