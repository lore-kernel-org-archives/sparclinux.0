From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
Date: Tue, 06 Apr 2004 04:44:53 +0000
Subject: OOPS on U 60 .. / kernel 2.4.24 - SMP
Message-Id: <CFE6A2529AC5FA439B3D852B0F2A68371A2A9C@OEKAW2EXVS02.hbi.ad.harman.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----_=_NextPart_000_01C41B91.E7134FD0"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C41B91.E7134FD0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Dear listmembers,
through the help of a friendly soul I can supply the right output from
ksymoops for the Ultra 60 I was asking for yesterday. Propably someone has
an idea where this could stem from.
By the way, my network card (I switched from the happy meal to via rhine
hoping the network card was the cause) moans about "Too much work at
interrupt, status=3D0x00000001.". Propably this is related. If I missed
something, please take a look into my email from yesterday morning.
Thank you for any input so far!
Take care



Dieter Jurzitza


--=20
________________________________________________

HARMAN BECKER AUTOMOTIVE SYSTEMS

Dr.-Ing. Dieter Jurzitza
Manager Hardware Systems
         ESI

Industriegebiet Ittersbach
Becker-G=F6ring Str. 16
D-76307 Karlsbad / Germany

Phone: +49 (0)7248 71-1577
Fax:   +49 (0)7248 71-1216
eMail: DJurzitza@harmanbecker.com
Internet: http://www.becker.de
=20



*******************************************
Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte Informati=
onen. Wenn Sie nicht der richtige Adressat sind oder diese E-Mail irrtuemli=
ch erhalten haben, informieren Sie bitte sofort den Absender und loeschen S=
ie diese Mail. Das unerlaubte Kopieren sowie die unbefugte Weitergabe diese=
r Mail ist nicht gestattet.
=20
This e-mail may contain confidential and/or privileged information. If you =
are not the intended recipient (or have received this e-mail in error) plea=
se notify the sender immediately and delete this e-mail. Any unauthorised c=
opying, disclosure or distribution of the contents in this e-mail is strict=
ly forbidden.
*******************************************


------_=_NextPart_000_01C41B91.E7134FD0
Content-Type: application/octet-stream; name="ksymoops-U60.out"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="ksymoops-U60.out"

ksymoops 2.4.2 on sparc64 2.4.24-SMP.  Options used=0A     -v /home/fred/wo=
rk/kernel/linux/vmlinux (specified)=0A     -k /proc/ksyms (default)=0A     =
-l /proc/modules (default)=0A     -o /lib/modules/2.4.24-SMP/ (default)=0A =
    -m /boot/System.map-2.4.24-SMP (specified)=0A     -t elf64-sparc -a spa=
rc:v9=0A=0AWarning (compare_maps): ksyms_base symbol GPLONLY___ide_do_rw_di=
sk not found in vmlinux.  Ignoring ksyms_base entry=0AWarning (compare_maps=
): ksyms_base symbol GPLONLY_ide_add_generic_settings not found in vmlinux.=
  Ignoring ksyms_base entry=0AWarning (compare_maps): ksyms_base symbol GPL=
ONLY_ide_build_dmatable not found in vmlinux.  Ignoring ksyms_base entry=0A=
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_destroy_dmatable not =
found in vmlinux.  Ignoring ksyms_base entry=0AWarning (compare_maps): ksym=
s_base symbol GPLONLY_ide_dma_intr not found in vmlinux.  Ignoring ksyms_ba=
se entry=0AWarning (compare_maps): ksyms_base symbol GPLONLY_ide_get_best_p=
io_mode not found in vmlinux.  Ignoring ksyms_base entry=0AWarning (compare=
_maps): ksyms_base symbol GPLONLY_ide_pci_register_driver not found in vmli=
nux.  Ignoring ksyms_base entry=0AWarning (compare_maps): ksyms_base symbol=
 GPLONLY_ide_pci_unregister_driver not found in vmlinux.  Ignoring ksyms_ba=
se entry=0AWarning (compare_maps): ksyms_base symbol GPLONLY_ide_pio_timing=
s not found in vmlinux.  Ignoring ksyms_base entry=0AWarning (compare_maps)=
: ksyms_base symbol GPLONLY_ide_set_xfer_rate not found in vmlinux.  Ignori=
ng ksyms_base entry=0AWarning (compare_maps): ksyms_base symbol GPLONLY_ide=
_setup_dma not found in vmlinux.  Ignoring ksyms_base entry=0AWarning (comp=
are_maps): ksyms_base symbol GPLONLY_ide_setup_pci_device not found in vmli=
nux.  Ignoring ksyms_base entry=0AWarning (compare_maps): ksyms_base symbol=
 GPLONLY_ide_setup_pci_devices not found in vmlinux.  Ignoring ksyms_base e=
