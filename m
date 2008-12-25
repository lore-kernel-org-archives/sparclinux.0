From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 25 Dec 2008 17:48:49 +0000
Subject: [PATCH 1/2] sparc: drop SUN_IO
Message-Id: <20081225174849.GA8613@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

SUN_IO is always 'y' so drop it and thus killing an ifdef/endif pair

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/Kconfig    |    4 ----
 arch/sparc/mm/srmmu.c |    2 --
 2 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index cd8c585..8ec81b6 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -469,10 +469,6 @@ config SBUSCHAR
 	bool
 	default y
 
-config SUN_IO
-	bool
-	default y
-
 config SUN_LDOMS
 	bool "Sun Logical Domains support"
 	depends on SPARC64
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 56df599..fe7ed08 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -1312,10 +1312,8 @@ void __init srmmu_paging_init(void)
 #endif
 	poke_srmmu();
 
-#ifdef CONFIG_SUN_IO
 	srmmu_allocate_ptable_skeleton(sparc_iomap.start, IOBASE_END);
 	srmmu_allocate_ptable_skeleton(DVMA_VADDR, DVMA_END);
-#endif
 
 	srmmu_allocate_ptable_skeleton(
 		__fix_to_virt(__end_of_fixed_addresses - 1), FIXADDR_TOP);
-- 
1.6.0.2.GIT

