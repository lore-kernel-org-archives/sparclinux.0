From: "Art Haas" <ahaas@airmail.net>
Date: Mon, 29 Mar 2004 19:55:44 +0000
Subject: [PATCH] Add C99 initializers to Sparc frame buffer devices
Message-Id: <20040329195544.GB30251@artsapartment.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Hi.

Here is a set of 7 patches for adding C99 initializers to the various
Sparc frame buffer devices. I've compiled all but the 'ffb.c' file, as
that one looks to be sparc64 only.

Art Haas

=== drivers/video/bw2.c 1.6 vs edited ==--- 1.6/drivers/video/bw2.c	Sun May 25 19:00:00 2003
+++ edited/drivers/video/bw2.c	Mon Mar 29 13:45:40 2004
@@ -162,8 +162,10 @@
 }
 
 static struct sbus_mmap_map bw2_mmap_map[] = {
-	{ 0,			0,			SBUS_MMAP_FBSIZE(1) },
-	{ 0,			0,			0		    }
+	{
+		.size = SBUS_MMAP_FBSIZE(1)
+	},
+	{ .size = 0 }
 };
 
 static int bw2_mmap(struct fb_info *info, struct file *file, struct vm_area_struct *vma)
=== drivers/video/cg14.c 1.8 vs edited ==--- 1.8/drivers/video/cg14.c	Sun Aug 10 08:26:02 2003
+++ edited/drivers/video/cg14.c	Mon Mar 29 10:49:26 2004
@@ -367,23 +367,82 @@
 }
 
 static struct sbus_mmap_map __cg14_mmap_map[CG14_MMAP_ENTRIES] __initdata = {
-	{ CG14_REGS,		0x80000000,		0x1000		    },
-	{ CG14_XLUT,		0x80003000,		0x1000		    },
-	{ CG14_CLUT1,		0x80004000,		0x1000		    },
-	{ CG14_CLUT2,		0x80005000,		0x1000		    },
-	{ CG14_CLUT3,		0x80006000,		0x1000		    },
-	{ CG3_MMAP_OFFSET - 
-	  0x7000,		0x80000000,		0x7000		    },
-	{ CG3_MMAP_OFFSET,	0x00000000,		SBUS_MMAP_FBSIZE(1) },
-	{ MDI_CURSOR_MAP,	0x80001000,		0x1000		    },
-	{ MDI_CHUNKY_BGR_MAP,	0x01000000,		0x400000	    },
-	{ MDI_PLANAR_X16_MAP,	0x02000000,		0x200000	    },
-	{ MDI_PLANAR_C16_MAP,	0x02800000,		0x200000	    },
-	{ MDI_PLANAR_X32_MAP,	0x03000000,		0x100000	    },
-	{ MDI_PLANAR_B32_MAP,	0x03400000,		0x100000	    },
-	{ MDI_PLANAR_G32_MAP,	0x03800000,		0x100000	    },
-	{ MDI_PLANAR_R32_MAP,	0x03c00000,		0x100000	    },
-	{ 0,			0,			0		    }
+	{
+		.voff	= CG14_REGS,
+		.poff	= 0x80000000,
+		.size	= 0x1000
+	},
+	{
+		.voff	= CG14_XLUT,
+		.poff	= 0x80003000,
+		.size	= 0x1000
+	},
+	{
+		.voff	= CG14_CLUT1,
+		.poff	= 0x80004000,
+		.size	= 0x1000
+	},
+	{
+		.voff	= CG14_CLUT2,
+		.poff	= 0x80005000,
+		.size	= 0x1000
+	},
+	{
+		.voff	= CG14_CLUT3,
+		.poff	= 0x80006000,
+		.size	= 0x1000
+	},
+	{
+		.voff	= CG3_MMAP_OFFSET - 0x7000,
+		.poff	= 0x80000000,
+		.size	= 0x7000
+	},
+	{
+		.voff	= CG3_MMAP_OFFSET,
+		.poff	= 0x00000000,
+		.size	= SBUS_MMAP_FBSIZE(1)
+	},
+	{
+		.voff	= MDI_CURSOR_MAP,
+		.poff	= 0x80001000,
+		.size	= 0x1000
+	},
+	{
+		.voff	= MDI_CHUNKY_BGR_MAP,
+		.poff	= 0x01000000,
+		.size	= 0x400000
+	},
+	{
+		.voff	= MDI_PLANAR_X16_MAP,
+		.poff	= 0x02000000,
+		.size	= 0x200000
+	},
+	{
+		.voff	= MDI_PLANAR_C16_MAP,
+		.poff	= 0x02800000,
+		.size	= 0x200000
+	},
+	{
+		.voff	= MDI_PLANAR_X32_MAP,
+		.poff	= 0x03000000,
+		.size	= 0x100000
+	},
+	{
+		.voff	= MDI_PLANAR_B32_MAP,
+		.poff	= 0x03400000,
+		.size	= 0x100000
+	},
+	{
+		.voff	= MDI_PLANAR_G32_MAP,
+		.poff	= 0x03800000,
+		.size	= 0x100000
+	},
+	{
+		.voff	= MDI_PLANAR_R32_MAP,
+		.poff	= 0x03c00000,
+		.size	= 0x100000
+	},
+	{ .size = 0 }
 };
 
 struct all_info {
=== drivers/video/cg3.c 1.6 vs edited ==--- 1.6/drivers/video/cg3.c	Sun May 25 19:00:00 2003
+++ edited/drivers/video/cg3.c	Mon Mar 29 10:42:34 2004
@@ -221,8 +221,12 @@
 }
 
 static struct sbus_mmap_map cg3_mmap_map[] = {
-	{ CG3_MMAP_OFFSET,	CG3_RAM_OFFSET,		SBUS_MMAP_FBSIZE(1) },
-	{ 0,			0,			0		    }
+	{
+		.poff	= CG3_MMAP_OFFSET,
+		.voff	= CG3_RAM_OFFSET,
+		.size	= SBUS_MMAP_FBSIZE(1)
+	},
+	{ .size = 0 }
 };
 
 static int cg3_mmap(struct fb_info *info, struct file *file, struct vm_area_struct *vma)
