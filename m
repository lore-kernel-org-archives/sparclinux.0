From: Kirill Tkhai <tkhai@yandex.ru>
Date: Wed, 20 Mar 2013 00:32:49 +0000
Subject: Re: [PATCH]sparc64: Hibernation support
Message-Id: <766521363739569@web4h.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <1580671362759586@web24e.yandex.ru>
In-Reply-To: <1580671362759586@web24e.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

20.03.2013, 01:37, "Sam Ravnborg" <sam@ravnborg.org>:
> On Fri, Mar 08, 2013 at 08:19:46PM +0400, Kirill Tkhai wrote:
>
>> =9AHi!
>>
>> =9AThis patch is for hibernation support on sparc64.
>
> Hi Kirill.
> Some late nitpick feedback.
>

Hi, Sam.

>> =9ATwo steps to try:
>> =9A1)"echo disk > /sys/power/state" makes a system sleeping
>> =9A2)kernel parameter "resume=3D/dev/[swap_partition]" will say
>> =9Athe system which swap partition to use for restore.
>>
>> =9AUse MMU bypass to copy data pages. This allowes not to
>> =9Acreate temporary page table as on some other architectures.
>>
>> =9AI changed mm/init_64.c because of restore may be called
>> =9Afrom initcall. This moment is before free_initmem(), so
>> =9Anum_physpages must not be changed in it. Otherwise,
>> =9Arestore fails by the reason of mismatched sizes of the loaded
>> =9Aimage and the system.
>>
>> =9AI tested the patch on single-core mcst-r1000 variant of v9.
>> =9AEverything work, but everybody is welcome to test it on any
>> =9Amore standard v9 :)
>>
>> =9ASigned-off-by: Kirill Tkhai <tkhai@yandex.ru>
>> =9ACC: David Miller <davem@davemloft.net>
>> =9A---
>> =9Adiff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
>> =9Aindex 9bff3db..9e1256f 100644
>> =9A--- a/arch/sparc/Kconfig
>> =9A+++ b/arch/sparc/Kconfig
>> =9A@@ -103,6 +103,9 @@ config HAVE_LATENCYTOP_SUPPORT
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9Abool
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9Adefault y if SPARC64
>>
>> =9A+config ARCH_HIBERNATION_POSSIBLE
>> =9A+ def_bool y if SPARC64
>> =9A+
>> =9A=9Aconfig AUDIT_ARCH
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9Abool
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9Adefault y
>> =9A@@ -333,6 +336,10 @@ config ARCH_SPARSEMEM_DEFAULT
>>
>> =9A=9Asource "mm/Kconfig"
>>
>> =9A+if SPARC64
>> =9A+source "kernel/power/Kconfig"
>> =9A+endif
>
> The if SPARC64 is really not needed. As far as I could see we
> do not enable anything uin there for sparc32 anyway.
> So the only purpose of adding the "if" thing is for documentation.

Otherwise it is shown at xconfig when "Show all options" is turned
on. I copied the way how "drivers/cpufreq/Kconfig" is included.

>
>> =9A+
>> =9A=9Aconfig SCHED_SMT
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9Abool "SMT (Hyperthreading) scheduler suppo=
rt"
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9Adepends on SPARC64 && SMP
>> =9Adiff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
>> =9Aindex 541b8b0..9ff4236 100644
>> =9A--- a/arch/sparc/Makefile
>> =9A+++ b/arch/sparc/Makefile
>> =9A@@ -57,6 +57,7 @@ core-y =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=
=9A=9A+=3D arch/sparc/
>> =9A=9Alibs-y =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A+=3D arch/s=
parc/prom/
>> =9A=9Alibs-y =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A+=3D arch/s=
parc/lib/
>>
>> =9A+drivers-$(CONFIG_PM) +=3D arch/sparc/power/
>> =9A=9Adrivers-$(CONFIG_OPROFILE) +=3D arch/sparc/oprofile/
>>
>> =9A=9Aboot :=3D arch/sparc/boot
>> =9Adiff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
>> =9Aindex 2feb15c..1a2ce1e 100644
>> =9Adiff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
>> =9Aindex 8410065..d4fc2f0 100644
>
> These looks bogus. Did you touch file permissions?

It's a wrong diff metadata. And one more below. Sorry.

