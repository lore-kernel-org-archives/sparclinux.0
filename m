From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Date: Wed, 07 Feb 2007 17:19:12 +0000
Subject: Re: [Ltt-dev] Linux Kernel Markers : sparc build issue
Message-Id: <20070207171912.GA5992@Krystal>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

It seems like I bust the 8k limit for the sparc GOT :

The kallsyms_addresses is 8614 lines long (for a 33.6kB total) in the .S,
and, according to
http://gcc.gnu.org/onlinedocs/gcc-4.1.1/gcc/Code-Gen-Options.html :

"If the GOT size for the linked executable exceeds a machine-specific
maximum size, you get an error message from the linker indicating that
-fpic does not work; in that case, recompile with -fPIC instead. (These
maximums are 8k on the SPARC and 32k on the m68k and RS/6000. The 386
has no such limit.)"

Mathieu


* Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca) wrote:
> * Frank Ch. Eigler (fche@redhat.com) wrote:
> >=20
> > Perhaps you could post excerpts of "objdump -dr <file.o>", to see the
> > disassembly / relocations in question.
> >=20
> > - FChE
>=20
> Hi Frank,
>=20
> (this message follow up on
> http://listserv.shafik.org/pipermail/ltt-dev/2007-February/002212.html)
>=20
> compudj@amd64:~/obj/sparc$ PATH=3D/opt/crosstool/gcc-4.1.1-glibc-2.3.6/sp=
arc-unknown-linux-gnu/bin sparc-unknown-linux-gnu-objdump -dr .tmp_kallsyms=
3.o
>=20
> .tmp_kallsyms3.o:     file format elf32-sparc
>=20
> (that's all)
>=20
> By looking at what follows in more depth, it looks like the symbols I
> keep are relative to the beginning of the _text section and sparc would
> have a limit regarding this (maximum offset ? number of offsets relative
> to a symbol ?)
>=20
> Any insights are welcome,
>=20
> Mathieu
>=20
>=20
> link error :
>=20
> opt/crosstool/gcc-4.1.1-glibc-2.3.6/sparc-unknown-linux-gnu/bin/sparc-unk=
nown-linux-gnu-ld -m elf32_sparc  -T arch/sparc/kernel/vmlinux.lds arch/spa=
rc/kernel/head.o arch/sparc/kernel/init_task.o  init/built-in.o --start-gro=
up  usr/built-in.o  arch/sparc/kernel/built-in.o arch/sparc/mm/built-in.o  =
arch/sparc/math-emu/built-in.o kernel/built-in.o  mm/built-in.o  fs/built-i=
n.o  ipc/built-in.o security/built-in.o  crypto/built-in.o  block/built-in.=
o  lib/lib.a arch/sparc/prom/lib.a  arch/sparc/lib/lib.a  lib/built-in.o ar=
ch/sparc/prom/built-in.o  arch/sparc/lib/built-in.o drivers/built-in.o  sou=
nd/built-in.o  net/built-in.o --end-group .tmp_kallsyms3.o arch/sparc/boot/=
btfix.o -o arch/sparc/boot/image
> .tmp_kallsyms3.o: In function `kallsyms_addresses':
> .tmp_kallsyms3.S:(.rodata+0x0): relocation truncated to fit: R_SPARC_32 a=
gainst symbol `_text' defined in .text section in arch/sparc/boot/image
> .tmp_kallsyms3.S:(.rodata+0x8): relocation truncated to fit: R_SPARC_32 a=
gainst symbol `_text' defined in .text section in arch/sparc/boot/image
> ...
> .tmp_kallsyms3.S:(.rodata+0x2c): additional relocation overflows omitted
> from the output
> make[2]: *** [arch/sparc/boot/image] Error 1
>=20
>=20
> arch/sparc/kernel/vmlinux.lds
> ...
> OUTPUT_FORMAT("elf32-sparc", "elf32-sparc", "elf32-sparc")
> OUTPUT_ARCH(sparc)
> ENTRY(_start)
> jiffies =3D jiffies_64 + 4;
> SECTIONS
> {
>   . =3D 0x10000 + SIZEOF_HEADERS;
>   .text 0xf0004000 :
>   {
>     _text =3D .;
>     *(.text)
>     . =3D ALIGN(8); __sched_text_start =3D .; *(.sched.text) __sched_text=
_end =3D .;
>     . =3D ALIGN(8); __lock_text_start =3D .; *(.spinlock.text) __lock_tex=
t_end =3D .;
>     *(.gnu.warning)
>   } =3D0
>   _etext =3D .;
> ...
>=20
>=20
> A look at .tmp_kallsyms3.S, symbol kallsyms_addresses which seems to cause
> linking error on sparc :
>=20
>=20
> #include <asm/types.h>
> #if BITS_PER_LONG =3D 64
> #define PTR .quad
> #define ALGN .align 8
> #else
> #define PTR .long
> #define ALGN .align 4
> #endif
>         .section .rodata, "a"
> .globl kallsyms_addresses
>         ALGN
> kallsyms_addresses:
>         PTR     _text - 0xeffd7000
>         PTR     0x2d000
>         PTR     _text - 0xeffd6fb8
>         PTR     _text - 0xeffd6f50
>         PTR     _text - 0xeffd6ed0
>         PTR     _text - 0xeffd6eac
>         PTR     _text - 0xeffd6b84
>         PTR     _text - 0xeffd6860
>         PTR     _text - 0xeffd6830
>         PTR     _text - 0xeffd6814
>         PTR     _text - 0xeffd6794
>         PTR     _text - 0xeffd6788
>         PTR     _text - 0xeffd6778
>         PTR     _text - 0xeffd6764
>         PTR     _text - 0xeffd673c
>         PTR     _text - 0xeffd6714
>         PTR     _text - 0xeffd66e4
>         PTR     _text - 0xeffd66b4
>         PTR     _text - 0xeffd66ac
>         PTR     _text - 0xeffd6698
>         PTR     _text - 0xeffd6674
>         PTR     _text - 0xeffd6650
>         PTR     _text - 0xeffd63dc
>         PTR     _text - 0xeffd637c
>         PTR     _text - 0xeffd6304
>         PTR     _text - 0xeffd6060
>         PTR     _text - 0xeffd6034
>         PTR     _text - 0xeffd6008
>         PTR     _text - 0xeffd5ff8
> .....
>=20
>         PTR     _text - 0xeffbc7a0
>         PTR     _text - 0xeffbc730
>         PTR     0x47930
>         PTR     _text + 0
>         PTR     _text + 0
>         PTR     _text + 0
>         PTR     _text + 0
>         PTR     _text + 0
>         PTR     _text + 0
>         PTR     _text + 0
>         PTR     _text + 0x10
>         PTR     _text + 0x20
>         PTR     _text + 0x30
>         PTR     _text + 0x40
>         PTR     _text + 0x50
>         PTR     _text + 0x60
>         PTR     _text + 0x70
>         PTR     _text + 0x80
>         PTR     _text + 0x90
>         PTR     _text + 0xa0
>         PTR     _text + 0xb0
>         PTR     _text + 0xc0
>         PTR     _text + 0x110
>         PTR     _text + 0x120
>         PTR     _text + 0x130
>         PTR     _text + 0x140
>         PTR     _text + 0x150
> ....
>=20
>=20
>         PTR     _text + 0x1b67c4
>         PTR     _text + 0x1b67d8
>         PTR     0xf01ba890
>=20
>=20
> And by the way, I also add my own section to=20
> include/asm-generic/vmlinux.lds.h in RODATA :
> adds at line 124, kernel 2.6.20 :
>         /* Kernel markers : pointers */                                 \
>         .markers : AT(ADDR(.markers) - LOAD_OFFSET) {                   \
>                 VMLINUX_SYMBOL(__start___markers) =3D .;                 =
 \
>                 *(.markers)                                             \
>                 VMLINUX_SYMBOL(__stop___markers) =3D .;                  =
 \
>         }                                                               \
>=20
>=20
>=20
> --=20
> Mathieu Desnoyers
> Computer Engineering Graduate Student, =C9cole Polytechnique de Montr=E9al
> OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A=
68
> _______________________________________________
> Ltt-dev mailing list
> Ltt-dev@listserv.shafik.org
> http://listserv.shafik.org/mailman/listinfo/ltt-dev
>=20

--=20
Mathieu Desnoyers
Computer Engineering Graduate Student, =C9cole Polytechnique de Montr=E9al
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
