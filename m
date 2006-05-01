From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 01 May 2006 05:51:00 +0000
Subject: Re: kernel oops with 2.6.17-rc1 & 2.6.17-rc2
Message-Id: <20060430.225100.62708777.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200604280042.08024.pkarlsen@mandriva.com>
In-Reply-To: <200604280042.08024.pkarlsen@mandriva.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Per =D8yvind Karlsen <pkarlsen@mandriva.com>
Date: Fri, 28 Apr 2006 00:42:07 +0200

> When running 2.6.17-rc1 or rc2 I seem to get a lot of these oops, not cer=
tain=20
> about what exactly causes those, but might seem to happen during a little=
=20
> load..
> 2.6.16 runs fine without this ever happening.
>=20
> Machine is a blade 100..

I did some investigating.  Do you have preemption enabled?  That's the
only way this bug could possibly trigger.

Jim reported a nearly identical OOPS to your's and his provided config
has preemption enabled.

This patch should fix the problem:

diff --git a/arch/sparc64/mm/tlb.c b/arch/sparc64/mm/tlb.c
index a079cf4..3f10fc9 100644
--- a/arch/sparc64/mm/tlb.c
+++ b/arch/sparc64/mm/tlb.c
@@ -8,6 +8,7 @@ #include <linux/init.h>
 #include <linux/percpu.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
+#include <linux/preempt.h>
=20
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -24,6 +25,8 @@ void flush_tlb_pending(void)
 {
 	struct mmu_gather *mp =3D &__get_cpu_var(mmu_gathers);
=20
+	preempt_disable();
+
 	if (mp->tlb_nr) {
 		flush_tsb_user(mp);
=20
@@ -38,6 +41,8 @@ #endif
 		}
 		mp->tlb_nr =3D 0;
 	}
+
+	preempt_enable();
 }
=20
 void tlb_batch_add(struct mm_struct *mm, unsigned long vaddr, pte_t *ptep,=
 pte_t orig)
