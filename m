From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Date: Wed, 07 Feb 2007 20:32:26 +0000
Subject: Re: [Ltt-dev] Linux Kernel Markers : sparc build issue
Message-Id: <20070207203225.GA19489@Krystal>
List-Id: <sparclinux.vger.kernel.org>
References: <20070207171912.GA5992@Krystal>
In-Reply-To: <20070207171912.GA5992@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Bug found and solved :

I forgot to declare the section .markers.c in
include/asm-generic/vmlinux.lds.h, which caused it to be unaligned. Only
sparc's ld seemed to choke on such unaligned relocation information.

Thanks for your support :)

Mathieu

The fix :

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinu=
x.lds.h
index d299de2..7fa3d19 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -127,6 +127,11 @@
 		*(.markers)						\
 		VMLINUX_SYMBOL(__stop___markers) =3D .;			\
 	}								\
+	.markers.c : AT(ADDR(.markers.c) - LOAD_OFFSET) {		\
+		VMLINUX_SYMBOL(__start___markers_c) =3D .;		\
+		*(.markers.c)						\
+		VMLINUX_SYMBOL(__stop___markers_c) =3D .;			\
+	}								\
 	__end_rodata =3D .;						\
 	. =3D ALIGN(4096);						\
 									\

* Mathieu Desnoyers (compudj@krystal.dyndns.org) wrote:
> It may be related :=20
>=20
> PATH=3D/opt/crosstool/gcc-4.1.1-glibc-2.3.6/sparc-unknown-linux-gnu/bin \
>    sparc-unknown-linux-gnu-objdump -r vmlinux
>=20
> RELOCATION RECORDS FOR [.markers.c]:
> OFFSET   TYPE              VALUE=20
> 00000000 R_SPARC_UA32      .rodata+0x00029d98
> 00000004 R_SPARC_UA32      .data+0x00002558
> 00000008 R_SPARC_UA32      .rodata+0x00029d08
> 00000010 R_SPARC_UA32      .rodata+0x00029db0
> 00000014 R_SPARC_UA32      .data+0x0000255c
> 00000018 R_SPARC_UA32      .rodata+0x00029d70
> 00000020 R_SPARC_UA32      .rodata+0x00029dc8
> 00000024 R_SPARC_UA32      .data+0x00002560
> 00000028 R_SPARC_UA32      .rodata+0x00029d08
> 00000030 R_SPARC_UA32      .rodata+0x00029f00
> ....
>=20
> the .markers.c seems to have unaligned relocation records, which is a
> little odd. I don't see other elsewhere in vmlinux.
>=20
> Mathieu
>=20
>=20
> * Mathieu Desnoyers (compudj@krystal.dyndns.org) wrote:
> > * Frank Ch. Eigler (fche@redhat.com) wrote:
> > > Hi -
> > >=20
> > > > It seems like I bust the 8k limit for the sparc GOT :
> > > > The kallsyms_addresses is 8614 lines long (for a 33.6kB total) in t=
he .S,
> > > > and, according to
> > > > http://gcc.gnu.org/onlinedocs/gcc-4.1.1/gcc/Code-Gen-Options.html :
> > > > [...]
> > >=20
> > > That could be it, but I don't see how that table of symbol addresses
> > >     .long _text - 0xbeef
> > > is using any GOT slots at all.  (Plus I don't know how a R_SPARC_32
> > > could ever be truncated - maybe there is a 64- vs 32-bit toolchain
> > > confusion happening somewhere?)
> > >=20
> >=20
> > The toolchain is built using crosstool 0.43 (plus modifications to get =
gcc
> > 4.1.1). The target is sparc-unknown-linux-gnu (not sparc64-unknown-linu=
x-gnu),
> > which seems correct.
> >=20
> > I just found this post which is enlightening :
> > http://gcc.gnu.org/ml/gcc-bugs/2001-06/msg00115.html
> > "> > ld.so.1: ./a.out: fatal: relocation error: R_SPARC_32: file
> > /local/nathan/devel/lib/libstdc++.so.3:  symbol __gxx_personality_v0:
> > offset 0x7fb1b0ca is non-aligned
> > >=20
> > > Until recently GNU binutils didn't handle R_SPARC_UA32 correctly.  Try
> > > the
> > > native Solaris as/ld or a new snapshot.
> > I can confirm that the 010604 binutils snapshot is ok."
> >=20
> >=20
> > > I could be misunderstanding things, but maybe what's wrong is that the
> > > new markers section is located in a sensitive spot, and its size is
> > > causing something else to no longer be reachable by shorter offsets.
> >=20
> > But if offsets are encoded on 32 bits, I don't see how it can become
> > unreachable. Unless it's a binutils bug..
> >=20
> > I will try a different binutils version and keep you informed.
> >=20
> > Mathieu
> >=20
> > > What are the neighbouring regions in the linker script?
> > >=20
> >=20
> > Here is the detail of arch/sparc/kernel/vmlinux.lds :
> >=20
> > /* ld script to make SparcLinux kernel */
> > /* Align . to a 8 byte boundary equals to maximum function alignment. */
> > /* sched.text is aling to function alignment to secure we have same
> >  * address even at second ld pass when generating System.map */
> > /* spinlock.text is aling to function alignment to secure we have same
> >  * address even at second ld pass when generating System.map */
> >   /* DWARF debug sections.
> > 		Symbols in the DWARF debugging sections are relative to
> > 		the beginning of the section so we begin them at 0.  */
> >   /* Stabs debugging sections.  */
> > OUTPUT_FORMAT("elf32-sparc", "elf32-sparc", "elf32-sparc")
> > OUTPUT_ARCH(sparc)
> > ENTRY(_start)
> > jiffies =3D jiffies_64 + 4;
> > SECTIONS
> > {
> >   . =3D 0x10000 + SIZEOF_HEADERS;
> >   .text 0xf0004000 :
> >   {
> >     _text =3D .;
> >     *(.text)
> >     . =3D ALIGN(8); __sched_text_start =3D .; *(.sched.text) __sched_te=
xt_end =3D .;
> >     . =3D ALIGN(8); __lock_text_start =3D .; *(.spinlock.text) __lock_t=
ext_end =3D .;
> >     *(.gnu.warning)
> >   } =3D0
> >   _etext =3D .;
> >   PROVIDE (etext =3D .);
> >   . =3D ALIGN(4096); .rodata : AT(ADDR(.rodata) - 0) { __start_rodata =
=3D .; *(.rodata) *(.rodata.*) *(__vermagic) } .rodata1 : AT(ADDR(.rodata1)=
 - 0) { *(.rodata1) } .pci_fixup : AT(ADDR(.pci_fixup) - 0) { __start_pci_f=
ixups_early =3D .; *(.pci_fixup_early) __end_pci_fixups_early =3D .; __star=
t_pci_fixups_header =3D .; *(.pci_fixup_header) __end_pci_fixups_header =3D=
 .; __start_pci_fixups_final =3D .; *(.pci_fixup_final) __end_pci_fixups_fi=
nal =3D .; __start_pci_fixups_enable =3D .; *(.pci_fixup_enable) __end_pci_=
fixups_enable =3D .; __start_pci_fixups_resume =3D .; *(.pci_fixup_resume) =
__end_pci_fixups_resume =3D .; } .rio_route : AT(ADDR(.rio_route) - 0) { __=
start_rio_route_ops =3D .; *(.rio_route_ops) __end_rio_route_ops =3D .; } _=
_ksymtab : AT(ADDR(__ksymtab) - 0) { __start___ksymtab =3D .; *(__ksymtab) =
__stop___ksymtab =3D .; } __ksymtab_gpl : AT(ADDR(__ksymtab_gpl) - 0) { __s=
tart___ksymtab_gpl =3D .; *(__ksymtab_gpl) __stop___ksymtab_gpl =3D .; } __=
ksymtab_unused : AT(ADDR(__ksymtab_unused) - 0) { __start___ksymtab_unused =
=3D .; *(__ksymtab_unused) __stop___ksymtab_unused =3D .; } __ksymtab_unuse=
d_gpl : AT(ADDR(__ksymtab_unused_gpl) - 0) { __start___ksymtab_unused_gpl =
=3D .; *(__ksymtab_unused_gpl) __stop___ksymtab_unused_gpl =3D .; } __ksymt=
ab_gpl_future : AT(ADDR(__ksymtab_gpl_future) - 0) { __start___ksymtab_gpl_=
future =3D .; *(__ksymtab_gpl_future) __stop___ksymtab_gpl_future =3D .; } =
__kcrctab : AT(ADDR(__kcrctab) - 0) { __start___kcrctab =3D .; *(__kcrctab)=
 __stop___kcrctab =3D .; } __kcrctab_gpl : AT(ADDR(__kcrctab_gpl) - 0) { __=
start___kcrctab_gpl =3D .; *(__kcrctab_gpl) __stop___kcrctab_gpl =3D .; } _=
_kcrctab_unused : AT(ADDR(__kcrctab_unused) - 0) { __start___kcrctab_unused=
 =3D .; *(__kcrctab_unused) __stop___kcrctab_unused =3D .; } __kcrctab_unus=
ed_gpl : AT(ADDR(__kcrctab_unused_gpl) - 0) { __start___kcrctab_unused_gpl =
=3D .; *(__kcrctab_unused_gpl) __stop___kcrctab_unused_gpl =3D .; } __kcrct=
ab_gpl_future : AT(ADDR(__kcrctab_gpl_future) - 0) { __start___kcrctab_gpl_=
future =3D .; *(__kcrctab_gpl_future) __stop___kcrctab_gpl_future =3D .; } =
__ksymtab_strings
 : AT(ADDR(__ksymtab_strings) - 0) { *(__ksymtab_strings) } .markers : AT(A=
DDR(.markers) - 0) { __start___markers =3D .; *(.markers) __stop___markers =
=3D .; } __end_rodata =3D .; . =3D ALIGN(4096); __param : AT(ADDR(__param) =
- 0) { __start___param =3D .; *(__param) __stop___param =3D .; __end_rodata=
 =3D .; } . =3D ALIGN(4096);
> >   .data :
> >   {
> >     *(.data)
> >     CONSTRUCTORS
> >   }
> >   .data1 : { *(.data1) }
> >   _edata =3D .;
> >   PROVIDE (edata =3D .);
> >   __start___fixup =3D .;
> >   .fixup : { *(.fixup) }
> >   __stop___fixup =3D .;
> >   __start___ex_table =3D .;
> >   __ex_table : { *(__ex_table) }
> >   __stop___ex_table =3D .;
> >   . =3D ALIGN(4096);
> >   __init_begin =3D .;
> >   _sinittext =3D .;
> >   .init.text : {
> >  *(.init.text)
> >   }
> >   _einittext =3D .;
> >   __init_text_end =3D .;
> >   .init.data : { *(.init.data) }
> >   . =3D ALIGN(16);
> >   __setup_start =3D .;
> >   .init.setup : { *(.init.setup) }
> >   __setup_end =3D .;
> >   __initcall_start =3D .;
> >   .initcall.init : {
> >  *(.initcall0.init) *(.initcall0s.init) *(.initcall1.init) *(.initcall1=
s.init) *(.initcall2.init) *(.initcall2s.init) *(.initcall3.init) *(.initca=
ll3s.init) *(.initcall4.init) *(.initcall4s.init) *(.initcall5.init) *(.ini=
tcall5s.init) *(.initcallrootfs.init) *(.initcall6.init) *(.initcall6s.init=
) *(.initcall7.init) *(.initcall7s.init)
> >   }
> >   __initcall_end =3D .;
> >   __con_initcall_start =3D .;
> >   .con_initcall.init : { *(.con_initcall.init) }
> >   __con_initcall_end =3D .;
> >   .security_initcall.init : AT(ADDR(.security_initcall.init) - 0) { __s=
ecurity_initcall_start =3D .; *(.security_initcall.init) __security_initcal=
l_end =3D .; }
> >   . =3D ALIGN(4096);
> >   __initramfs_start =3D .;
> >   .init.ramfs : { *(.init.ramfs) }
> >   __initramfs_end =3D .;
> >   . =3D ALIGN(32);
> >   __per_cpu_start =3D .;
> >   .data.percpu : { *(.data.percpu) }
> >   __per_cpu_end =3D .;
> >   . =3D ALIGN(4096);
> >   __init_end =3D .;
> >   . =3D ALIGN(32);
> >   .data.cacheline_aligned : { *(.data.cacheline_aligned) }
> >   __bss_start =3D .;
> >   .sbss : { *(.sbss) *(.scommon) }
> >   .bss :
> >   {
> >    *(.dynbss)
> >    *(.bss)
> >    *(COMMON)
> >   }
> >   _end =3D . ;
> >   PROVIDE (end =3D .);
> >   /DISCARD/ : { *(.exit.text) *(.exit.data) *(.exitcall.exit) }
> >   .stab 0 : { *(.stab) } .stabstr 0 : { *(.stabstr) } .stab.excl 0 : { =
*(.stab.excl) } .stab.exclstr 0 : { *(.stab.exclstr) } .stab.index 0 : { *(=
.stab.index) } .stab.indexstr 0 : { *(.stab.indexstr) } .comment 0 : { *(.c=
omment) }
> >   .debug 0 : { *(.debug) } .line 0 : { *(.line) } .debug_srcinfo 0 : { =
*(.debug_srcinfo) } .debug_sfnames 0 : { *(.debug_sfnames) } .debug_aranges=
 0 : { *(.debug_aranges) } .debug_pubnames 0 : { *(.debug_pubnames) } .debu=
g_info 0 : { *(.debug_info .gnu.linkonce.wi.*) } .debug_abbrev 0 : { *(.deb=
ug_abbrev) } .debug_line 0 : { *(.debug_line) } .debug_frame 0 : { *(.debug=
_frame) } .debug_str 0 : { *(.debug_str) } .debug_loc 0 : { *(.debug_loc) }=
 .debug_macinfo 0 : { *(.debug_macinfo) } .debug_weaknames 0 : { *(.debug_w=
eaknames) } .debug_funcnames 0 : { *(.debug_funcnames) } .debug_typenames 0=
 : { *(.debug_typenames) } .debug_varnames 0 : { *(.debug_varnames) }
> > }
> >=20
> >=20
> > --=20
> > Mathieu Desnoyers
> > Computer Engineering Graduate Student, =C9cole Polytechnique de Montr=
=E9al
> > OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE =
9A68
> > _______________________________________________
> > Ltt-dev mailing list
> > Ltt-dev@listserv.shafik.org
> > http://listserv.shafik.org/mailman/listinfo/ltt-dev
> >=20
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
