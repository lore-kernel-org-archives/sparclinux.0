From: Ian Campbell <ian.campbell@citrix.com>
Date: Thu, 18 Aug 2011 08:14:57 +0000
Subject: [PATCH] sparc: fix array bounds error setting up PCIC NMI trap
Message-Id: <1313655297-20075-1-git-send-email-ian.campbell@citrix.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From a sparc64 defconfig:
  CC      arch/sparc/kernel/pcic.o
arch/sparc/kernel/pcic.c: In function 'pcic_probe':
arch/sparc/kernel/pcic.c:359:33: error: array subscript is above array bounds [-Werror=array-bounds]
arch/sparc/kernel/pcic.c:359:8: error: array subscript is above array bounds [-Werror=array-bounds]
arch/sparc/kernel/pcic.c:360:33: error: array subscript is above array bounds [-Werror=array-bounds]
arch/sparc/kernel/pcic.c:360:8: error: array subscript is above array bounds [-Werror=array-bounds]
arch/sparc/kernel/pcic.c:361:33: error: array subscript is above array bounds [-Werror=array-bounds]
arch/sparc/kernel/pcic.c:361:8: error: array subscript is above array bounds [-Werror=array-bounds]
cc1: all warnings being treated as errors

I'm not particularly familiar with sparc but t_nmi (defined in head_32.S via
the TRAP_ENTRY macro) and pcic_nmi_trap_patch (defined in entry.S) both appear
to be 4 instructions long and I presume from the usage that instructions are
int sized.

Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/kernel/pcic.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
index a19f041..1aaf8c1 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -352,8 +352,8 @@ int __init pcic_probe(void)
 	strcpy(pbm->prom_name, namebuf);
 
 	{
-		extern volatile int t_nmi[1];
-		extern int pcic_nmi_trap_patch[1];
+		extern volatile int t_nmi[4];
+		extern int pcic_nmi_trap_patch[4];
 
 		t_nmi[0] = pcic_nmi_trap_patch[0];
 		t_nmi[1] = pcic_nmi_trap_patch[1];
-- 
1.7.2.5

