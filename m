From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 11 Dec 2008 21:17:07 +0000
Subject: [PATCH] sparc64: do not export pus_fs_struct
Message-Id: <20081211211707.GA27223@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Al asked: BTW, why does sparc64 export put_fs_struct?
Grepping the kernel tree did not show any users of
an exported put_fs_struct - so drop the export.

Cc: Al Viro <viro@ZenIV.linux.org.uk>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/sparc_ksyms_64.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/kernel/sparc_ksyms_64.c b/arch/sparc/kernel/sparc_ksyms_64.c
index e6d2bb8..6119332 100644
--- a/arch/sparc/kernel/sparc_ksyms_64.c
+++ b/arch/sparc/kernel/sparc_ksyms_64.c
@@ -181,7 +181,6 @@ EXPORT_SYMBOL(pci_dma_supported);
 EXPORT_SYMBOL(io_remap_pfn_range);
 
 EXPORT_SYMBOL(dump_fpu);
-EXPORT_SYMBOL(put_fs_struct);
 
 /* math-emu wants this */
 EXPORT_SYMBOL(die_if_kernel);
-- 
1.5.6.GIT

