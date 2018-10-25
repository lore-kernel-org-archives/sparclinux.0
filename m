From: David Miller <davem@davemloft.net>
Date: Thu, 25 Oct 2018 04:45:45 +0000
Subject: Re: Vs: [sparc vdso] compile failure in v4.19-4243-ga978a5b - operation combines symbols in differen
Message-Id: <20181024.214545.322406053813140385.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <AM5PR0201MB23718E35D48CFE84CC40EE90E1F60@AM5PR0201MB2371.eurprd02.prod.outlook.com>
In-Reply-To: <AM5PR0201MB23718E35D48CFE84CC40EE90E1F60@AM5PR0201MB2371.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Wed, 24 Oct 2018 17:11:28 -0700 (PDT)

> I'll have to implement this another way so that it works with all
> versions of binutils.

Meelis, please test this patch.

diff --git a/arch/sparc/include/asm/vdso.h b/arch/sparc/include/asm/vdso.h
index 56836eb01787..59e79d35cd73 100644
--- a/arch/sparc/include/asm/vdso.h
+++ b/arch/sparc/include/asm/vdso.h
@@ -9,8 +9,6 @@ struct vdso_image {
 	void *data;
 	unsigned long size;   /* Always a multiple of PAGE_SIZE */
 
-	unsigned long tick_patch, tick_patch_len;
-
 	long sym_vvar_start;  /* Negative offset to the vvar area */
 };
 
diff --git a/arch/sparc/vdso/vclock_gettime.c b/arch/sparc/vdso/vclock_gettime.c
index 7b539ceebe13..55662c3b4513 100644
--- a/arch/sparc/vdso/vclock_gettime.c
+++ b/arch/sparc/vdso/vclock_gettime.c
@@ -90,16 +90,15 @@ notrace static __always_inline u64 vread_tick(void)
 {
 	u64	ret;
 
-	__asm__ __volatile__("1:\n\t"
-			     "rd		%%tick, %0\n\t"
-			     ".pushsection	.tick_patch, \"a\"\n\t"
-			     ".word		1b - ., 1f - .\n\t"
-			     ".popsection\n\t"
-			     ".pushsection	.tick_patch_replacement, \"ax\"\n\t"
-			     "1:\n\t"
-			     "rd		%%asr24, %0\n\t"
-			     ".popsection\n"
-			     : "=r" (ret));
+	__asm__ __volatile__("rd %%tick, %0" : "=r" (ret));
+	return ret;
+}
+
+notrace static __always_inline u64 vread_tick_stick(void)
+{
+	u64	ret;
+
+	__asm__ __volatile__("rd %%asr24, %0" : "=r" (ret));
 	return ret;
 }
 #else
@@ -107,16 +106,18 @@ notrace static __always_inline u64 vread_tick(void)
 {
 	register unsigned long long ret asm("o4");
 
-	__asm__ __volatile__("1:\n\t"
-			     "rd		%%tick, %L0\n\t"
-			     "srlx		%L0, 32, %H0\n\t"
-			     ".pushsection	.tick_patch, \"a\"\n\t"
-			     ".word		1b - ., 1f - .\n\t"
-			     ".popsection\n\t"
-			     ".pushsection	.tick_patch_replacement, \"ax\"\n\t"
-			     "1:\n\t"
-			     "rd		%%asr24, %L0\n\t"
-			     ".popsection\n"
+	__asm__ __volatile__("rd %%tick, %L0\n\t"
+			     "srlx %L0, 32, %H0"
+			     : "=r" (ret));
+	return ret;
+}
+
+notrace static __always_inline u64 vread_tick_stick(void)
+{
+	register unsigned long long ret asm("o4");
+
+	__asm__ __volatile__("rd %%asr24, %L0\n\t"
+			     "srlx %L0, 32, %H0"
 			     : "=r" (ret));
 	return ret;
 }
@@ -132,6 +133,16 @@ notrace static __always_inline u64 vgetsns(struct vvar_data *vvar)
 	return v * vvar->clock.mult;
 }
 