>> =9Adiff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
>> =9Aindex 5c2c6e6..a40a845 100644
>> =9A--- a/arch/sparc/mm/init_64.c
>> =9A+++ b/arch/sparc/mm/init_64.c
>> =9A@@ -2061,7 +2061,7 @@ void __init mem_init(void)
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A* allocated below.
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A*/
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9Atotalram_pages -=3D 1;
>> =9A- num_physpages =3D totalram_pages;
>> =9A+ num_physpages =3D memblock_mem_size(last_valid_pfn) >> PAGE_SHIFT;
>>
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A/*
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A* Set up the zero page, mark it reserve=
d, so that page count
>> =9A@@ -2125,7 +2125,6 @@ void free_initmem(void)
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=
=9A=9AClearPageReserved(p);
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=
=9A=9Ainit_page_count(p);
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=
=9A=9A__free_page(p);
>> =9A- num_physpages++;
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=
=9A=9Atotalram_pages++;
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A}
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A}
>> =9A@@ -2142,7 +2141,6 @@ void free_initrd_mem(unsigned long start, unsig=
ned long end)
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9AClearPageReserved(=
p);
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9Ainit_page_count(p);
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A__free_page(p);
>> =9A- num_physpages++;
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9Atotalram_pages++;
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A}
>> =9A=9A}
>
> Could you separate this out as an independent change?
> I must admit I do not see why what you do here is OK.
>

The arch-independent places where num_physpages
is used are

inet_frags_init()
sanitize_global_limit()
__online_page_set_limits()
and hibernation code.

It looks like everything is OK with all of them.

>> =9Adiff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>> =9Aindex 8ad21a2..380e1a1 100644
>
> Looks bogus.
>
>> =9Adiff --git a/arch/sparc/power/Makefile b/arch/sparc/power/Makefile
>> =9Anew file mode 100644
>> =9Aindex 0000000..3201ace
>> =9A--- /dev/null
>> =9A+++ b/arch/sparc/power/Makefile
>> =9A@@ -0,0 +1,3 @@
>> =9A+# Makefile for Sparc-specific hibernate files.
>> =9A+
>> =9A+obj-$(CONFIG_HIBERNATION) +=3D hibernate.o hibernate_asm.o
>> =9Adiff --git a/arch/sparc/power/hibernate.c b/arch/sparc/power/hibernat=
e.c
>> =9Anew file mode 100644
>> =9Aindex 0000000..89ca059
>> =9A--- /dev/null
>> =9A+++ b/arch/sparc/power/hibernate.c
>> =9A@@ -0,0 +1,65 @@
>> =9A+/*
>> =9A+ * hibernate.c: =9AHibernaton support specific for sparc64.
>> =9A+ *
>> =9A+ * Copyright (C) 2013 Kirill V Tkhai (tkhai@yandex.ru)
>> =9A+ */
>> =9A+
>> =9A+#include <linux/mm.h>
>
> Empty line..
>

Yes, thanks for this and for other formatting points.

>> =9A+#include <asm/page.h>
>> =9A+#include <asm/tlb.h>
>> =9A+#include <asm/visasm.h>
>
> Inverse christmas tree. Longest lines first.
>
>> =9A+
>> =9A+
>> =9A+#include "hibernate.h"
>> =9A+
>> =9A+/* References to section boundaries */
>> =9A+extern const void __nosave_begin, __nosave_end;
>
> These belong in asm-generic/sections.h
> Consider submitting a separate patch to Arnd.
>> =9A+
>> =9A+struct saved_context {
>> =9A+ unsigned long fp;
>> =9A+ unsigned long cwp;
>> =9A+ unsigned long wstate;
>> =9A+
>> =9A+ unsigned long tick;
>> =9A+ unsigned long pstate;
>> =9A+
>> =9A+ unsigned long g4;
>> =9A+ unsigned long g5;
>> =9A+ unsigned long g6;
>> =9A+} saved_context;
>> =9A+
>> =9A+/*
>> =9A+ * pfn_is_nosave - check if given pfn is in the 'nosave' section
>> =9A+ */
>> =9A+
>> =9A+int pfn_is_nosave(unsigned long pfn)
>> =9A+{
>> =9A+ unsigned long nosave_begin_pfn =3D ((unsigned long)&__nosave_begin)=
 >> PAGE_SHIFT;
>> =9A+ unsigned long nosave_end_pfn =3D ((unsigned long)&__nosave_end) >> =
PAGE_SHIFT;
>
> Use PFN_DOWN
>
>> =9A+
>> =9A+ BUILD_BUG_ON(SC_REG_FP !=3D offsetof(struct saved_context, fp));
>> =9A+ BUILD_BUG_ON(SC_REG_CWP !=3D offsetof(struct saved_context, cwp));
>> =9A+ BUILD_BUG_ON(SC_REG_WSTATE !=3D offsetof(struct saved_context, wsta=
te));
>> =9A+
>> =9A+ BUILD_BUG_ON(SC_REG_TICK !=3D offsetof(struct saved_context, tick));
>> =9A+ BUILD_BUG_ON(SC_REG_PSTATE !=3D offsetof(struct saved_context, psta=
te));
>> =9A+
>> =9A+ BUILD_BUG_ON(SC_REG_G4 !=3D offsetof(struct saved_context, g4));
>> =9A+ BUILD_BUG_ON(SC_REG_G5 !=3D offsetof(struct saved_context, g5));
>> =9A+ BUILD_BUG_ON(SC_REG_G6 !=3D offsetof(struct saved_context, g6));
>
> Hmmm... See below.
>
>> =9A+
>> =9A+ return (pfn >=3D nosave_begin_pfn) && (pfn < nosave_end_pfn);
>> =9A+}
>> =9A+
>> =9A+void save_processor_state(void)
>> =9A+{
>> =9A+ save_and_clear_fpu();
>> =9A+}
>> =9A+
>> =9A+void restore_processor_state(void)
>> =9A+{
>> =9A+ struct mm_struct *mm =3D current->active_mm;
>> =9A+
>> =9A+ load_secondary_context(mm);
>> =9A+ tsb_context_switch(mm);
>> =9A+}
>> =9Adiff --git a/arch/sparc/power/hibernate.h b/arch/sparc/power/hibernat=
e.h
>> =9Anew file mode 100644
>> =9Aindex 0000000..6c002f4
>> =9A--- /dev/null
>> =9A+++ b/arch/sparc/power/hibernate.h
>> =9A@@ -0,0 +1,21 @@
>> =9A+/*
>> =9A+ * hibernate.c: =9AHibernaton support specific for sparc64.
>> =9A+ *
>> =9A+ * Copyright (C) 2013 Kirill V Tkhai (tkhai@yandex.ru)
>> =9A+ */
>> =9A+
>> =9A+#ifndef ___SPARC_HIBERNATE_H
>> =9A+#define ___SPARC_HIBERNATE_H
>> =9A+
>> =9A+#define SC_REG_FP 0
>> =9A+#define SC_REG_CWP 8
>> =9A+#define SC_REG_WSTATE 16
>> =9A+
>> =9A+#define SC_REG_TICK 24
>> =9A+#define SC_REG_PSTATE 32
>> =9A+
>> =9A+#define SC_REG_G4 40
>> =9A+#define SC_REG_G5 48
>> =9A+#define SC_REG_G6 56
>
> Use kernel/asm-offsets.c to generate these constants.
> This is relaiable and you can skip the run-time checks above.
>

