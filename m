From: Julian Calaby <julian.calaby@gmail.com>
Date: Mon, 05 Jan 2009 13:22:18 +0000
Subject: [PATCH] sparc: Fix minor SPARC32 compile error
Message-Id: <4962098A.4070508@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

sparc: Fix minor SPARC32 compile error

When CONFIG_PROC_FS is unset, include/linux/interrupt.h defines
init_irq_proc() as an empty function.

arch/sparc/kernel/irq_32.c defines this function unconditionally.

Fix the latter so that it only defines this function when CONFIG_PROC_FS
is set.

This fixes the following error:
arch/sparc/kernel/irq_32.c:672: error: redefinition of 'init_irq_proc'
include/linux/interrupt.h:461: error: previous definition of
'init_irq_proc' was here

This was found using randconfig builds.

Signed-off-by: Julian Calaby <julian.calaby@gmail.com>

---

I understand that this is utterly insignificant, but I can't just let it
slide.

---

Sorry for the dupe, wrong account!

  arch/sparc/kernel/irq_32.c |    2 ++
  1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/irq_32.c b/arch/sparc/kernel/irq_32.c
index f3488c4..1eff942 100644
--- a/arch/sparc/kernel/irq_32.c
+++ b/arch/sparc/kernel/irq_32.c
@@ -669,7 +669,9 @@ void __init init_IRQ(void)
  	btfixup();
  }

+#ifdef CONFIG_PROC_FS
  void init_irq_proc(void)
  {
  	/* For now, nothing... */
  }
+#endif /* CONFIG_PROC_FS */