ntry=0AWarning (compare_maps): ip_conntrack symbol GPLONLY_ip_conntrack_exp=
ect_find_get not found in /lib/modules.dirs/2.4.24-SMP-test/kernel/net/ipv4=
/netfilter/ip_conntrack.o.  Ignoring /lib/modules.dirs/2.4.24-SMP-test/kern=
el/net/ipv4/netfilter/ip_conntrack.o entry=0AWarning (compare_maps): ip_con=
ntrack symbol GPLONLY_ip_conntrack_expect_put not found in /lib/modules.dir=
s/2.4.24-SMP-test/kernel/net/ipv4/netfilter/ip_conntrack.o.  Ignoring /lib/=
modules.dirs/2.4.24-SMP-test/kernel/net/ipv4/netfilter/ip_conntrack.o entry=
=0AWarning (compare_maps): ip_conntrack symbol GPLONLY_ip_conntrack_find_ge=
t not found in /lib/modules.dirs/2.4.24-SMP-test/kernel/net/ipv4/netfilter/=
ip_conntrack.o.  Ignoring /lib/modules.dirs/2.4.24-SMP-test/kernel/net/ipv4=
/netfilter/ip_conntrack.o entry=0AWarning (compare_maps): ip_conntrack symb=
ol GPLONLY_ip_conntrack_put not found in /lib/modules.dirs/2.4.24-SMP-test/=
kernel/net/ipv4/netfilter/ip_conntrack.o.  Ignoring /lib/modules.dirs/2.4.2=
4-SMP-test/kernel/net/ipv4/netfilter/ip_conntrack.o entry=0AApr  5 06:29:58=
 oekalux08 kernel:               \|/ ____ \|/=0AApr  5 06:29:58 oekalux08 k=
ernel:               "@'/ .. \`@"=0AApr  5 06:29:58 oekalux08 kernel:      =
         /_| \__/ |_\=0AApr  5 06:29:58 oekalux08 kernel:                  =
\__U_/=0AApr  5 06:29:58 oekalux08 kernel: CPU[1]: local_irq_count[0] irqs_=
running[0]=0AApr  5 06:29:58 oekalux08 kernel: TSTATE: 0000009111009601 TPC=
: 000000000046fca4 TNPC: 000000000046fca8 Y: 563bbc28    Tainted: P =0AApr =
 5 06:29:58 oekalux08 kernel: g0: fffff800471a6f11 g1: fffff800607cf880 g2:=
 0000000000000000 g3: fffff800471a7d80=0AApr  5 06:29:58 oekalux08 kernel: =
g4: fffff80000000000 g5: 0000000000000011 g6: fffff800471a4000 g7: 00000000=
00000738=0AApr  5 06:29:58 oekalux08 kernel: o0: fffff8006dc4f320 o1: 00000=
000705e600d o2: 000000000000003b o3: fffff8006dc4f358=0AApr  5 06:29:58 oek=
alux08 kernel: o4: 000000000059bc80 o5: 0000000000000000 sp: fffff800471a6f=
41 ret_pc: 0000000000476f90=0AApr  5 06:29:58 oekalux08 kernel: l0: fffff80=
06dc4f320 l1: 0000000000000002 l2: 0000000000000000 l3: 0000000000000000=0A=
Apr  5 06:29:58 oekalux08 kernel: l4: 0000000000000000 l5: 0000000000000006=
 l6: 0000000000000000 l7: 0000000000000008=0AApr  5 06:29:58 oekalux08 kern=
el: i0: 7a45ee63730e3e80 i1: 0000000000000000 i2: fffff800607cfe50 i3: 0000=
00000000000a=0AApr  5 06:29:58 oekalux08 kernel: i4: 0000000000000000 i5: 0=
000000000000000 i6: fffff800471a7001 i7: 000000000059f938=0AApr  5 06:29:58=
 oekalux08 kernel: Caller[000000000059f938]=0AApr  5 06:29:58 oekalux08 ker=
nel: Caller[000000000059f984]=0AApr  5 06:29:58 oekalux08 kernel: Caller[00=
0000000059fb14]=0AApr  5 06:29:58 oekalux08 kernel: Caller[00000000005ca4d4=
]=0AApr  5 06:29:58 oekalux08 kernel: Caller[00000000005ede6c]=0AApr  5 06:=
29:58 oekalux08 kernel: Caller[000000000059bbd0]=0AApr  5 06:29:58 oekalux0=
8 kernel: Caller[000000000059bcfc]=0AApr  5 06:29:58 oekalux08 kernel: Call=
er[0000000000476f90]=0AApr  5 06:29:58 oekalux08 kernel: Caller[00000000004=
10eb4]=0AApr  5 06:29:58 oekalux08 kernel: Caller[0000000000126af0]=0AApr  =
5 06:29:58 oekalux08 kernel: Instruction DUMP: 01000000  01000000  9de3bf40=
 <d05e2030> 913a300e  808a2001  12680009  90102001  4006e74a =0A=0A>>TPC; 0=
