From: Meelis Roos <mroos@linux.ee>
Date: Wed, 14 Apr 2004 11:36:01 +0000
Subject: Re: 2.6.5+BK compile error: binfmt_elf on sparc64
Message-Id: <Pine.GSO.4.44.0404141432210.643-100000@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Yes, the patch fixes the warnings, it compiles and runs. I don't know
whether 0xf0000000 is the right TASK_SIZE for 32-bit binaries but it
seems to be:
include/asm-sparc/page.h:#define PAGE_OFFSET  0xf0000000


=== arch/sparc64/kernel/binfmt_elf32.c 1.10 vs edited ==--- 1.10/arch/sparc64/kernel/binfmt_elf32.c	Mon Feb 23 20:12:56 2004
+++ edited/arch/sparc64/kernel/binfmt_elf32.c	Wed Apr 14 14:05:08 2004
@@ -151,4 +151,7 @@
 #undef MODULE_DESCRIPTION
 #undef MODULE_AUTHOR

+#undef TASK_SIZE
+#define TASK_SIZE 0xf0000000
+
 #include "../../../fs/binfmt_elf.c"



> > Because of -Werror, it bails out:
> >
> > In file included from arch/sparc64/kernel/binfmt_elf32.c:154:
> > fs/binfmt_elf.c: In function `load_elf_interp':
> > fs/binfmt_elf.c:369: warning: comparison is always false due to limited range of data type
> > fs/binfmt_elf.c: In function `load_elf_binary':
> > fs/binfmt_elf.c:780: warning: comparison is always false due to limited range of data type
> >
> > It's the comparision "elf_ppnt->p_memsz > TASK_SIZE".
> >
> > p_memsz is Elf32_Word, TASK_SIZE is defined as
> > #define TASK_SIZE       ((unsigned long)-VPTE_SIZE)
> >
> > At the first glance I can't see what's wrong here.
>
> Well, since "unsigned long" is 64 bits on 64 bits, then presumably TASK_SIZE
> will be a very large (> 2^32) number, right?  Since p_memsz is only 32-bits it
> can never be > TASK_SIZE and so the comparison is always false.
>
> Since is the ELF loader for 32-bit binaries I imagine it should be comparing
> against the TASK_SIZE that's used on sparc32 kernels or something like that
> (0xf0000000 I believe)
>
> So you probably need to add a
>
> #undef TASK_SIZE
> #define TASK_SIZE 0xf0000000
>
> near the end of arch/sparc64/kernel/binfmt_elf32.c (before the final
> include of the normal binfmt_elf.c file)

-- 
Meelis Roos (mroos@linux.ee)

