From: David Miller <davem@davemloft.net>
Date: Tue, 23 Oct 2018 02:19:26 +0000
Subject: [PATCH 1/8] sparc: Improve VDSO instruction patching.
Message-Id: <20181022.191926.999144615634322470.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


The current VDSO patch mechanism has several problems:

1) It assumes how gcc will emit a function, with a register
   window, an initial save instruction and then immediately
   the %tick read when compiling vread_tick().

   There is no such guarantees, code generation could change
   at any time, gcc could put a nop between the save and
   the %tick read, etc.

   So this is extremely fragile and would fail some day.

2) It disallows us to properly inline vread_tick() into the callers
   and thus get the best possible code sequences.

So fix this to patch properly, with location based annotations.

We have to be careful because we cannot do it the way we do
patches elsewhere in the kernel.  Those use a sequence like:

	1:
	insn
	.section	.whatever_patch, "ax"
	.word		1b
	replacement_insn
	.previous

This is a dynamic shared object, so that .word cannot be resolved at
build time, and thus cannot be used to execute the patches when the
kernel initializes the images.

Even trying to use label difference equations doesn't work in the
above kind of scheme:

	1:
	insn
	.section	.whatever_patch, "ax"
	.word		. - 1b
	replacement_insn
	.previous

The assembler complains that it cannot resolve that computation.
The issue is that this is contained in an executable section.

Borrow the sequence used by x86 alternatives, which is:

	1:
	insn
	.pushsection	.whatever_patch, "a"
	.word		. - 1b, . - 1f
	.popsection
	.pushsection	.whatever_patch_replacements, "ax"
	1:
	replacement_insn
	.previous

This works, allows us to inline vread_tick() as much as we like, and
can be used for arbitrary kinds of VDSO patching in the future.

Also, reverse the condition for patching.  Most systems are %stick
based, so if we only patch on %tick systems the patching code will
get little or no testing.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/vdso.h     |  6 ++---
 arch/sparc/kernel/time_64.c       |  3 ---
 arch/sparc/vdso/vclock_gettime.c  | 41 ++++++++++++++++++-------------
 arch/sparc/vdso/vdso-layout.lds.S |  7 ++----
 arch/sparc/vdso/vdso2c.c          |  6 -----
 arch/sparc/vdso/vdso2c.h          | 18 ++++++++++++--
 arch/sparc/vdso/vma.c             | 39 +++++++++++++++++------------
 7 files changed, 68 insertions(+), 52 deletions(-)

diff --git a/arch/sparc/include/asm/vdso.h b/arch/sparc/include/asm/vdso.h
index 93b628731a5e..56836eb01787 100644
--- a/arch/sparc/include/asm/vdso.h
+++ b/arch/sparc/include/asm/vdso.h
@@ -8,10 +8,10 @@
 struct vdso_image {
 	void *data;
 	unsigned long size;   /* Always a multiple of PAGE_SIZE */
+
+	unsigned long tick_patch, tick_patch_len;
+
 	long sym_vvar_start;  /* Negative offset to the vvar area */
-	long sym_vread_tick; /* Start of vread_tick section */
-	long sym_vread_tick_patch_start; /* Start of tick read */
-	long sym_vread_tick_patch_end;   /* End of tick read */
 };
 
 #ifdef CONFIG_SPARC64
diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
index f0eba72aa1ad..5f356dc8e178 100644
--- a/arch/sparc/kernel/time_64.c
+++ b/arch/sparc/kernel/time_64.c
@@ -53,8 +53,6 @@
 
 DEFINE_SPINLOCK(rtc_lock);
 
