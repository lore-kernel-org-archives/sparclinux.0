From: David Miller <davem@davemloft.net>
Date: Mon, 11 Sep 2017 04:03:51 +0000
Subject: Re: [PATCH V3] vDSO for SPARC
Message-Id: <20170910.210351.799178832332575508.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1502400887-281290-1-git-send-email-nagarathnam.muthusamy@oracle.com>
In-Reply-To: <1502400887-281290-1-git-send-email-nagarathnam.muthusamy@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Sat, 09 Sep 2017 20:41:29 -0700 (PDT)

> The arch/sparc/vdso/vdso.lds file says:
> 
> vvar_start = . -(1 << 12);
> 
> And "1 << 12" is 4096, therefore a multiple of 4096 and not 8192.
> 
> So, as requested, the object built gets:
> 
> davem@patience:~/src/GIT/sparc-next$ nm -n arch/sparc/vdso/vdso64.so.dbg
> fffffffffffff000 a vvar_data
> fffffffffffff000 a vvar_start

Breaking this down further, the linker scripts are written assuming
they will be built by a host compiler that generates 64-bit target
code by default.

This is not a safe assumption.

My system generates 32-bit binaries from gcc by default, and that's
why you end up with a value of PAGE_SIZE which is 4096 propagating
through all of the generated linker scripts.

x86, where it seems like were at least used as a template for the
sparc linker scripts, gets away with this because the PAGE_SIZE
is the same on 32-bit and 64-bit.

Anyways, since 8192 is hard coded into vdso2c, just use 8192 as
PAGE_SIZE in vdso-layout.lds.S and maybe put a comment above it.

The next problem with the patch is that we get a warning because
the variable 'secstrings_hdr' is set but not used in vdso2c.h, and
compiler warnings are treated as errors under arch/sparc.

This is fixed simply by:

diff --git a/arch/sparc/vdso/vdso2c.h b/arch/sparc/vdso/vdso2c.h
index 8d1b5cf..b193e3d 100644
--- a/arch/sparc/vdso/vdso2c.h
+++ b/arch/sparc/vdso/vdso2c.h
@@ -17,9 +17,8 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	unsigned long mapping_size;
 	int i;
 	unsigned long j;
-	const char *secstrings;
 
-	ELF(Shdr) *symtab_hdr = NULL, *strtab_hdr, *secstrings_hdr;
+	ELF(Shdr) *symtab_hdr = NULL, *strtab_hdr;
 	ELF(Ehdr) *hdr = (ELF(Ehdr) *)raw_addr;
 	ELF(Dyn) *dyn = 0, *dyn_end = 0;
 	INT_BITS syms[NSYMS] = {};
@@ -64,9 +63,6 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	}
 
 	/* Walk the section table */
-	secstrings_hdr = raw_addr + GET_BE(&hdr->e_shoff) +
-		GET_BE(&hdr->e_shentsize)*GET_BE(&hdr->e_shstrndx);
-	secstrings = raw_addr + GET_BE(&secstrings_hdr->sh_offset);
 	for (i = 0; i < GET_BE(&hdr->e_shnum); i++) {
 		ELF(Shdr) *sh = raw_addr + GET_BE(&hdr->e_shoff) +
 			GET_BE(&hdr->e_shentsize) * i;
