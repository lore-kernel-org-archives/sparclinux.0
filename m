From: "Arno Schuring" <aelschuring@hotmail.com>
Date: Fri, 01 Oct 2004 21:32:54 +0000
Subject: Need help recompiling (debugging) proll-18
Message-Id: <BAY2-DAV15hGvDpEDiO00029bde@hotmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----=_NextPart_000_0076_01C4A80E.F9C0D7F0"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0076_01C4A80E.F9C0D7F0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit


Hello list!

(I hope this is the correct list to post questions like this, maybe I should
have mailed Pete Zaitcev directly but I couldn't find his email address on
the proll site, nor did I wish to possibly offend him)

I'm at a loss getting my Krups working (yes it's old, I know). I have tried
several approaches to remote-boot it (I don't have a spare sun machine - I
cross-compile from i586) but have only failed so far :(

I have tried both homemade and precompiled kernels, but keep getting stuck
either at "couldn't open root device xx" or "can't open initial console".

To remedy this I set out to change the command line options proll passes to
the kernel. I thought I could edit proll's sources and recompile. However,
my executables keep freezing the javastation, and I'm stuck as to why... not
surprising, since I've never worked on sparc processors before.

Anyways, I've hacked in a number of debug statements and I believe I have
identified the failing instruction but don't understand why it's failing.
Here's the final printk output of proll:

init_mmu_swift: flushing cache
init_mmu_swift: switching ctx table
init_mmu_swift: clearing old table references
--freeze--

(see attached system.c, function init_mmu_swift)
The offending instruction seems to be

        __asm__ __volatile__ ("sta %%g0, [%0] %1\n\t" : :
            "r" (0x400), "i" (ASI_M_FLUSH_PROBE) : "memory");

commenting out this instruction does allow the program to continue but
causes the krups to reboot itself in a second... quite understandable since
the tlb is probably filled with invalid addresses.

But now the question: why is it failing? A dissassembly of both the original
and new executable yields no functional differences in this function (other
than the debug printk's) - the ret/restore instead of retl can't be the
problem, since it's never reached, or can it?

/tmp/proll.krups.ID18:     file format a.out-sunos-big
Disassembly of section .text:
(...)
    42e0:       86 10 20 00     clr  %g3
    42e4:       05 00 00 07     sethi  %hi(0x1c00), %g2
    42e8:       92 10 a3 ff     or  %g2, 0x3ff, %o1     ! 0x1fff
    42ec:       c0 a0 c1 c0     sta  %g0, [ %g3 ] (14)
    42f0:       85 28 e0 01     sll  %g3, 1, %g2
    42f4:       c0 a0 81 80     sta  %g0, [ %g2 ] #ASI_N_L
    42f8:       86 00 e0 10     add  %g3, 0x10, %g3
    42fc:       80 a0 c0 09     cmp  %g3, %o1
    4300:       08 bf ff fb     bleu  0x42ec
    4304:       84 10 21 00     mov  0x100, %g2
    4308:       91 32 20 04     srl  %o0, 4, %o0
    430c:       d0 a0 80 80     sta  %o0, [ %g2 ] #ASI_N
    4310:       84 10 24 00     mov  0x400, %g2
    4314:       c0 a0 80 60     sta  %g0, [ %g2 ] (3)
    4318:       81 c3 e0 08     retl
    431c:       01 00 00 00     nop
(...)


proll.aout:     file format a.out-sunos-big
Disassembly of section .text:
(...)
    429c:       9d e3 bf 98     save  %sp, -104, %sp
d    42a0:       11 3f f4 3d     sethi  %hi(0xffd0f400), %o0
d    42a4:       40 00 00 da     call  0x460c
d    42a8:       90 12 22 e8     or  %o0, 0x2e8, %o0     ! 0xffd0f6e8
    42ac:       84 10 20 00     clr  %g2
    42b0:       03 00 00 07     sethi  %hi(0x1c00), %g1
    42b4:       86 10 63 ff     or  %g1, 0x3ff, %g3     ! 0x1fff
    42b8:       c0 a0 81 c0     sta  %g0, [ %g2 ] (14)
    42bc:       82 00 80 02     add  %g2, %g2, %g1
    42c0:       c0 a0 41 80     sta  %g0, [ %g1 ] #ASI_N_L
    42c4:       84 00 a0 10     add  %g2, 0x10, %g2
    42c8:       80 a0 80 03     cmp  %g2, %g3
    42cc:       08 bf ff fb     bleu  0x42b8
    42d0:       01 00 00 00     nop
d    42d4:       11 3f f4 3d     sethi  %hi(0xffd0f400), %o0
d    42d8:       40 00 00 cd     call  0x460c
d    42dc:       90 12 23 08     or  %o0, 0x308, %o0     ! 0xffd0f708
    42e0:       b1 36 20 04     srl  %i0, 4, %i0
    42e4:       82 10 21 00     mov  0x100, %g1
    42e8:       f0 a0 40 80     sta  %i0, [ %g1 ] #ASI_N
d    42ec:       11 3f f4 3d     sethi  %hi(0xffd0f400), %o0
d    42f0:       40 00 00 c7     call  0x460c
d    42f4:       90 12 23 30     or  %o0, 0x330, %o0     ! 0xffd0f730
    42f8:       82 10 24 00     mov  0x400, %g1
    42fc:       c0 a0 40 60     sta  %g0, [ %g1 ] (3)
d    4300:       11 3f f4 3d     sethi  %hi(0xffd0f400), %o0
d    4304:       40 00 00 c2     call  0x460c
d    4308:       90 12 23 60     or  %o0, 0x360, %o0     ! 0xffd0f760
    430c:       01 00 00 00     nop
    4310:       81 c7 e0 08     ret
    4314:       81 e8 00 00     restore
(...)


I realise this is a very specific issue, but any help would be welcome.


Kind regards,
Arno Schuring

------=_NextPart_000_0076_01C4A80E.F9C0D7F0
Content-Type: application/octet-stream;
	name="system.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="system.c"

/**=0A=
 ** Proll (PROM replacement)=0A=
 ** system.c: shared miscallenea.=0A=
 ** Copyright 1999 Pete Zaitcev=0A=
 ** This code is licensed under GNU General Public License.=0A=
 **/=0A=
#include <stdarg.h>=0A=
#include <asi.h>=0A=
#include <crs.h>=0A=
#ifndef NULL=0A=
#define	NULL ((void*)0)=0A=
#endif=0A=
=0A=
#include "pgtsrmmu.h"=0A=
=0A=
#include "vconsole.h"=0A=
#include <timer.h>		/* Local copy of 2.2 style include */=0A=
#include <general.h>		/* __P() */=0A=
#include <net.h>		/* init_net() */=0A=
#include <romlib.h>		/* we are a provider for part of this. */=0A=
#include <netpriv.h>		/* myipaddr */=0A=
#include <arpa.h>=0A=
#include <system.h>		/* our own prototypes */=0A=
=0A=
/*=0A=
 * We export this.=0A=
 */=0A=
char idprom[IDPROM_SIZE];=0A=
=0A=
void probe_bank(struct bank *p, unsigned int, unsigned int, unsigned =
int);=0A=
int probe_memory_word(unsigned int addr, unsigned int alias);=0A=
int probe_virt_addr(unsigned int address, int write);=0A=
int probe_phys_addr(unsigned int address, int write);=0A=
=0A=
/*=0A=
 * Poke the hardware and fill bank structure.=0A=
 * By necessity this routine knows too much about MrCoffee specifics.=0A=
 * Also a lot of black magic happens here because we do not know=0A=
 * the right way to probe stuff. For example, leave bank zero empty=0A=
 * and put 8MB into bank one. PROM detects 8MB just fine, but we=0A=
 * detect 1MB in bank 0 - bullshit alert. XXX=0A=
 */=0A=
void get_banks_layout(struct banks *p, unsigned int maxbanks)=0A=
{=0A=
	int x;		/* Fill index for bankv[] */=0A=
	int i;=0A=
	unsigned int base, bs =3D 32*1024*1024;=0A=
=0A=
	x =3D 0;=0A=
	base =3D 0;=0A=
	for (i =3D 0; i < maxbanks; i++) {=0A=
		probe_bank(&p->bankv[x], base, 1024*1024, bs);=0A=
		if (p->bankv[x].length !=3D 0) x++;=0A=
		base +=3D bs;=0A=
	}=0A=
	p->nbanks =3D x;=0A=
}=0A=
=0A=
void probe_bank(struct bank *p,=0A=
    unsigned int base, unsigned int minsize, unsigned int maxsize)=0A=
{=0A=
	unsigned size;=0A=
=0A=
	/*=0A=
	 * Watch for overflows in address arithmetics.=0A=
	 */=0A=
	size =3D minsize;=0A=
	for (;;) {=0A=
		if (size =3D=3D minsize) {=0A=
			if (base !=3D 0) {=0A=
				/*=0A=
				 * This clause is not really necessary but...=0A=
				 */=0A=
				if (probe_memory_word(base + size - sizeof(int),=0A=
				    0 + size - sizeof(int)) !=3D 0) {=0A=
					p->start =3D base;=0A=
					p->length =3D 0;=0A=
					return;=0A=
				}=0A=
			} else {=0A=
				if (probe_memory_word(base + size - sizeof(int),=0A=
				    0) !=3D 0) {=0A=
					p->start =3D base;=0A=
					p->length =3D 0;=0A=
					return;=0A=
				}=0A=
			}=0A=
		} else {=0A=
			if (probe_memory_word(base + size - sizeof(int),=0A=
			    base + (size >> 1) - sizeof(int)) !=3D 0) {=0A=
				p->start =3D base;=0A=
				p->length =3D size >> 1;=0A=
				return;=0A=
			}=0A=
		}=0A=
		if (size >=3D maxsize) break;=0A=
		size <<=3D 1;=0A=
	}=0A=
	p->start =3D base;=0A=
	p->length =3D size;=0A=
	return;=0A=
}=0A=
=0A=
/*=0A=
 * Read write memory and see if it works.=0A=
 * Check for aliasing.=0A=
 */=0A=
int probe_memory_word(unsigned int addr, unsigned int alias) {=0A=
	unsigned save, salias;=0A=
	unsigned xval, xalias;=0A=
=0A=
	if (alias !=3D 0) {=0A=
		if (probe_phys_addr(addr, 0) !=3D 0) {=0A=
			printk("read fault at 0x%x\n", addr);=0A=
			return -1;=0A=
		}=0A=
		save =3D ld_bypass(addr);=0A=
		salias =3D ld_bypass(alias);=0A=
		if (probe_phys_addr(addr, 1) !=3D 0) {=0A=
			printk("write fault at 0x%x\n", addr);=0A=
			return -1;=0A=
		}=0A=
=0A=
		st_bypass(alias, save);=0A=
		st_bypass(addr, ~save);=0A=
		xalias =3D ld_bypass(alias);=0A=
		xval =3D ld_bypass(addr);=0A=
		st_bypass(addr, save);=0A=
		st_bypass(alias, salias);=0A=
=0A=
		if (xval !=3D (~save)) {=0A=
			printk("no memory at 0x%x\n", addr);=0A=
			return -1;=0A=
		}=0A=
		if (xalias !=3D save) {=0A=
#if 0=0A=
			printk("memory at 0x%x aliased to 0x%x\n",=0A=
			    addr, alias);=0A=
#endif=0A=
			return -1;=0A=
		}=0A=
	} else {=0A=
		if (probe_phys_addr(addr, 0) !=3D 0) {=0A=
			printk("read fault at 0x%x\n", addr);=0A=
			return -1;=0A=
		}=0A=
		save =3D ld_bypass(addr);=0A=
		if (probe_phys_addr(addr, 1) !=3D 0) {=0A=
			printk("write fault at 0x%x\n", addr);=0A=
			return -1;=0A=
		}=0A=
		st_bypass(addr, ~save);=0A=
		xval =3D ld_bypass(addr);=0A=
		st_bypass(addr, save);=0A=
		if (xval !=3D (~save)) {=0A=
			printk("no memory at 0x%x\n", addr);=0A=
			return -1;=0A=
		}=0A=
	}=0A=
	/* printk("memory at 0x%x\n", addr); */ /* P3 */=0A=
	return 0;=0A=
}=0A=
=0A=
#if 0=0A=
/*=0A=
 * Poke at the given address, return the success/failure.=0A=
 * This code cooperates with srmmu_fault in head.S.=0A=
 */=0A=
int		/* 0 - OK, <>0 - faulted */=0A=
probe_virt_addr(unsigned int address, int write)=0A=
{=0A=
	volatile extern unsigned int ignore_fault;=0A=
	volatile extern int fault_ignored;=0A=
	int dum;=0A=
=0A=
	printk("probing 0x%x...", address);=0A=
	fault_ignored =3D 0;=0A=
	ignore_fault =3D address;=0A=
	if (write) {=0A=
		*(volatile unsigned int *)address =3D 0x00ff7700;=0A=
	} else {=0A=
		dum =3D *(volatile unsigned int *)address;=0A=
	}=0A=
	ignore_fault =3D 0;=0A=
	if (fault_ignored) {=0A=
		printk(" fault taken\n");=0A=
	} else {=0A=
		printk(" no fault\n");=0A=
	}=0A=
	return fault_ignored;=0A=
}=0A=
#endif=0A=
=0A=
/*=0A=
 * Create an I/O mapping to pa[size].=0A=
 * Returns va of the mapping or 0 if unsuccessful.=0A=
 */=0A=
void *=0A=
map_io(unsigned pa, int size)=0A=
{=0A=
	void *va;=0A=
	unsigned int npages;=0A=
	unsigned int off;=0A=
	unsigned int mva;=0A=
=0A=
	off =3D pa & (PAGE_SIZE-1);=0A=
	npages =3D (off + size + (PAGE_SIZE-1)) / PAGE_SIZE;=0A=
	pa &=3D ~(PAGE_SIZE-1);=0A=
=0A=
	va =3D mem_alloc(&cio, npages*PAGE_SIZE, PAGE_SIZE);=0A=
	if (va =3D=3D 0) return va;=0A=
=0A=
	mva =3D (unsigned int) va;=0A=
    /* printk("map_io: va 0x%x pa 0x%x off 0x%x npages %d\n", va, pa, =
off, npages); */ /* P3 */=0A=
	while (npages-- !=3D 0) {=0A=
		map_page(pmem.pl1, mva, pa, 1, pmem.pbas);=0A=
		mva +=3D PAGE_SIZE;=0A=
		pa +=3D PAGE_SIZE;=0A=
	}=0A=
=0A=
	return (void *)((unsigned int)va + off);=0A=
}=0A=
=0A=
/*=0A=
 * Tablewalk routine used for testing.=0A=
 * Returns PTP/PTE.=0A=
 */=0A=
unsigned int=0A=
proc_tablewalk(int ctx, unsigned int va)=0A=
{=0A=
	unsigned int pa1;=0A=
=0A=
	__asm__ __volatile__ ("lda [%1] %2, %0" :=0A=
				"=3Dr" (pa1) :=0A=
				"r" (AC_M_CTPR), "i" (ASI_M_MMUREGS));=0A=
	/* printk(" ctpr %x ctx %x\n", pa1, ctx); */ /* P3 */=0A=
	pa1 <<=3D 4;=0A=
	pa1 =3D ld_bypass(pa1 + (ctx << 2));=0A=
	if ((pa1 & 0x03) =3D=3D 0) goto invalid;=0A=
	return mem_tablewalk((pa1 & 0xFFFFFFF0) << 4, va);=0A=
=0A=
invalid:=0A=
	printk(" invalid %x\n", pa1);=0A=
	return 0;=0A=
}=0A=
=0A=
/*=0A=
 * Walk the tables in memory, starting at physical address pa.=0A=
 */=0A=
unsigned int=0A=
mem_tablewalk(unsigned int pa, unsigned int va)=0A=
{=0A=
	unsigned int pa1;=0A=
=0A=
	printk("pa %x va %x", pa, va);=0A=
	pa1 =3D ld_bypass(pa + (((va&0xFF000000)>>24) << 2));=0A=
	if ((pa1 & 0x03) =3D=3D 0) goto invalid;=0A=
	printk(" l1 %x", pa1);=0A=
	pa1 <<=3D 4;    pa1 &=3D 0xFFFFFF00;=0A=
	pa1 =3D ld_bypass(pa1 + (((va&0x00FC0000)>>18) << 2));=0A=
	if ((pa1 & 0x03) =3D=3D 0) goto invalid;=0A=
	printk(" l2 %x", pa1);=0A=
	pa1 <<=3D 4;    pa1 &=3D 0xFFFFFF00;=0A=
	pa1 =3D ld_bypass(pa1 + (((va&0x0003F000)>>12) << 2));=0A=
	if ((pa1 & 0x03) =3D=3D 0) goto invalid;=0A=
	printk(" l3 %x", pa1);=0A=
	printk(" off %x\n", va&0x00000FFF);=0A=
	return pa1;=0A=
invalid:=0A=
	printk(" invalid %x\n", pa1);=0A=
	return 0;=0A=
}=0A=
=0A=
/*=0A=
 * Make CPU page tables.=0A=
 * Returns pointer to context table.=0A=
 * Here we ignore memory allocation errors which "should not happen"=0A=
 * because we cannot print anything anyways if memory initialization =
fails.=0A=
 */=0A=
void makepages(struct phym *t, unsigned int highbase)=0A=
{=0A=
	unsigned int *ctp, *l1, pte;=0A=
	int i;=0A=
	unsigned int pa, va;=0A=
=0A=
	ctp =3D mem_zalloc(&cmem, NCTX_SWIFT*sizeof(int), =
NCTX_SWIFT*sizeof(int));=0A=
	l1 =3D mem_zalloc(&cmem, 256*sizeof(int), 256*sizeof(int));=0A=
=0A=
	pte =3D SRMMU_ET_PTD | (((unsigned int)l1 - PROLBASE + highbase) >> 4);=0A=
	for (i =3D 0; i < NCTX_SWIFT; i++) {=0A=
		ctp[i] =3D pte;=0A=
	}=0A=
=0A=
	pa =3D highbase;=0A=
	for (va =3D PROLBASE; va < PROLBASE+PROLSIZE; va +=3D PAGE_SIZE) {=0A=
		map_page(l1, va, pa, 0, highbase);=0A=
		pa +=3D PAGE_SIZE;=0A=
	}=0A=
=0A=
	/* We need to start from LOADBASE, but kernel wants PAGE_SIZE. */=0A=
	pa =3D PAGE_SIZE;=0A=
	for (va =3D PAGE_SIZE; va < LOWMEMSZ; va +=3D PAGE_SIZE) {=0A=
		map_page(l1, va, pa, 0, highbase);=0A=
		pa +=3D PAGE_SIZE;=0A=
	}=0A=
=0A=
	t->pctp =3D ctp;=0A=
	t->pl1 =3D l1;=0A=
	t->pbas =3D highbase;=0A=
}=0A=
=0A=
/*=0A=
 * Create a memory mapping from va to epa in page table pgd.=0A=
 * highbase is used for v2p translation.=0A=
 */=0A=
int=0A=
map_page(unsigned int *pgd, unsigned int va,=0A=
    unsigned int epa, int type, unsigned int highbase)=0A=
{=0A=
	unsigned int pte;=0A=
	unsigned int *p;=0A=
	unsigned int pa;=0A=
=0A=
	pte =3D pgd[((va)>>SRMMU_PGDIR_SHIFT) & (SRMMU_PTRS_PER_PGD-1)];=0A=
	if ((pte & SRMMU_ET_MASK) =3D=3D SRMMU_ET_INVALID) {=0A=
		p =3D mem_zalloc(&cmem, SRMMU_PTRS_PER_PMD*sizeof(int),=0A=
		    SRMMU_PTRS_PER_PMD*sizeof(int));=0A=
		if (p =3D=3D 0) goto drop;=0A=
		pte =3D SRMMU_ET_PTD |=0A=
		    (((unsigned int)p - PROLBASE + highbase) >> 4);=0A=
		pgd[((va)>>SRMMU_PGDIR_SHIFT) & (SRMMU_PTRS_PER_PGD-1)] =3D pte;=0A=
		/* barrier() */=0A=
	}=0A=
=0A=
	pa =3D ((pte & 0xFFFFFFF0) << 4);=0A=
	pa +=3D (((va)>>SRMMU_PMD_SHIFT & (SRMMU_PTRS_PER_PMD-1)) << 2);=0A=
	pte =3D ld_bypass(pa);=0A=
	if ((pte & SRMMU_ET_MASK) =3D=3D SRMMU_ET_INVALID) {=0A=
		p =3D mem_zalloc(&cmem, SRMMU_PTRS_PER_PTE*sizeof(int),=0A=
		    SRMMU_PTRS_PER_PTE*sizeof(int));=0A=
		if (p =3D=3D 0) goto drop;=0A=
		pte =3D SRMMU_ET_PTD |=0A=
		    (((unsigned int)p - PROLBASE + highbase) >> 4);=0A=
		st_bypass(pa, pte);=0A=
	}=0A=
=0A=
	pa =3D ((pte & 0xFFFFFFF0) << 4);=0A=
	pa +=3D (((va)>>PAGE_SHIFT & (SRMMU_PTRS_PER_PTE-1)) << 2);=0A=
=0A=
	pte =3D SRMMU_ET_PTE | ((epa & PAGE_MASK) >> 4);=0A=
	if (type) {		/* I/O */=0A=
		pte |=3D SRMMU_REF;=0A=
		/* SRMMU cannot make Supervisor-only, but not exectutable */=0A=
		pte |=3D SRMMU_PRIV;=0A=
	} else {		/* memory */=0A=
		pte |=3D SRMMU_REF|SRMMU_CACHE;=0A=
		pte |=3D SRMMU_PRIV;		/* Supervisor only access */=0A=
	}=0A=
	st_bypass(pa, pte);=0A=
	return 0;=0A=
=0A=
drop:=0A=
	return -1;=0A=
}=0A=
=0A=
/*=0A=
 * Poke at the given physical address, return the success/failure.=0A=
 * This technique is sun4m specific and works for lower 4GB only.=0A=
 * This code cooperates with srmmu_fault in head.S.=0A=
 * Actually bypass access never produces a fault on Swift.=0A=
 * Instead it returns a random bus traffic happened before.=0A=
 */=0A=
int		/* 0 - OK, <>0 - faulted */=0A=
probe_phys_addr(unsigned int address, int write)=0A=
{=0A=
	volatile extern unsigned int ignore_fault;=0A=
	volatile extern int fault_ignored;=0A=
	int dum;=0A=
=0A=
	fault_ignored =3D 0;=0A=
	ignore_fault =3D address;=0A=
	if (write) {=0A=
		st_bypass(address, 0x00ff7700);=0A=
	} else {=0A=
		dum =3D ld_bypass(address);=0A=
	}=0A=
	ignore_fault =3D 0;=0A=
	return fault_ignored;=0A=
}=0A=
=0A=
/*=0A=
 * Switch page tables.=0A=
 */=0A=
void=0A=
init_mmu_swift(unsigned int ctp_phy)=0A=
{=0A=
	unsigned int addr;=0A=
=0A=
#ifdef DEBUG=0A=
	printk("init_mmu_swift: flushing cache\n");=0A=
#endif=0A=
	/*=0A=
	 * Flush cache=0A=
	 */=0A=
	for (addr =3D 0; addr < 0x2000; addr +=3D 0x10) {=0A=
		__asm__ __volatile__ ("sta %%g0, [%0] %1\n\t" : :=0A=
		    "r" (addr), "i" (ASI_M_DATAC_TAG));=0A=
		__asm__ __volatile__ ("sta %%g0, [%0] %1\n\t" : :=0A=
		    "r" (addr<<1), "i" (ASI_M_TXTC_TAG));=0A=
	}=0A=
=0A=
#ifdef DEBUG=0A=
	printk("init_mmu_swift: switching ctx table\n");=0A=
#endif=0A=
	/*=0A=
	 * Switch ctx table=0A=
	 */=0A=
	ctp_phy >>=3D 4;=0A=
	/* printk("done flushing, switching to %x\n", ctp_phy); */=0A=
	__asm__ __volatile__ ("sta %0, [%1] %2\n\t" : :=0A=
	    "r" (ctp_phy), "r" (AC_M_CTPR), "i" (ASI_M_MMUREGS));=0A=
=0A=
#ifdef DEBUG=0A=
	printk("init_mmu_swift: clearing old table references\n");=0A=
#endif=0A=
	/*=0A=
	 * Flush old page table references=0A=
	 */=0A=
	/* this instruction freezes our Krups :( */=0A=
	__asm__ __volatile__ ("sta %%g0, [%0] %1\n\t" : : =0A=
	    "r" (0x400), "i" (ASI_M_FLUSH_PROBE) : "memory");=0A=
#ifdef DEBUG=0A=
	printk("init_mmu_swift: done\n");=0A=
#endif=0A=
}=0A=
=0A=
/*=0A=
 * add_timer, del_timer=0A=
 * This should go into sched.c, but we have it split for different archs.=0A=
 */=0A=
struct timer_list_head {=0A=
	struct timer_list *head, *tail;=0A=
};=0A=
=0A=
static struct timer_list_head timers;		/* Anonymous heap of timers */=0A=
=0A=
void add_timer(struct timer_list *timer) {=0A=
	struct timer_list *p;=0A=
	if (timer->prev !=3D NULL || timer->next !=3D NULL) {=0A=
		printk("bug: kernel timer added twice at 0x%x.\n",=0A=
		    __builtin_return_address(0));=0A=
		return;=0A=
	}=0A=
	if ((p =3D timers.tail) !=3D NULL) {=0A=
		timer->prev =3D p;=0A=
		p->next =3D timer;=0A=
		timers.tail =3D timer;=0A=
	} else {=0A=
		timers.head =3D timer;=0A=
		timers.tail =3D timer;=0A=
	}=0A=
	return;=0A=
}=0A=
=0A=
int del_timer(struct timer_list *timer) {=0A=
	struct timer_list *p;=0A=
	int ret;=0A=
=0A=
	if (timers.head =3D=3D timer) timers.head =3D timer->next;=0A=
	if (timers.tail =3D=3D timer) timers.tail =3D timer->prev;=0A=
	if ((p =3D timer->prev) !=3D NULL) p->next =3D timer->next;=0A=
	if ((p =3D timer->next) !=3D NULL) p->prev =3D timer->prev;=0A=
	ret =3D timer->next !=3D 0 || timer->prev !=3D 0;=0A=
	timer->next =3D NULL;=0A=
	timer->prev =3D NULL;=0A=
	return ret;=0A=
}=0A=
=0A=
void run_timers() {=0A=
	struct timer_list *p;=0A=
=0A=
	p =3D timers.head;=0A=
	while (p !=3D NULL) {=0A=
		if (p->expires < jiffies) {=0A=
			del_timer(p);		/* XXX make nonstatic member */=0A=
			(*p->function)(p->data);=0A=
			p =3D timers.head;=0A=
		} else {=0A=
			p =3D p->next;=0A=
		}=0A=
	}=0A=
}=0A=
=0A=
/*=0A=
 * Allocate memory. This is reusable.=0A=
 */=0A=
void mem_init(struct mem *t, char *begin, char *limit)=0A=
{=0A=
	t->start =3D begin;=0A=
	t->uplim =3D limit;=0A=
	t->curp =3D begin;=0A=
}=0A=
=0A=
void mem_fini(struct mem *t)=0A=
{=0A=
	t->curp =3D 0;=0A=
}=0A=
=0A=
void *mem_alloc(struct mem *t, int size, int align)=0A=
{=0A=
	char *p;=0A=
=0A=
	p =3D (char *)((((unsigned int)t->curp) + (align-1)) & ~(align-1));=0A=
	if (p >=3D t->uplim || p + size > t->uplim) return 0;=0A=
	t->curp =3D p + size;=0A=
	return p;=0A=
}=0A=
=0A=
void *mem_zalloc(struct mem *t, int size, int align)=0A=
{=0A=
	char *p;=0A=
=0A=
	if ((p =3D mem_alloc(t, size, align)) !=3D 0) //bzero(p, size);=0A=
	while (size--) *((char *)p)++ =3D 0;=0A=
	return p;=0A=
}=0A=
=0A=
/*=0A=
 * Library functions=0A=
 */=0A=
void bzero(void *s, int len) {=0A=
	while (len--) *((char *)s)++ =3D 0;=0A=
}=0A=
=0A=
void bcopy(void *f, void *t, int len) {=0A=
	while (len--) *((char *)t)++ =3D *((char *)f)++;=0A=
}=0A=
=0A=
/* Comparison is 7-bit */=0A=
int bcmp(void *s1, void *s2, int len)=0A=
{=0A=
	int i;=0A=
	char ch;=0A=
=0A=
	while (len--) {=0A=
		ch =3D *((char *)s1)++;=0A=
		if ((i =3D ch - *((char *)s2)++) !=3D 0)=0A=
			return i;=0A=
		if (ch =3D=3D 0)=0A=
			return 0;=0A=
	}=0A=
	return 0;=0A=
}=0A=
=0A=
int strlen(char *s) {=0A=
	char *p;=0A=
	for (p =3D s; *p !=3D 0; p++) { }=0A=
	return p - s;=0A=
}=0A=
=0A=
void printk(char *fmt, ...)=0A=
{=0A=
	struct prf_fp {=0A=
		void *xfp;=0A=
		void (*write)(void *, char *, int);=0A=
	} prfa;=0A=
	extern void prf(struct prf_fp *, char *fmt, va_list adx);=0A=
	va_list x1;=0A=
=0A=
	va_start(x1, fmt);=0A=
	prfa.xfp =3D &dp0;=0A=
	prfa.write =3D (void*)vcon_write;=0A=
	prf(&prfa, fmt, x1);=0A=
	va_end(x1);=0A=
}=0A=
=0A=
/* This is taken from x86 to be used in network kernel. Returns 15 bits. =
*/=0A=
short int random()=0A=
{=0A=
	static unsigned int seed =3D 151;=0A=
	seed =3D (seed + 23968)*0x015A4E35 >> 1;=0A=
	return seed & 0x7FFF;=0A=
}=0A=
=0A=
void fatal()=0A=
{=0A=
	printk("fatal.");=0A=
loop: goto loop;=0A=
}=0A=
=0A=
/*=0A=
 * Get the highest bit number from the mask.=0A=
 */=0A=
int highc(int mask, int size)=0A=
{=0A=
	int m1;=0A=
=0A=
	m1 =3D 1 << size;=0A=
	while (size !=3D 0) {=0A=
		size--;=0A=
		m1 >>=3D 1;=0A=
		if (m1 & mask) break;=0A=
	}=0A=
	return size;=0A=
}=0A=
=0A=
/*=0A=
 */=0A=
unsigned int ld_bp_swap(unsigned int ptr) {=0A=
	unsigned int n;=0A=
	n =3D ld_bypass(ptr);=0A=
	n =3D (n>>24 & 0xFF) | (n>>8 & 0xFF00) | ((n&0xFF00) << 8) | (n<<24);=0A=
	return n;=0A=
}=0A=
=0A=
void st_bp_swap(unsigned int ptr, unsigned int n) {=0A=
	n =3D (n>>24 & 0xFF) | (n>>8 & 0xFF00) | ((n&0xFF00) << 8) | (n<<24);=0A=
	st_bypass(ptr, n);=0A=
};=0A=

------=_NextPart_000_0076_01C4A80E.F9C0D7F0--