Good advice. I'll follow it.

>> =9A+
>> =9A+#endif
>> =9Adiff --git a/arch/sparc/power/hibernate_asm.S b/arch/sparc/power/hibe=
rnate_asm.S
>> =9Anew file mode 100644
>> =9Aindex 0000000..8cc5c4e
>> =9A--- /dev/null
>> =9A+++ b/arch/sparc/power/hibernate_asm.S
>> =9A@@ -0,0 +1,129 @@
>> =9A+/*
>> =9A+ * hibernate.c: =9AHibernaton support specific for sparc64.
>> =9A+ *
>> =9A+ * Copyright (C) 2013 Kirill V Tkhai (tkhai@yandex.ru)
>> =9A+ */
>> =9A+
>> =9A+#include <linux/linkage.h>
>> =9A+#include <asm/page.h>
>> =9A+#include <asm/cpudata.h>
>> =9A+#include "hibernate.h"
>
> Empty lines between the blocks.
> And inverse christmas tree again.
>
> For the asm part I did not look at it carefully.
> But a few comments anyway.
>
>> =9A+
>> =9A+ENTRY(swsusp_arch_suspend)
>> =9A+ save %sp, -192, %sp
>> =9A+ save %sp, -192, %sp
>
> This looks strange. Why two times?

It's because I want save only
one %o or %i register -- %i6 (fp). Othervise
it's necessary to save at least one more -- %i7.