+notrace static __always_inline u64 vgetsns_stick(struct vvar_data *vvar)
+{
+	u64 v;
+	u64 cycles;
+
+	cycles = vread_tick_stick();
+	v = (cycles - vvar->clock.cycle_last) & vvar->clock.mask;
+	return v * vvar->clock.mult;
+}
+
 notrace static __always_inline int do_realtime(struct vvar_data *vvar,
 					       struct timespec *ts)
 {
@@ -152,6 +163,26 @@ notrace static __always_inline int do_realtime(struct vvar_data *vvar,
 	return 0;
 }
 
+notrace static __always_inline int do_realtime_stick(struct vvar_data *vvar,
+						     struct timespec *ts)
+{
+	unsigned long seq;
+	u64 ns;
+
+	do {
+		seq = vvar_read_begin(vvar);
+		ts->tv_sec = vvar->wall_time_sec;
+		ns = vvar->wall_time_snsec;
+		ns += vgetsns_stick(vvar);
+		ns >>= vvar->clock.shift;
+	} while (unlikely(vvar_read_retry(vvar, seq)));
+
+	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
+	ts->tv_nsec = ns;
+
+	return 0;
+}
+
 notrace static __always_inline int do_monotonic(struct vvar_data *vvar,
 						struct timespec *ts)
 {
@@ -172,6 +203,26 @@ notrace static __always_inline int do_monotonic(struct vvar_data *vvar,
 	return 0;
 }
 
+notrace static __always_inline int do_monotonic_stick(struct vvar_data *vvar,
+						      struct timespec *ts)
+{
+	unsigned long seq;
+	u64 ns;
+
+	do {
+		seq = vvar_read_begin(vvar);
+		ts->tv_sec = vvar->monotonic_time_sec;
+		ns = vvar->monotonic_time_snsec;
+		ns += vgetsns_stick(vvar);
+		ns >>= vvar->clock.shift;
+	} while (unlikely(vvar_read_retry(vvar, seq)));
+
+	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
+	ts->tv_nsec = ns;
+
+	return 0;
+}
+
 notrace static int do_realtime_coarse(struct vvar_data *vvar,
 				      struct timespec *ts)
 {
@@ -227,6 +278,31 @@ int
 clock_gettime(clockid_t, struct timespec *)
 	__attribute__((weak, alias("__vdso_clock_gettime")));
 
+notrace int
+__vdso_clock_gettime_stick(clockid_t clock, struct timespec *ts)
+{
+	struct vvar_data *vvd = get_vvar_data();
+
+	switch (clock) {
+	case CLOCK_REALTIME:
+		if (unlikely(vvd->vclock_mode = VCLOCK_NONE))
+			break;
+		return do_realtime_stick(vvd, ts);
+	case CLOCK_MONOTONIC:
+		if (unlikely(vvd->vclock_mode = VCLOCK_NONE))
+			break;
+		return do_monotonic_stick(vvd, ts);
+	case CLOCK_REALTIME_COARSE:
+		return do_realtime_coarse(vvd, ts);
+	case CLOCK_MONOTONIC_COARSE:
+		return do_monotonic_coarse(vvd, ts);
+	}
+	/*
+	 * Unknown clock ID ? Fall back to the syscall.
+	 */
+	return vdso_fallback_gettime(clock, ts);
+}
+
 notrace int
 __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
 {
@@ -262,3 +338,36 @@ __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
 int
 gettimeofday(struct timeval *, struct timezone *)
 	__attribute__((weak, alias("__vdso_gettimeofday")));
+
+notrace int
+__vdso_gettimeofday_stick(struct timeval *tv, struct timezone *tz)
+{
+	struct vvar_data *vvd = get_vvar_data();
+
+	if (likely(vvd->vclock_mode != VCLOCK_NONE)) {
+		if (likely(tv != NULL)) {
+			union tstv_t {
+				struct timespec ts;
+				struct timeval tv;
+			} *tstv = (union tstv_t *) tv;
+			do_realtime_stick(vvd, &tstv->ts);
+			/*
+			 * Assign before dividing to ensure that the division is
+			 * done in the type of tv_usec, not tv_nsec.
+			 *
+			 * There cannot be > 1 billion usec in a second:
+			 * do_realtime() has already distributed such overflow
+			 * into tv_sec.  So we can assign it to an int safely.
+			 */
+			tstv->tv.tv_usec = tstv->ts.tv_nsec;
+			tstv->tv.tv_usec /= 1000;
+		}
+		if (unlikely(tz != NULL)) {
+			/* Avoid memcpy. Some old compilers fail to inline it */
+			tz->tz_minuteswest = vvd->tz_minuteswest;
+			tz->tz_dsttime = vvd->tz_dsttime;
+		}
+		return 0;
+	}
+	return vdso_fallback_gettimeofday(tv, tz);
+}
diff --git a/arch/sparc/vdso/vdso-layout.lds.S b/arch/sparc/vdso/vdso-layout.lds.S
index ed36d49e1617..d31e57e8a3bb 100644
--- a/arch/sparc/vdso/vdso-layout.lds.S
+++ b/arch/sparc/vdso/vdso-layout.lds.S
@@ -73,9 +73,6 @@ SECTIONS
 
 	.text		: { *(.text*) }			:text	=0x90909090,
 
-	.tick_patch 	  : { *(.tick_patch) }		:text
-	.tick_patch_insns : { *(.tick_patch_insns) }	:text
-
 	/DISCARD/ : {
 		*(.discard)
 		*(.discard.*)
diff --git a/arch/sparc/vdso/vdso.lds.S b/arch/sparc/vdso/vdso.lds.S
index f3caa29a331c..629ab6900df7 100644
--- a/arch/sparc/vdso/vdso.lds.S
+++ b/arch/sparc/vdso/vdso.lds.S
@@ -18,8 +18,10 @@ VERSION {
 	global:
 		clock_gettime;
 		__vdso_clock_gettime;
+		__vdso_clock_gettime_stick;
 		gettimeofday;
 		__vdso_gettimeofday;
+		__vdso_gettimeofday_stick;
 	local: *;
 	};
 }
diff --git a/arch/sparc/vdso/vdso2c.h b/arch/sparc/vdso/vdso2c.h
index 4df005cf98c0..60d69acc748f 100644
--- a/arch/sparc/vdso/vdso2c.h
+++ b/arch/sparc/vdso/vdso2c.h
@@ -17,11 +17,9 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	unsigned long mapping_size;
 	int i;
 	unsigned long j;
-	ELF(Shdr) *symtab_hdr = NULL, *strtab_hdr, *secstrings_hdr,
-		*patch_sec = NULL;
+	ELF(Shdr) *symtab_hdr = NULL, *strtab_hdr;
 	ELF(Ehdr) *hdr = (ELF(Ehdr) *)raw_addr;
 	ELF(Dyn) *dyn = 0, *dyn_end = 0;
-	const char *secstrings;
 	INT_BITS syms[NSYMS] = {};
 
 	ELF(Phdr) *pt = (ELF(Phdr) *)(raw_addr + GET_BE(&hdr->e_phoff));
@@ -64,18 +62,11 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	}
 
 	/* Walk the section table */
-	secstrings_hdr = raw_addr + GET_BE(&hdr->e_shoff) +
-		GET_BE(&hdr->e_shentsize)*GET_BE(&hdr->e_shstrndx);
-	secstrings = raw_addr + GET_BE(&secstrings_hdr->sh_offset);
 	for (i = 0; i < GET_BE(&hdr->e_shnum); i++) {
 		ELF(Shdr) *sh = raw_addr + GET_BE(&hdr->e_shoff) +
 			GET_BE(&hdr->e_shentsize) * i;
 		if (GET_BE(&sh->sh_type) = SHT_SYMTAB)
 			symtab_hdr = sh;
-
-		if (!strcmp(secstrings + GET_BE(&sh->sh_name),
-			    ".tick_patch"))
-			patch_sec = sh;
 	}
 
 	if (!symtab_hdr)
@@ -142,12 +133,6 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	fprintf(outfile, "const struct vdso_image %s_builtin = {\n", name);
 	fprintf(outfile, "\t.data = raw_data,\n");
 	fprintf(outfile, "\t.size = %lu,\n", mapping_size);
-	if (patch_sec) {
-		fprintf(outfile, "\t.tick_patch = %lu,\n",
-			(unsigned long)GET_BE(&patch_sec->sh_offset));
-		fprintf(outfile, "\t.tick_patch_len = %lu,\n",
-			(unsigned long)GET_BE(&patch_sec->sh_size));
-	}
 	for (i = 0; i < NSYMS; i++) {
 		if (required_syms[i].export && syms[i])
 			fprintf(outfile, "\t.sym_%s = %" PRIi64 ",\n",
diff --git a/arch/sparc/vdso/vdso32/vdso32.lds.S b/arch/sparc/vdso/vdso32/vdso32.lds.S
index 53575ee154c4..218930fdff03 100644
--- a/arch/sparc/vdso/vdso32/vdso32.lds.S
+++ b/arch/sparc/vdso/vdso32/vdso32.lds.S
@@ -17,8 +17,10 @@ VERSION {
 	global:
 		clock_gettime;
 		__vdso_clock_gettime;
+		__vdso_clock_gettime_stick;
 		gettimeofday;
 		__vdso_gettimeofday;
+		__vdso_gettimeofday_stick;
 	local: *;
 	};
 }
diff --git a/arch/sparc/vdso/vma.c b/arch/sparc/vdso/vma.c
index 8874a27d8adc..154fe8adc090 100644
--- a/arch/sparc/vdso/vma.c
+++ b/arch/sparc/vdso/vma.c
@@ -42,24 +42,201 @@ static struct vm_special_mapping vdso_mapping32 = {
 
 struct vvar_data *vvar_data;
 
-struct tick_patch_entry {
-	s32 orig, repl;
+struct vdso_elfinfo32 {
+	Elf32_Ehdr	*hdr;
+	Elf32_Sym	*dynsym;
+	unsigned long	dynsymsize;
+	const char	*dynstr;
+	unsigned long	text;
 };
 
-static void stick_patch(const struct vdso_image *image)
+struct vdso_elfinfo64 {
+	Elf64_Ehdr	*hdr;
+	Elf64_Sym	*dynsym;
+	unsigned long	dynsymsize;
+	const char	*dynstr;
+	unsigned long	text;
+};
+
+struct vdso_elfinfo {
+	union {
+		struct vdso_elfinfo32 elf32;
+		struct vdso_elfinfo64 elf64;
+	} u;
+};
+
+static void *one_section64(struct vdso_elfinfo64 *e, const char *name,
+			   unsigned long *size)
+{
+	const char *snames;
+	Elf64_Shdr *shdrs;
+	unsigned int i;
+
+	shdrs = (void *)e->hdr + e->hdr->e_shoff;
+	snames = (void *)e->hdr + shdrs[e->hdr->e_shstrndx].sh_offset;
+	for (i = 1; i < e->hdr->e_shnum; i++) {
+		if (!strcmp(snames+shdrs[i].sh_name, name)) {
+			if (size)
+				*size = shdrs[i].sh_size;
+			return (void *)e->hdr + shdrs[i].sh_offset;
+		}
+	}
+	return NULL;
+}
+
+static int find_sections64(const struct vdso_image *image, struct vdso_elfinfo *_e)
+{
+	struct vdso_elfinfo64 *e = &_e->u.elf64;
+
+	e->hdr = image->data;
+	e->dynsym = one_section64(e, ".dynsym", &e->dynsymsize);
+	e->dynstr = one_section64(e, ".dynstr", NULL);
+
+	if (!e->dynsym || !e->dynstr) {
+		pr_err("VDSO64: Missing symbol sections.\n");
+		return -ENODEV;
+	}
+	return 0;
+}
+
+static Elf64_Sym *find_sym64(const struct vdso_elfinfo64 *e, const char *name)
+{
+	unsigned int i;
+
+	for (i = 0; i < (e->dynsymsize / sizeof(Elf64_Sym)); i++) {
+		Elf64_Sym *s = &e->dynsym[i];
+		if (s->st_name = 0)
+			continue;
+		if (!strcmp(e->dynstr + s->st_name, name))
+			return s;
+	}
+	return NULL;
+}
+
+static int patchsym64(struct vdso_elfinfo *_e, const char *orig,
+		      const char *new)
+{
+	struct vdso_elfinfo64 *e = &_e->u.elf64;
+	Elf64_Sym *osym = find_sym64(e, orig);
+	Elf64_Sym *nsym = find_sym64(e, new);
+
+	if (!nsym || !osym) {
+		pr_err("VDSO64: Missing symbols.\n");
+		return -ENODEV;
+	}
+	osym->st_value = nsym->st_value;
+	osym->st_size = nsym->st_size;
+	osym->st_info = nsym->st_info;
+	osym->st_other = nsym->st_other;
+	osym->st_shndx = nsym->st_shndx;
+
+	return 0;
+}
+
+static void *one_section32(struct vdso_elfinfo32 *e, const char *name,
+			   unsigned long *size)
+{
+	const char *snames;
+	Elf32_Shdr *shdrs;
+	unsigned int i;
+
+	shdrs = (void *)e->hdr + e->hdr->e_shoff;
+	snames = (void *)e->hdr + shdrs[e->hdr->e_shstrndx].sh_offset;
+	for (i = 1; i < e->hdr->e_shnum; i++) {
+		if (!strcmp(snames+shdrs[i].sh_name, name)) {
+			if (size)
+				*size = shdrs[i].sh_size;
+			return (void *)e->hdr + shdrs[i].sh_offset;
+		}
+	}
+	return NULL;
+}
+
+static int find_sections32(const struct vdso_image *image, struct vdso_elfinfo *_e)
+{
+	struct vdso_elfinfo32 *e = &_e->u.elf32;
+
+	e->hdr = image->data;
+	e->dynsym = one_section32(e, ".dynsym", &e->dynsymsize);
+	e->dynstr = one_section32(e, ".dynstr", NULL);
+
+	if (!e->dynsym || !e->dynstr) {
+		pr_err("VDSO32: Missing symbol sections.\n");
+		return -ENODEV;
+	}
+	return 0;
+}
+
+static Elf32_Sym *find_sym32(const struct vdso_elfinfo32 *e, const char *name)
 {
-	struct tick_patch_entry *p, *p_end;
+	unsigned int i;
+
+	for (i = 0; i < (e->dynsymsize / sizeof(Elf32_Sym)); i++) {
+		Elf32_Sym *s = &e->dynsym[i];
+		if (s->st_name = 0)
+			continue;
+		if (!strcmp(e->dynstr + s->st_name, name))
+			return s;
+	}
+	return NULL;
+}
 
-	p = image->data + image->tick_patch;
-	p_end = (void *)p + image->tick_patch_len;
-	while (p < p_end) {
-		u32 *instr = (void *)&p->orig + p->orig;
-		u32 *repl = (void *)&p->repl + p->repl;
+static int patchsym32(struct vdso_elfinfo *_e, const char *orig,
+		      const char *new)
+{
+	struct vdso_elfinfo32 *e = &_e->u.elf32;
+	Elf32_Sym *osym = find_sym32(e, orig);
+	Elf32_Sym *nsym = find_sym32(e, new);
 
-		*instr = *repl;
-		flushi(instr);
-		p++;
+	if (!nsym || !osym) {
+		pr_err("VDSO32: Missing symbols.\n");
+		return -ENODEV;
 	}
+	osym->st_value = nsym->st_value;
+	osym->st_size = nsym->st_size;
+	osym->st_info = nsym->st_info;
+	osym->st_other = nsym->st_other;
+	osym->st_shndx = nsym->st_shndx;
+
+	return 0;
+}
+
+static int find_sections(const struct vdso_image *image, struct vdso_elfinfo *e,
+			 bool elf64)
+{
+	if (elf64)
+		return find_sections64(image, e);
+	else
+		return find_sections32(image, e);
+}
+
+static int patch_one_symbol(struct vdso_elfinfo *e, const char *orig,
+			    const char *new_target, bool elf64)
+{
+	if (elf64)
+		return patchsym64(e, orig, new_target);
+	else
+		return patchsym32(e, orig, new_target);
+}
+
+static int stick_patch(const struct vdso_image *image, struct vdso_elfinfo *e, bool elf64)
+{
+	int err;
+
+	err = find_sections(image, e, elf64);
+	if (err)
+		return err;
+
+	err = patch_one_symbol(e,
+			       "__vdso_gettimeofday",
+			       "__vdso_gettimeofday_stick", elf64);
+	if (err)
+		return err;
+
+	return patch_one_symbol(e,
+				"__vdso_clock_gettime",
+				"__vdso_clock_gettime_stick", elf64);
+	return 0;
 }
 
 /*
@@ -67,13 +244,19 @@ static void stick_patch(const struct vdso_image *image)
  * kernel image.
  */
 int __init init_vdso_image(const struct vdso_image *image,
-		struct vm_special_mapping *vdso_mapping)
+			   struct vm_special_mapping *vdso_mapping, bool elf64)
 {
-	int i;
+	int cnpages = (image->size) / PAGE_SIZE;
 	struct page *dp, **dpp = NULL;
-	int dnpages = 0;
 	struct page *cp, **cpp = NULL;
-	int cnpages = (image->size) / PAGE_SIZE;
+	struct vdso_elfinfo ei;
+	int i, dnpages = 0;
+
+	if (tlb_type != spitfire) {
+		int err = stick_patch(image, &ei, elf64);
+		if (err)
+			return err;
+	}
 
 	/*
 	 * First, the vdso text.  This is initialied data, an integral number of
@@ -88,9 +271,6 @@ int __init init_vdso_image(const struct vdso_image *image,
 	if (!cpp)
 		goto oom;
 
-	if (tlb_type != spitfire)
-		stick_patch(image);
-
 	for (i = 0; i < cnpages; i++) {
 		cp = alloc_page(GFP_KERNEL);
 		if (!cp)
@@ -153,13 +333,13 @@ static int __init init_vdso(void)
 {
 	int err = 0;
 #ifdef CONFIG_SPARC64
-	err = init_vdso_image(&vdso_image_64_builtin, &vdso_mapping64);
+	err = init_vdso_image(&vdso_image_64_builtin, &vdso_mapping64, true);
 	if (err)
 		return err;
 #endif
 
 #ifdef CONFIG_COMPAT
-	err = init_vdso_image(&vdso_image_32_builtin, &vdso_mapping32);
+	err = init_vdso_image(&vdso_image_32_builtin, &vdso_mapping32, false);
 #endif
 	return err;
 