-unsigned int __read_mostly vdso_fix_stick;
-
 #ifdef CONFIG_SMP
 unsigned long profile_pc(struct pt_regs *regs)
 {
@@ -838,7 +836,6 @@ void __init time_init_early(void)
 		} else {
 			init_tick_ops(&tick_operations);
 			clocksource_tick.archdata.vclock_mode = VCLOCK_TICK;
-			vdso_fix_stick = 1;
 		}
 	} else {
 		init_tick_ops(&stick_operations);
diff --git a/arch/sparc/vdso/vclock_gettime.c b/arch/sparc/vdso/vclock_gettime.c
index 75dca9aab737..a0c8a4b008d5 100644
--- a/arch/sparc/vdso/vclock_gettime.c
+++ b/arch/sparc/vdso/vclock_gettime.c
@@ -105,29 +105,36 @@ static notrace noinline u64
 vread_tick(void) {
 	u64	ret;
 
-	__asm__ __volatile__("rd	%%asr24, %0 \n"
-			     ".section	.vread_tick_patch, \"ax\" \n"
-			     "rd	%%tick, %0 \n"
-			     ".previous \n"
-			     : "=&r" (ret));
+	__asm__ __volatile__("1:\n\t"
+			     "rd		%%tick, %0\n\t"
+			     ".pushsection	.tick_patch, \"a\"\n\t"
+			     ".word		1b - ., 1f - .\n\t"
+			     ".popsection\n\t"
+			     ".pushsection	.tick_patch_replacement, \"ax\"\n\t"
+			     "1:\n\t"
+			     "rd		%%asr24, %0\n\t"
+			     ".popsection\n"
+			     : "=r" (ret));
 	return ret & ~TICK_PRIV_BIT;
 }
 #else
 static notrace noinline u64
 vread_tick(void)
 {
-	unsigned int lo, hi;
-
-	__asm__ __volatile__("rd	%%asr24, %%g1\n\t"
-			     "srlx	%%g1, 32, %1\n\t"
-			     "srl	%%g1, 0, %0\n"
-			     ".section	.vread_tick_patch, \"ax\" \n"
-			     "rd	%%tick, %%g1\n"
-			     ".previous \n"
-			     : "=&r" (lo), "=&r" (hi)
-			     :
-			     : "g1");
-	return lo | ((u64)hi << 32);
+	register unsigned long long ret asm("o4");
+
+	__asm__ __volatile__("1:\n\t"
+			     "rd		%%tick, %L0\n\t"
+			     "srlx		%L0, 32, %H0\n\t"
+			     ".pushsection	.tick_patch, \"a\"\n\t"
+			     ".word		1b - ., 1f - .\n\t"
+			     ".popsection\n\t"
+			     ".pushsection	.tick_patch_replacement, \"ax\"\n\t"
+			     "1:\n\t"
+			     "rd		%%asr24, %L0\n\t"
+			     ".popsection\n"
+			     : "=r" (ret));
+	return ret;
 }
 #endif
 
diff --git a/arch/sparc/vdso/vdso-layout.lds.S b/arch/sparc/vdso/vdso-layout.lds.S
index f2c83abaca12..ed36d49e1617 100644
--- a/arch/sparc/vdso/vdso-layout.lds.S
+++ b/arch/sparc/vdso/vdso-layout.lds.S
@@ -73,11 +73,8 @@ SECTIONS
 
 	.text		: { *(.text*) }			:text	=0x90909090,
 
-	.vread_tick_patch : {
-		vread_tick_patch_start = .;
-		*(.vread_tick_patch)
-		vread_tick_patch_end = .;
-	}
+	.tick_patch 	  : { *(.tick_patch) }		:text
+	.tick_patch_insns : { *(.tick_patch_insns) }	:text
 
 	/DISCARD/ : {
 		*(.discard)
diff --git a/arch/sparc/vdso/vdso2c.c b/arch/sparc/vdso/vdso2c.c
index 9f5b1cd6d51d..ab7504176a7f 100644
--- a/arch/sparc/vdso/vdso2c.c
+++ b/arch/sparc/vdso/vdso2c.c
@@ -63,9 +63,6 @@ enum {
 	sym_vvar_start,
 	sym_VDSO_FAKE_SECTION_TABLE_START,
 	sym_VDSO_FAKE_SECTION_TABLE_END,
-	sym_vread_tick,
-	sym_vread_tick_patch_start,
-	sym_vread_tick_patch_end
 };
 
 struct vdso_sym {
@@ -81,9 +78,6 @@ struct vdso_sym required_syms[] = {
 	[sym_VDSO_FAKE_SECTION_TABLE_END] = {
 		"VDSO_FAKE_SECTION_TABLE_END", 0
 	},
-	[sym_vread_tick] = {"vread_tick", 1},
-	[sym_vread_tick_patch_start] = {"vread_tick_patch_start", 1},
-	[sym_vread_tick_patch_end] = {"vread_tick_patch_end", 1}
 };
 
 __attribute__((format(printf, 1, 2))) __attribute__((noreturn))
diff --git a/arch/sparc/vdso/vdso2c.h b/arch/sparc/vdso/vdso2c.h
index 808decb0f7be..4df005cf98c0 100644
--- a/arch/sparc/vdso/vdso2c.h
+++ b/arch/sparc/vdso/vdso2c.h
@@ -17,10 +17,11 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	unsigned long mapping_size;
 	int i;
 	unsigned long j;
-
-	ELF(Shdr) *symtab_hdr = NULL, *strtab_hdr;
+	ELF(Shdr) *symtab_hdr = NULL, *strtab_hdr, *secstrings_hdr,
+		*patch_sec = NULL;
 	ELF(Ehdr) *hdr = (ELF(Ehdr) *)raw_addr;
 	ELF(Dyn) *dyn = 0, *dyn_end = 0;
+	const char *secstrings;
 	INT_BITS syms[NSYMS] = {};
 
 	ELF(Phdr) *pt = (ELF(Phdr) *)(raw_addr + GET_BE(&hdr->e_phoff));
@@ -63,11 +64,18 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	}
 
 	/* Walk the section table */
+	secstrings_hdr = raw_addr + GET_BE(&hdr->e_shoff) +
+		GET_BE(&hdr->e_shentsize)*GET_BE(&hdr->e_shstrndx);
+	secstrings = raw_addr + GET_BE(&secstrings_hdr->sh_offset);
 	for (i = 0; i < GET_BE(&hdr->e_shnum); i++) {
 		ELF(Shdr) *sh = raw_addr + GET_BE(&hdr->e_shoff) +
 			GET_BE(&hdr->e_shentsize) * i;
 		if (GET_BE(&sh->sh_type) = SHT_SYMTAB)
 			symtab_hdr = sh;
+
+		if (!strcmp(secstrings + GET_BE(&sh->sh_name),
+			    ".tick_patch"))
+			patch_sec = sh;
 	}
 
 	if (!symtab_hdr)
@@ -134,6 +142,12 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	fprintf(outfile, "const struct vdso_image %s_builtin = {\n", name);
 	fprintf(outfile, "\t.data = raw_data,\n");
 	fprintf(outfile, "\t.size = %lu,\n", mapping_size);
+	if (patch_sec) {
+		fprintf(outfile, "\t.tick_patch = %lu,\n",
+			(unsigned long)GET_BE(&patch_sec->sh_offset));
+		fprintf(outfile, "\t.tick_patch_len = %lu,\n",
+			(unsigned long)GET_BE(&patch_sec->sh_size));
+	}
 	for (i = 0; i < NSYMS; i++) {
 		if (required_syms[i].export && syms[i])
 			fprintf(outfile, "\t.sym_%s = %" PRIi64 ",\n",
diff --git a/arch/sparc/vdso/vma.c b/arch/sparc/vdso/vma.c
index 5eaff3c1aa0c..8874a27d8adc 100644
--- a/arch/sparc/vdso/vma.c
+++ b/arch/sparc/vdso/vma.c
@@ -16,6 +16,8 @@
 #include <linux/linkage.h>
 #include <linux/random.h>
 #include <linux/elf.h>
+#include <asm/cacheflush.h>
+#include <asm/spitfire.h>
 #include <asm/vdso.h>
 #include <asm/vvar.h>
 #include <asm/page.h>
@@ -40,7 +42,25 @@ static struct vm_special_mapping vdso_mapping32 = {
 
 struct vvar_data *vvar_data;
 
-#define	SAVE_INSTR_SIZE	4
+struct tick_patch_entry {
+	s32 orig, repl;
+};
+
+static void stick_patch(const struct vdso_image *image)
+{
+	struct tick_patch_entry *p, *p_end;
+
+	p = image->data + image->tick_patch;
+	p_end = (void *)p + image->tick_patch_len;
+	while (p < p_end) {
+		u32 *instr = (void *)&p->orig + p->orig;
+		u32 *repl = (void *)&p->repl + p->repl;
+
+		*instr = *repl;
+		flushi(instr);
+		p++;
+	}
+}
 
 /*
  * Allocate pages for the vdso and vvar, and copy in the vdso text from the
@@ -68,21 +88,8 @@ int __init init_vdso_image(const struct vdso_image *image,
 	if (!cpp)
 		goto oom;
 
-	if (vdso_fix_stick) {
-		/*
-		 * If the system uses %tick instead of %stick, patch the VDSO
-		 * with instruction reading %tick instead of %stick.
-		 */
-		unsigned int j, k = SAVE_INSTR_SIZE;
-		unsigned char *data = image->data;
-
-		for (j = image->sym_vread_tick_patch_start;
-		     j < image->sym_vread_tick_patch_end; j++) {
-
-			data[image->sym_vread_tick + k] = data[j];
-			k++;
-		}
-	}
+	if (tlb_type != spitfire)
+		stick_patch(image);
 
 	for (i = 0; i < cnpages; i++) {
 		cp = alloc_page(GFP_KERNEL);
-- 
2.19.1.328.g5a0cc8aca