=== drivers/video/cg6.c 1.5 vs edited ==--- 1.5/drivers/video/cg6.c	Thu Apr 24 05:30:41 2003
+++ edited/drivers/video/cg6.c	Mon Mar 29 10:42:54 2004
@@ -480,15 +480,47 @@
 }
 
 static struct sbus_mmap_map cg6_mmap_map[] = {
-	{ CG6_FBC,		CG6_FBC_OFFSET,		PAGE_SIZE 		},
-	{ CG6_TEC,		CG6_TEC_OFFSET,		PAGE_SIZE 		},
-	{ CG6_BTREGS,		CG6_BROOKTREE_OFFSET,	PAGE_SIZE 		},
-	{ CG6_FHC,		CG6_FHC_OFFSET,		PAGE_SIZE 		},
-	{ CG6_THC,		CG6_THC_OFFSET,		PAGE_SIZE 		},
-	{ CG6_ROM,		CG6_ROM_OFFSET,		0x10000   		},
-	{ CG6_RAM,		CG6_RAM_OFFSET,		SBUS_MMAP_FBSIZE(1)  	},
-	{ CG6_DHC,		CG6_DHC_OFFSET,		0x40000   		},
-	{ 0,			0,			0	  		}
+	{
+		.voff	= CG6_FBC,
+		.poff	= CG6_FBC_OFFSET,
+		.size	= PAGE_SIZE
+	},
+	{
+		.voff	= CG6_TEC,
+		.poff	= CG6_TEC_OFFSET,
+		.size	= PAGE_SIZE
+	},
+	{
+		.voff	= CG6_BTREGS,
+		.poff	= CG6_BROOKTREE_OFFSET,
+		.size	= PAGE_SIZE
+	},
+	{
+		.voff	= CG6_FHC,
+		.poff	= CG6_FHC_OFFSET,
+		.size	= PAGE_SIZE
+	},
+	{
+		.voff	= CG6_THC,
+		.poff	= CG6_THC_OFFSET,
+		.size	= PAGE_SIZE
+	},
+	{
+		.voff	= CG6_ROM,
+		.poff	= CG6_ROM_OFFSET,
+		.size	= 0x10000
+	},
+	{
+		.voff	= CG6_RAM,
+		.poff	= CG6_RAM_OFFSET,
+		.size	= SBUS_MMAP_FBSIZE(1)
+	},
+	{
+		.voff	= CG6_DHC,
+		.poff	= CG6_DHC_OFFSET,
+		.size	= 0x40000
+	},
+	{ .size	= 0 }
 };
 
 static int cg6_mmap(struct fb_info *info, struct file *file, struct vm_area_struct *vma)
