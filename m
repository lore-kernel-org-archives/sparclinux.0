From: Daniel Hellstrom <daniel@gaisler.com>
Date: Thu, 09 Jun 2011 12:54:08 +0000
Subject: [PATCH 1/2] sparc32, sun4m: bugfix in SMP IPI traphandler
Message-Id: <1307624049-29690-1-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Three new IPIs were introduced by commit
ecbc42b70acbc6327adefe9635db93fcf62bf59d ("sparc32, sun4m:
Implemented SMP IPIs support for SUN4M machines"), the
old handler was already prepared for IPIs but handled only
IRQ14 and IRQ13, this patch adds support for the new IPI at
IRQ12.

The IPI trap handler looks at the mask rather than the
pending IRQ/IPI, this bug may have masked the problem
above, introduced by the same commit.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/kernel/entry.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index c4e6167..9fe08a1 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -229,7 +229,7 @@ real_irq_entry:
 #ifdef CONFIG_SMP
 	.globl	patchme_maybe_smp_msg
 
-	cmp	%l7, 12
+	cmp	%l7, 11
 patchme_maybe_smp_msg:
 	bgu	maybe_smp4m_msg
 	 nop
@@ -293,7 +293,7 @@ maybe_smp4m_msg:
 	WRITE_PAUSE
 	wr	%l4, PSR_ET, %psr
 	WRITE_PAUSE
-	sll	%o2, 28, %o2		! shift for simpler checks below
+	sll	%o3, 28, %o2		! shift for simpler checks below
 maybe_smp4m_msg_check_single:
 	andcc	%o2, 0x1, %g0
 	beq,a	maybe_smp4m_msg_check_mask
-- 
1.5.4

