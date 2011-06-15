From: Chris Metcalf <cmetcalf@tilera.com>
Date: Wed, 15 Jun 2011 14:35:38 +0000
Subject: [PATCH] arch/tile: remove useless set_fixmap_nocache() macro
Message-Id: <201106151442.p5FEg4ir010298@farm-0002.internal.tilera.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20110609172745.dfd3a298.sfr@canb.auug.org.au><20110609184127.GA2760@kroah.com><20110609192243.GA3980@kroah.com><20110610160548.529797c7.sfr@canb.auug.org.au>
In-Reply-To: <20110610160548.529797c7.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>, brudley@broadcom.com, henryp@broadcom.com, rvossen@broadcom.co

TILE doesn't support PAGE_KERNEL_NOCACHE so the macro isn't useful;
it's a copy-and-paste from the first version of this header in 2007.

Signed-off-by: Chris Metcalf <cmetcalf@tilera.com>
---
 arch/tile/include/asm/fixmap.h |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/tile/include/asm/fixmap.h b/arch/tile/include/asm/fixmap.h
index 51537ff..c66f793 100644
--- a/arch/tile/include/asm/fixmap.h
+++ b/arch/tile/include/asm/fixmap.h
@@ -75,12 +75,6 @@ extern void __set_fixmap(enum fixed_addresses idx,
 
 #define set_fixmap(idx, phys) \
 		__set_fixmap(idx, phys, PAGE_KERNEL)
-/*
- * Some hardware wants to get fixmapped without caching.
- */
-#define set_fixmap_nocache(idx, phys) \
-		__set_fixmap(idx, phys, PAGE_KERNEL_NOCACHE)
-
 #define clear_fixmap(idx) \
 		__set_fixmap(idx, 0, __pgprot(0))
 
-- 
1.6.5.2