=== drivers/video/ffb.c 1.8 vs edited ==--- 1.8/drivers/video/ffb.c	Thu Mar  4 20:22:25 2004
+++ edited/drivers/video/ffb.c	Mon Mar 29 10:56:00 2004
@@ -769,34 +769,142 @@
 }
 
 static struct sbus_mmap_map ffb_mmap_map[] = {
-	{ FFB_SFB8R_VOFF,	FFB_SFB8R_POFF,		0x0400000 },
-	{ FFB_SFB8G_VOFF,	FFB_SFB8G_POFF,		0x0400000 },
-	{ FFB_SFB8B_VOFF,	FFB_SFB8B_POFF,		0x0400000 },
-	{ FFB_SFB8X_VOFF,	FFB_SFB8X_POFF,		0x0400000 },
-	{ FFB_SFB32_VOFF,	FFB_SFB32_POFF,		0x1000000 },
-	{ FFB_SFB64_VOFF,	FFB_SFB64_POFF,		0x2000000 },
-	{ FFB_FBC_REGS_VOFF,	FFB_FBC_REGS_POFF,	0x0002000 },
-	{ FFB_BM_FBC_REGS_VOFF,	FFB_BM_FBC_REGS_POFF,	0x0002000 },
-	{ FFB_DFB8R_VOFF,	FFB_DFB8R_POFF,		0x0400000 },
-	{ FFB_DFB8G_VOFF,	FFB_DFB8G_POFF,		0x0400000 },
-	{ FFB_DFB8B_VOFF,	FFB_DFB8B_POFF,		0x0400000 },
-	{ FFB_DFB8X_VOFF,	FFB_DFB8X_POFF,		0x0400000 },
-	{ FFB_DFB24_VOFF,	FFB_DFB24_POFF,		0x1000000 },
-	{ FFB_DFB32_VOFF,	FFB_DFB32_POFF,		0x1000000 },
-	{ FFB_FBC_KREGS_VOFF,	FFB_FBC_KREGS_POFF,	0x0002000 },
-	{ FFB_DAC_VOFF,		FFB_DAC_POFF,		0x0002000 },
-	{ FFB_PROM_VOFF,	FFB_PROM_POFF,		0x0010000 },
-	{ FFB_EXP_VOFF,		FFB_EXP_POFF,		0x0002000 },
-	{ FFB_DFB422A_VOFF,	FFB_DFB422A_POFF,	0x0800000 },
-	{ FFB_DFB422AD_VOFF,	FFB_DFB422AD_POFF,	0x0800000 },
-	{ FFB_DFB24B_VOFF,	FFB_DFB24B_POFF,	0x1000000 },
-	{ FFB_DFB422B_VOFF,	FFB_DFB422B_POFF,	0x0800000 },
-	{ FFB_DFB422BD_VOFF,	FFB_DFB422BD_POFF,	0x0800000 },
-	{ FFB_SFB16Z_VOFF,	FFB_SFB16Z_POFF,	0x0800000 },
-	{ FFB_SFB8Z_VOFF,	FFB_SFB8Z_POFF,		0x0800000 },
-	{ FFB_SFB422_VOFF,	FFB_SFB422_POFF,	0x0800000 },
-	{ FFB_SFB422D_VOFF,	FFB_SFB422D_POFF,	0x0800000 },
-	{ 0,			0,			0	  }
+	{
+		.voff	= FFB_SFB8R_VOFF,
+		.poff	= FFB_SFB8R_POFF,
+		.size	= 0x0400000
+	},
+	{
+		.voff	= FFB_SFB8G_VOFF,
+		.poff	= FFB_SFB8G_POFF,
+		.size	= 0x0400000
+	},
+	{
+		.voff	= FFB_SFB8B_VOFF,
+		.poff	= FFB_SFB8B_POFF,
+		.size	= 0x0400000
+	},
+	{
+		.voff	= FFB_SFB8X_VOFF,
+		.poff	= FFB_SFB8X_POFF,
+		.size	= 0x0400000
+	},
+	{
+		.voff	= FFB_SFB32_VOFF,
+		.poff	= FFB_SFB32_POFF,
+		.size	= 0x1000000
+	},
+	{
+		.voff	= FFB_SFB64_VOFF,
+		.poff	= FFB_SFB64_POFF,
+		.size	= 0x2000000
+	},
+	{
+		.voff	= FFB_FBC_REGS_VOFF,
+		.poff	= FFB_FBC_REGS_POFF,
+		.size	= 0x0002000
+	},
+	{
+		.voff	= FFB_BM_FBC_REGS_VOFF,
+		.poff	= FFB_BM_FBC_REGS_POFF,
+		.size	= 0x0002000
+	},
+	{
+		.voff	= FFB_DFB8R_VOFF,
+		.poff	= FFB_DFB8R_POFF,
+		.size	= 0x0400000
+	},
+	{
+		.voff	= FFB_DFB8G_VOFF,
+		.poff	= FFB_DFB8G_POFF,
+		.size	= 0x0400000
+	},
+	{
+		.voff	= FFB_DFB8B_VOFF,
+		.poff	= FFB_DFB8B_POFF,
+		.size	= 0x0400000
+	},
+	{
+		.voff	= FFB_DFB8X_VOFF,
+		.poff	= FFB_DFB8X_POFF,
+		.size	= 0x0400000
+	},
+	{
+		.voff	= FFB_DFB24_VOFF,
+		.poff	= FFB_DFB24_POFF,
+		.size	= 0x1000000
+	},
+	{
+		.voff	= FFB_DFB32_VOFF,
+		.poff	= FFB_DFB32_POFF,
+		.size	= 0x1000000
+	},
+	{
+		.voff	= FFB_FBC_KREGS_VOFF,
+		.poff	= FFB_FBC_KREGS_POFF,
+		.size	= 0x0002000
+	},
+	{
+		.voff	= FFB_DAC_VOFF,
+		.poff	= FFB_DAC_POFF,
+		.size	= 0x0002000
+	},
+	{
+		.voff	= FFB_PROM_VOFF,
+		.poff	= FFB_PROM_POFF,
+		.size	= 0x0010000
+	},
+	{
+		.voff	= FFB_EXP_VOFF,
+		.poff	= FFB_EXP_POFF,
+		.size	= 0x0002000
+	},
+	{
+		.voff	= FFB_DFB422A_VOFF,
+		.poff	= FFB_DFB422A_POFF,
+		.size	= 0x0800000
+	},
+	{
+		.voff	= FFB_DFB422AD_VOFF,
+		.poff	= FFB_DFB422AD_POFF,
+		.size	= 0x0800000
+	},
+	{
+		.voff	= FFB_DFB24B_VOFF,
+		.poff	= FFB_DFB24B_POFF,
+		.size	= 0x1000000
+	},
+	{
+		.voff	= FFB_DFB422B_VOFF,
+		.poff	= FFB_DFB422B_POFF,
+		.size	= 0x0800000
+	},
+	{
+		.voff	= FFB_DFB422BD_VOFF,
+		.poff	= FFB_DFB422BD_POFF,
+		.size	= 0x0800000
+	},
+	{
+		.voff	= FFB_SFB16Z_VOFF,
+		.poff	= FFB_SFB16Z_POFF,
+		.size	= 0x0800000
+	},
+	{
+		.voff	= FFB_SFB8Z_VOFF,
+		.poff	= FFB_SFB8Z_POFF,
+		.size	= 0x0800000
+	},
+	{
+		.voff	= FFB_SFB422_VOFF,
+		.poff	= FFB_SFB422_POFF,
+		.size	= 0x0800000
+	},
+	{
+		.voff	= FFB_SFB422D_VOFF,
+		.poff	= FFB_SFB422D_POFF,
+		.size	= 0x0800000
+	},
+	{ .size = 0 }
 };
 
 static int ffb_mmap(struct fb_info *info, struct file *file, struct vm_area_struct *vma)