00000000046fca4 <__free_pages+4/40>   <=3D=3D=3D=3D=3D=0A>>O7;  00000000004=
76f90 <sys_read+b0/160>=0A>>I7;  000000000059f938 <skb_release_data+58/a0>=
=0ATrace; 000000000059f938 <skb_release_data+58/a0>=0ATrace; 000000000059f9=
84 <kfree_skbmem+4/a0>=0ATrace; 000000000059fb14 <__kfree_skb+f4/120>=0ATra=
ce; 00000000005ca4d4 <tcp_recvmsg+854/ba0>=0ATrace; 00000000005ede6c <inet_=
recvmsg+2c/60>=0ATrace; 000000000059bbd0 <sock_recvmsg+30/e0>=0ATrace; 0000=
00000059bcfc <sock_read+7c/a0>=0ATrace; 0000000000476f90 <sys_read+b0/160>=
=0ATrace; 0000000000410eb4 <linux_sparc_syscall32+34/40>=0ATrace; 000000000=
0126af0 Before first symbol=0ACode;  000000000046fc98 <get_zeroed_page+38/4=
0>=0A0000000000000000 <_TPC>:=0ACode;  000000000046fc98 <get_zeroed_page+38=
/40>=0A   0:   01 00 00 00       nop =0ACode;  000000000046fc9c <get_zeroed=
_page+3c/40>=0A   4:   01 00 00 00       nop =0ACode;  000000000046fca0 <__=
free_pages+0/40>=0A   8:   9d e3 bf 40       save  %sp, -192, %sp=0ACode;  =
000000000046fca4 <__free_pages+4/40>   <=3D=3D=3D=3D=3D=0A   c:   d0 5e 20 =
30       ldx  [ %i0 + 0x30 ], %o0   <=3D=3D=3D=3D=3D=0ACode;  000000000046f=
ca8 <__free_pages+8/40>=0A  10:   91 3a 30 0e       srax  %o0, 0xe, %o0=0AC=
ode;  000000000046fcac <__free_pages+c/40>=0A  14:   80 8a 20 01       btst=
  1, %o0=0ACode;  000000000046fcb0 <__free_pages+10/40>=0A  18:   12 68 00 =
09       bne  %xcc, 3c <_TPC+0x3c> 000000000046fcd4 <__free_pages+34/40>=0A=
Code;  000000000046fcb4 <__free_pages+14/40>=0A  1c:   90 10 20 01       mo=
v  1, %o0=0ACode;  000000000046fcb8 <__free_pages+18/40>=0A  20:   40 06 e7=
 4a       call  1b9d48 <_TPC+0x1b9d48> 00000000006299e0 <__atomic_sub+0/20>=
=0ACode;  000000000046fcbc <__free_pages+1c/40>=0A  24:   00 00 00 00      =
 illtrap  0=0A=0AApr  5 06:29:58 oekalux08 kernel: CPU[0]: local_irq_count[=
0] irqs_running[0]=0AApr  5 06:29:58 oekalux08 kernel: TSTATE: 000000990000=
0a00 TPC: 00000000700957e4 TNPC: 00000000700957e8 Y: 007a0bb0    Tainted: P=
 =0AApr  5 06:29:58 oekalux08 kernel: g0: 0000000000000000 g1: 000000000000=
0003 g2: 0000000000000000 g3: 0000000000000003=0AApr  5 06:29:58 oekalux08 =
kernel: g4: 000000000000006e g5: 0000000000000000 g6: 0000000000000000 g7: =
0000000001010101=0AApr  5 06:29:58 oekalux08 kernel: o0: 00000000efffebb8 o=
1: 0000000070167858 o2: 00000000701819d0 o3: 00000000efffebb8=0AApr  5 06:2=
9:58 oekalux08 kernel: o4: 0000000070183704 o5: 0000000000000000 sp: 000000=
00efffe428 ret_pc: 0000000070095eec=0AApr  5 06:29:58 oekalux08 kernel: l0:=
 00000003 l1: efffe428 l2: efffebb8 l3: 00000073 l4: 00000000 l5: 00000000 =
l6: 00000000 l7: 701878d4=0AApr  5 06:29:58 oekalux08 kernel: i0: 00000000 =
i1: 70167858 i2: efffed20 i3: 00000000 i4: 70183704 i5: fffff594 i6: efffeb=
58 i7: 700b171c=0A=0A>>TPC; 00000000700957e4 <END_OF_CODE+6df724ce/????>   =
<=3D=3D=3D=3D=3D=0A>>O7;  0000000070095eec <END_OF_CODE+6df72bd6/????>=0A>>=
I7;  00000000700b171c <END_OF_CODE+6df8e406/????>=0A=0A=0A17 warnings issue=
d.  Results may not be reliable.=0A
------_=_NextPart_000_01C41B91.E7134FD0--
