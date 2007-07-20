From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 20 Jul 2007 21:34:40 +0000
Subject: [PATCH 6/7] sparc64: fix section mismatch warning in pci_sunv4
Message-Id: <20070720213440.GG25064@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Wrong list address in first try.

----- Forwarded message from Sam Ravnborg <sam@ravnborg.org> -----

Subject: [PATCH 6/7] sparc64: fix section mismatch warning in pci_sunv4
Sender: linux-kernel-owner@vger.kernel.org
From: Sam Ravnborg <sam@ravnborg.org>
Date:	Fri, 20 Jul 2007 23:30:44 +0200
User-Agent: Mutt/1.4.2.1i
To: LKML <linux-kernel@vger.kernel.org>,
	David Miller <davem@davemloft.net>, sparc@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
X-Mailing-List:	linux-kernel@vger.kernel.org

Fix following warning:
WARNING: vmlinux.o(.text+0x3cf50): Section mismatch: reference to .init.text:page_in_phys_avail (between 'pci_sun4v_pbm_init' and 'sun4v_pci_init')

pci_sun4v_pbm_init and sun4v_pci_init was only used under __init
context so declare them _init.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc64/kernel/pci_sun4v.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc64/kernel/pci_sun4v.c b/arch/sparc64/kernel/pci_sun4v.c
index 6b3fe2c..639cf06 100644
--- a/arch/sparc64/kernel/pci_sun4v.c
+++ b/arch/sparc64/kernel/pci_sun4v.c
@@ -1129,7 +1129,7 @@ static void pci_sun4v_msi_init(struct pci_pbm_info *pbm)
 }
 #endif /* !(CONFIG_PCI_MSI) */
 
-static void pci_sun4v_pbm_init(struct pci_controller_info *p, struct device_node *dp, u32 devhandle)
+static void __init pci_sun4v_pbm_init(struct pci_controller_info *p, struct device_node *dp, u32 devhandle)
 {
 	struct pci_pbm_info *pbm;
 
@@ -1163,7 +1163,7 @@ static void pci_sun4v_pbm_init(struct pci_controller_info *p, struct device_node
 	pci_sun4v_msi_init(pbm);
 }
 
-void sun4v_pci_init(struct device_node *dp, char *model_name)
+void __init sun4v_pci_init(struct device_node *dp, char *model_name)
 {
 	static int hvapi_negotiated = 0;
 	struct pci_controller_info *p;
-- 
1.5.1.rc3.g84b7-dirty

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----