=== drivers/video/leo.c 1.5 vs edited ==--- 1.5/drivers/video/leo.c	Sun Aug 10 08:26:02 2003
+++ edited/drivers/video/leo.c	Mon Mar 29 11:02:20 2004
@@ -294,20 +294,72 @@
 }
 
 static struct sbus_mmap_map leo_mmap_map[] = {
-	{ LEO_SS0_MAP,		LEO_OFF_SS0,		0x800000	},
-	{ LEO_LC_SS0_USR_MAP,	LEO_OFF_LC_SS0_USR,	0x1000		},
-	{ LEO_LD_SS0_MAP,	LEO_OFF_LD_SS0,		0x1000		},
-	{ LEO_LX_CURSOR_MAP,	LEO_OFF_LX_CURSOR,	0x1000		},
-	{ LEO_SS1_MAP,		LEO_OFF_SS1,		0x800000	},
-	{ LEO_LC_SS1_USR_MAP,	LEO_OFF_LC_SS1_USR,	0x1000		},
-	{ LEO_LD_SS1_MAP,	LEO_OFF_LD_SS1,		0x1000		},
-	{ LEO_UNK_MAP,		LEO_OFF_UNK,		0x1000		},
-	{ LEO_LX_KRN_MAP,	LEO_OFF_LX_KRN,		0x1000		},
-	{ LEO_LC_SS0_KRN_MAP,	LEO_OFF_LC_SS0_KRN,	0x1000		},
-	{ LEO_LC_SS1_KRN_MAP,	LEO_OFF_LC_SS1_KRN,	0x1000		},
-	{ LEO_LD_GBL_MAP,	LEO_OFF_LD_GBL,		0x1000		},
-	{ LEO_UNK2_MAP,		LEO_OFF_UNK2,		0x100000	},
-	{ 0,			0,			0	  	}
+	{
+		.voff	= LEO_SS0_MAP,
+		.poff	= LEO_OFF_SS0,
+		.size	= 0x800000
+	},
+	{
+		.voff	= LEO_LC_SS0_USR_MAP,
+		.poff	= LEO_OFF_LC_SS0_USR,
+		.size	= 0x1000
+	},
+	{
+		.voff	= LEO_LD_SS0_MAP,
+		.poff	= LEO_OFF_LD_SS0,
+		.size	= 0x1000
+	},
+	{
+		.voff	= LEO_LX_CURSOR_MAP,
+		.poff	= LEO_OFF_LX_CURSOR,
+		.size	= 0x1000
+	},
+	{
+		.voff	= LEO_SS1_MAP,
+		.poff	= LEO_OFF_SS1,
+		.size	= 0x800000
+	},
+	{
+		.voff	= LEO_LC_SS1_USR_MAP,
+		.poff	= LEO_OFF_LC_SS1_USR,
+		.size	= 0x1000
+	},
+	{
+		.voff	= LEO_LD_SS1_MAP,
+		.poff	= LEO_OFF_LD_SS1,
+		.size	= 0x1000
+	},
+	{
+		.voff	= LEO_UNK_MAP,
+		.poff	= LEO_OFF_UNK,
+		.size	= 0x1000
+	},
+	{
+		.voff	= LEO_LX_KRN_MAP,
+		.poff	= LEO_OFF_LX_KRN,
+		.size	= 0x1000
+	},
+	{
+		.voff	= LEO_LC_SS0_KRN_MAP,
+		.poff	= LEO_OFF_LC_SS0_KRN,
+		.size	= 0x1000
+	},
+	{
+		.voff	= LEO_LC_SS1_KRN_MAP,
+		.poff	= LEO_OFF_LC_SS1_KRN,
+		.size	= 0x1000
+	},
+	{
+		.voff	= LEO_LD_GBL_MAP,
+		.poff	= LEO_OFF_LD_GBL,
+		.size	= 0x1000
+	},
+	{
+		.voff	= LEO_UNK2_MAP,
+		.poff	= LEO_OFF_UNK2,
+		.size	= 0x100000
+	},
+	{ .size = 0 }
 };
 
 static int leo_mmap(struct fb_info *info, struct file *file, struct vm_area_struct *vma)