>
>> =9A+ flushw
>> =9A+
>> =9A+ setuw saved_context, %g3
>> =9A+
>> =9A+ /* Save window regs */
>> =9A+ rdpr %cwp, %g2
>> =9A+ stx %g2, [%g3 + SC_REG_CWP]
>> =9A+ rdpr %wstate, %g2
>> =9A+ stx %g2, [%g3 + SC_REG_WSTATE]
>> =9A+ stx %fp, [%g3 + SC_REG_FP]
>> =9A+
>> =9A+ /* Save state regs */
>> =9A+ rdpr %tick, %g2
>> =9A+ stx %g2, [%g3 + SC_REG_TICK]
>> =9A+ rdpr %pstate, %g2
>> =9A+ stx %g2, [%g3 + SC_REG_PSTATE]
>> =9A+
>> =9A+ /* Save global regs */
>> =9A+ stx %g4, [%g3 + SC_REG_G4]
>> =9A+ stx %g5, [%g3 + SC_REG_G5]
>> =9A+ stx %g6, [%g3 + SC_REG_G6]
>> =9A+
>> =9A+ call swsusp_save
>> =9A+ nop
>> =9A+
>> =9A+ mov %o0, %i0
>> =9A+ restore
>> =9A+
>> =9A+ =9A=9A=9A=9A=9A=9A=9Amov %o0, %i0
>
> Uses space for indent =3D> use tab
>
>> =9A+ ret
>> =9A+ restore
>> =9A+
>> =9A+ENTRY(swsusp_arch_resume)
>> =9A+ /* Write restore_pblist to %l0 */
>> =9A+ sethi %hi(restore_pblist), %l0
>> =9A+ =9A=9A=9A=9A=9A=9A=9Aldx [%l0 + %lo(restore_pblist)], %l0
>
> Uses space for indent =3D> use tab
>
>> =9A+
>> =9A+ call __flush_tlb_all
>> =9A+ nop
>> =9A+
>> =9A+ /* Write PAGE_OFFSET to %g7 */
>> =9A+ sethi %uhi(PAGE_OFFSET), %g7
>> =9A+ sllx %g7, 32, %g7
>> =9A+
>> =9A+ setuw (PAGE_SIZE-8), %g3
>> =9A+
>> =9A+ /* Use MMU Bypass */
>> =9A+ rd %asi, %g1
>> =9A+ wr %g0, ASI_PHYS_USE_EC, %asi
>> =9A+
>> =9A+ /* Fill ITLB */
>> =9A+ ba 16f
>> =9A+ nop
>> =9A+
>> =9A+pbe_loop:
>> =9A+ cmp %l0, %g0
>> =9A+ be restore_ctx
>> =9A+ sub %l0, %g7, %l0
>
> Add empty line after delay slot
>
>> =9A+ ldxa [%l0 =9A=9A=9A] %asi, %l1 /* address */
>> =9A+ ldxa [%l0 + 8] %asi, %l2 /* orig_address */
>> =9A+
>> =9A+ /* phys addr */
>> =9A+ sub %l1, %g7, %l1
>> =9A+ sub %l2, %g7, %l2
>> =9A+
>> =9A+ mov %g3, %l3 /* PAGE_SIZE-8 */
>> =9A+copy_loop:
>> =9A+ ldxa [%l1 + %l3] ASI_PHYS_USE_EC, %g2
>> =9A+ stxa %g2, [%l2 + %l3] ASI_PHYS_USE_EC
>> =9A+ cmp %l3, %g0
>> =9A+ bne copy_loop
>> =9A+ sub %l3, 8, %l3
>> =9A+
>> =9A+ /* next pbe */
>> =9A+ ba pbe_loop
>> =9A+ ldxa [%l0 + 16] %asi, %l0
>> =9A+
>> =9A+restore_ctx:
>> =9A+ setuw saved_context, %g3
>> =9A+ wrpr %g0, 15, %pil
>> =9A+
>> =9A+ /* Restore window regs */
>> =9A+ wrpr =9A=9A=9A%g0, 0, %canrestore
>> =9A+ wrpr =9A=9A=9A%g0, 0, %otherwin
>> =9A+ wrpr %g0, 6, %cansave
>> =9A+ wrpr =9A=9A=9A%g0, 0, %cleanwin
>> =9A+
>> =9A+ ldxa [%g3 + SC_REG_CWP] %asi, %g2
>> =9A+ wrpr %g2, %cwp
>> =9A+ ldxa [%g3 + SC_REG_WSTATE] %asi, %g2
>> =9A+ wrpr %g2, %wstate
>> =9A+ ldxa [%g3 + SC_REG_FP] %asi, %fp
>> =9A+
>> =9A+ /* Restore state regs */
>> =9A+ ldxa [%g3 + SC_REG_PSTATE] %asi, %g2
>> =9A+ wrpr %g2, %pstate
>> =9A+ ldxa [%g3 + SC_REG_TICK] %asi, %g2
>> =9A+ wrpr %g2, %tick
>> =9A+
>> =9A+ /* Restore global regs */
>> =9A+ ldxa [%g3 + SC_REG_G4] %asi, %g4
>> =9A+ ldxa [%g3 + SC_REG_G5] %asi, %g5
>> =9A+ ldxa [%g3 + SC_REG_G6] %asi, %g6
>> =9A+
>> =9A+ wr %g1, %g0, %asi
>> =9A+
>> =9A+ restore
>> =9A+ restore
>> =9A+
>> =9A+ wrpr %g0, 14, %pil
>> =9A+
>> =9A+ retl
>> =9A+ mov %g0, %o0
>> =9A+
>> =9A+16: ba,a pbe_loop
>
> All other labels have nice names - and then suddenly a label named "16"?
> And you are missing an instruction in the delay slot here.

Now, I think mask NMI earlier and put this action as delayed instruction
for this for the present unnamed branch. Looks like all copying must
processes with level=15.

Thanks for feedback, I will send new patch a little later.

Kirill
