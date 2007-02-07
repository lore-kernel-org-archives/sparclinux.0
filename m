From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Date: Wed, 07 Feb 2007 16:23:50 +0000
Subject: Re: Linux Kernel Markers : sparc build issue
Message-Id: <20070207162350.GA3025@Krystal>
List-Id: <sparclinux.vger.kernel.org>
References: <20070206153225.GA13251@Krystal>
In-Reply-To: <20070206153225.GA13251@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

* Frank Ch. Eigler (fche@redhat.com) wrote:
>=20
> Perhaps you could post excerpts of "objdump -dr <file.o>", to see the
> disassembly / relocations in question.
>=20
> - FChE

Hi Frank,

(this message follow up on
http://listserv.shafik.org/pipermail/ltt-dev/2007-February/002212.html)

compudj@amd64:~/obj/sparc$ PATH=3D/opt/crosstool/gcc-4.1.1-glibc-2.3.6/spar=
c-unknown-linux-gnu/bin sparc-unknown-linux-gnu-objdump -dr .tmp_kallsyms3.o

.tmp_kallsyms3.o:     file format elf32-sparc

(that's all)

By looking at what follows in more depth, it looks like the symbols I
keep are relative to the beginning of the _text section and sparc would
have a limit regarding this (maximum offset ? number of offsets relative
to a symbol ?)

Any insights are welcome,

Mathieu


link error :

opt/crosstool/gcc-4.1.1-glibc-2.3.6/sparc-unknown-linux-gnu/bin/sparc-unkno=
wn-linux-gnu-ld -m elf32_sparc  -T arch/sparc/kernel/vmlinux.lds arch/sparc=
/kernel/head.o arch/sparc/kernel/init_task.o  init/built-in.o --start-group=
  usr/built-in.o  arch/sparc/kernel/built-in.o arch/sparc/mm/built-in.o  ar=
ch/sparc/math-emu/built-in.o kernel/built-in.o  mm/built-in.o  fs/built-in.=
o  ipc/built-in.o security/built-in.o  crypto/built-in.o  block/built-in.o =
 lib/lib.a arch/sparc/prom/lib.a  arch/sparc/lib/lib.a  lib/built-in.o arch=
/sparc/prom/built-in.o  arch/sparc/lib/built-in.o drivers/built-in.o  sound=
/built-in.o  net/built-in.o --end-group .tmp_kallsyms3.o arch/sparc/boot/bt=
fix.o -o arch/sparc/boot/image
.tmp_kallsyms3.o: In function `kallsyms_addresses':
.tmp_kallsyms3.S:(.rodata+0x0): relocation truncated to fit: R_SPARC_32 aga=
inst symbol `_text' defined in .text section in arch/sparc/boot/image
.tmp_kallsyms3.S:(.rodata+0x8): relocation truncated to fit: R_SPARC_32 aga=
inst symbol `_text' defined in .text section in arch/sparc/boot/image
...
.tmp_kallsyms3.S:(.rodata+0x2c): additional relocation overflows omitted
from the output
make[2]: *** [arch/sparc/boot/image] Error 1


arch/sparc/kernel/vmlinux.lds
...
OUTPUT_FORMAT("elf32-sparc", "elf32-sparc", "elf32-sparc")
OUTPUT_ARCH(sparc)
ENTRY(_start)
jiffies =3D jiffies_64 + 4;
SECTIONS
{
  . =3D 0x10000 + SIZEOF_HEADERS;
  .text 0xf0004000 :
  {
    _text =3D .;
    *(.text)
    . =3D ALIGN(8); __sched_text_start =3D .; *(.sched.text) __sched_text_e=
nd =3D .;
    . =3D ALIGN(8); __lock_text_start =3D .; *(.spinlock.text) __lock_text_=
end =3D .;
    *(.gnu.warning)
  } =3D0
  _etext =3D .;
...


A look at .tmp_kallsyms3.S, symbol kallsyms_addresses which seems to cause
linking error on sparc :


#include <asm/types.h>
#if BITS_PER_LONG =3D 64
#define PTR .quad
#define ALGN .align 8
#else
#define PTR .long
#define ALGN .align 4
#endif
        .section .rodata, "a"
.globl kallsyms_addresses
        ALGN
kallsyms_addresses:
        PTR     _text - 0xeffd7000
        PTR     0x2d000
        PTR     _text - 0xeffd6fb8
        PTR     _text - 0xeffd6f50
        PTR     _text - 0xeffd6ed0
        PTR     _text - 0xeffd6eac
        PTR     _text - 0xeffd6b84
        PTR     _text - 0xeffd6860
        PTR     _text - 0xeffd6830
        PTR     _text - 0xeffd6814
        PTR     _text - 0xeffd6794
        PTR     _text - 0xeffd6788
        PTR     _text - 0xeffd6778
        PTR     _text - 0xeffd6764
        PTR     _text - 0xeffd673c
        PTR     _text - 0xeffd6714
        PTR     _text - 0xeffd66e4
        PTR     _text - 0xeffd66b4
        PTR     _text - 0xeffd66ac
        PTR     _text - 0xeffd6698
        PTR     _text - 0xeffd6674
        PTR     _text - 0xeffd6650
        PTR     _text - 0xeffd63dc
        PTR     _text - 0xeffd637c
        PTR     _text - 0xeffd6304
        PTR     _text - 0xeffd6060
        PTR     _text - 0xeffd6034
        PTR     _text - 0xeffd6008
        PTR     _text - 0xeffd5ff8
.....

        PTR     _text - 0xeffbc7a0
        PTR     _text - 0xeffbc730
        PTR     0x47930
        PTR     _text + 0
        PTR     _text + 0
        PTR     _text + 0
        PTR     _text + 0
        PTR     _text + 0
        PTR     _text + 0
        PTR     _text + 0
        PTR     _text + 0x10
        PTR     _text + 0x20
        PTR     _text + 0x30
        PTR     _text + 0x40
        PTR     _text + 0x50
        PTR     _text + 0x60
        PTR     _text + 0x70
        PTR     _text + 0x80
        PTR     _text + 0x90
        PTR     _text + 0xa0
        PTR     _text + 0xb0
        PTR     _text + 0xc0
        PTR     _text + 0x110
        PTR     _text + 0x120
        PTR     _text + 0x130
        PTR     _text + 0x140
        PTR     _text + 0x150
....


        PTR     _text + 0x1b67c4
        PTR     _text + 0x1b67d8
        PTR     0xf01ba890


And by the way, I also add my own section to=20
include/asm-generic/vmlinux.lds.h in RODATA :
adds at line 124, kernel 2.6.20 :
        /* Kernel markers : pointers */                                 \
        .markers : AT(ADDR(.markers) - LOAD_OFFSET) {                   \
                VMLINUX_SYMBOL(__start___markers) =3D .;                  \
                *(.markers)                                             \
                VMLINUX_SYMBOL(__stop___markers) =3D .;                   \
        }                                                               \



--=20
Mathieu Desnoyers
Computer Engineering Graduate Student, =C9cole Polytechnique de Montr=E9al
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