=== drivers/video/tcx.c 1.6 vs edited ==--- 1.6/drivers/video/tcx.c	Sun May 25 19:00:00 2003
+++ edited/drivers/video/tcx.c	Mon Mar 29 10:59:02 2004
@@ -238,20 +238,59 @@
 }
 
 static struct sbus_mmap_map __tcx_mmap_map[TCX_MMAP_ENTRIES] = {
-	{ TCX_RAM8BIT,		0,		SBUS_MMAP_FBSIZE(1) },
-	{ TCX_RAM24BIT,		0,		SBUS_MMAP_FBSIZE(4) },
-	{ TCX_UNK3,		0,		SBUS_MMAP_FBSIZE(8) },
-	{ TCX_UNK4,		0,		SBUS_MMAP_FBSIZE(8) },
-	{ TCX_CONTROLPLANE,	0,		SBUS_MMAP_FBSIZE(4) },
-	{ TCX_UNK6,		0,		SBUS_MMAP_FBSIZE(8) },
-	{ TCX_UNK7,		0,		SBUS_MMAP_FBSIZE(8) },
-	{ TCX_TEC,		0,		PAGE_SIZE	    },
-	{ TCX_BTREGS,		0,		PAGE_SIZE	    },
-	{ TCX_THC,		0,		PAGE_SIZE	    },
-	{ TCX_DHC,		0,		PAGE_SIZE	    },
-	{ TCX_ALT,		0,		PAGE_SIZE	    },
-	{ TCX_UNK2,		0,		0x20000		    },
-	{ 0,			0,		0		    }
+	{
+		.voff	= TCX_RAM8BIT,
+		.size	= SBUS_MMAP_FBSIZE(1)
+	},
+	{
+		.voff	= TCX_RAM24BIT,
+		.size	= SBUS_MMAP_FBSIZE(4)
+	},
+	{
+		.voff	= TCX_UNK3,
+		.size	= SBUS_MMAP_FBSIZE(8)
+	},
+	{
+		.voff	= TCX_UNK4,
+		.size	= SBUS_MMAP_FBSIZE(8)
+	},
+	{
+		.voff	= TCX_CONTROLPLANE,
+		.size	= SBUS_MMAP_FBSIZE(4)
+	},
+	{
+		.voff	= TCX_UNK6,
+		.size	= SBUS_MMAP_FBSIZE(8)
+	},
+	{
+		.voff	= TCX_UNK7,
+		.size	= SBUS_MMAP_FBSIZE(8)
+	},
+	{
+		.voff	= TCX_TEC,
+		.size	= PAGE_SIZE
+	},
+	{
+		.voff	= TCX_BTREGS,
+		.size	= PAGE_SIZE
+	},
+	{
+		.voff	= TCX_THC,
+		.size	= PAGE_SIZE
+	},
+	{
+		.voff	= TCX_DHC,
+		.size	= PAGE_SIZE
+	},
+	{
+		.voff	= TCX_ALT,
+		.size	= PAGE_SIZE
+	},
+	{
+		.voff	= TCX_UNK2,
+		.size	= 0x20000
+	},
+	{ .size = 0 }
 };
 
 static int tcx_mmap(struct fb_info *info, struct file *file, struct vm_area_struct *vma)
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
