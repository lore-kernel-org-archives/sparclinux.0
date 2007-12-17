From: Joe Perches <joe@perches.com>
Date: Mon, 17 Dec 2007 19:30:22 +0000
Subject: [PATCH] arch/sparc64/: Spelling fixes
Message-Id: <5703e57f925f31fc0eb38873bd7f10fc44f99cb4.1197918890.git.joe@perches.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org


Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/sparc64/kernel/pci_schizo.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sparc64/kernel/pci_schizo.c b/arch/sparc64/kernel/pci_schizo.c
index 9546ba9..e752e75 100644
--- a/arch/sparc64/kernel/pci_schizo.c
+++ b/arch/sparc64/kernel/pci_schizo.c
@@ -850,7 +850,7 @@ static int pbm_routes_this_ino(struct pci_pbm_info *pbm, u32 ino)
 /* How the Tomatillo IRQs are routed around is pure guesswork here.
  *
  * All the Tomatillo devices I see in prtconf dumps seem to have only
- * a single PCI bus unit attached to it.  It would seem they are seperate
+ * a single PCI bus unit attached to it.  It would seem they are separate
  * devices because their PortID (ie. JBUS ID) values are all different
  * and thus the registers are mapped to totally different locations.
  *
-- 
1.5.3.7.949.g2221a6

