From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
Date: Tue, 15 Jun 2004 13:20:48 +0000
Subject: Question on kde
Message-Id: <CFE6A2529AC5FA439B3D852B0F2A68371A2BFB@OEKAW2EXVS02.hbi.ad.harman.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----_=_NextPart_000_01C452DB.92A1AD06"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C452DB.92A1AD06
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Dear Listmembers,
I updated my recently my cygwin-environment. Now, when attaching to my U60
running on 2.4.26-SMP from a win2000-client, I automatically start kde(2).

This works fine. However, shortly after startup I get a kernel OOPS (see
attached file oops.txt from /var/log/messages and the output of ksymoops.)

The system remains alive, but both keyboard and display on the U60 stop
working. The remote kde runs fine, I can work, compile, do whatever I want
to remotely - but the kdm-session local to the sparc is dead as is the local
sparc keyboard.

When attaching from a running X11 and starting "normal" applications after
setting the DISPLAY-variable appropriately there are no problems.

The ooops.txt shows a Dax for process X(838), I assume that means data
access exception, finally kdm dies. The output of ksymoops is hard to
understand for me.

Does anybody have a clue what could cause such a behaviour? Does this show
from the ksymoops? What else could I provide to clarify dependencies?

Many thanks for your support in advance,
take care



Dieter Jurzizta



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
se notify the sender immediately and delete this e-mail. Any unauthorized c=
opying, disclosure or distribution of the contents in this e-mail is strict=
ly forbidden.
*******************************************


------_=_NextPart_000_01C452DB.92A1AD06
Content-Type: text/plain; name="ooops.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="ooops.txt"

Jun 15 07:27:00 oekalux08 kernel: data_access_exception: SFSR[0000000000801=
00d] SFAR[fffff943484f2050], going.=0AJun 15 07:27:00 oekalux08 kernel:    =
           \|/ ____ \|/=0AJun 15 07:27:00 oekalux08 kernel:               "=
@'/ .. \`@"=0AJun 15 07:27:00 oekalux08 kernel:               /_| \__/ |_\=
=0AJun 15 07:27:00 oekalux08 kernel:                  \__U_/=0AJun 15 07:27=
:00 oekalux08 kernel: X(838): Dax=0AJun 15 07:27:00 oekalux08 kernel: CPU[0=
]: local_irq_count[0] irqs_running[0]=0AJun 15 07:27:00 oekalux08 kernel: T=
STATE: 0000000011f09606 TPC: 000000000044d80c TNPC: 000000000044d810 Y: 000=
00000    Tainted: P =0AJun 15 07:27:00 oekalux08 kernel: g0: 00000000000000=
0f g1: 00000000000000f9 g2: 0000000000000000 g3: 0000000080000000=0AJun 15 =
07:27:00 oekalux08 kernel: g4: fffff80000000000 g5: 0000000000000003 g6: ff=
fff8004c53c000 g7: 0000000000000003=0AJun 15 07:27:00 oekalux08 kernel: o0:=
 0000000000000000 o1: 000000000001f800 o2: 0000000000000000 o3: 00000000007=
2ad80=0AJun 15 07:27:00 oekalux08 kernel: o4: 000000000066b898 o5: 00000000=
00000000 sp: fffff8004c53f351 ret_pc: 00000000004ea420=0AJun 15 07:27:00 oe=
kalux08 kernel: l0: fffff80040e53000 l1: 0000000000414000 l2: 0000000000414=
ac8 l3: 0000000000000000=0AJun 15 07:27:00 oekalux08 kernel: l4: 0000000000=
758d40 l5: 0000000000759d40 l6: 0000000000000000 l7: 0000000070147434=0AJun=
 15 07:27:00 oekalux08 kernel: i0: 50535943484f2050 i1: fffff800487a8138 i2=
: 0000000000000000 i3: fffff80046fde2b8=0AJun 15 07:27:00 oekalux08 kernel:=
 i4: 00000000006906d8 i5: 00000000005fee20 i6: fffff8004c53f411 i7: 0000000=
00048badc=0AJun 15 07:27:00 oekalux08 kernel: Caller[000000000048badc]=0AJu=
n 15 07:27:00 oekalux08 kernel: Caller[000000000048bedc]=0AJun 15 07:27:00 =
oekalux08 kernel: Caller[0000000000433a6c]=0AJun 15 07:27:00 oekalux08 kern=
el: Caller[0000000000410eb4]=0AJun 15 07:27:00 oekalux08 kernel: Caller[000=
00000000a8590]=0AJun 15 07:27:00 oekalux08 kernel: Instruction DUMP: 9de3bf=
40  b5520000  9190200f <ce6e0000> 0ac1c5a7  8143e00a  b6066010  c65e6010  c=
45ee008 =0AJun 15 07:27:00 oekalux08 kernel: CPU[1]: local_irq_count[0] irq=
s_running[0]=0AJun 15 07:27:00 oekalux08 kernel: TSTATE: 0000009900000a05 T=
PC: 00000000700bd2a8 TNPC: 00000000700bd2ac Y: 007ab870    Tainted: P =0AJu=
n 15 07:27:00 oekalux08 kernel: g0: 0000000000000000 g1: 00000000002e5000 g=
2: 0000000000000000 g3: 0000000000000000=0AJun 15 07:27:00 oekalux08 kernel=
: g4: 000000000000006e g5: 0000000000000000 g6: 0000000000000000 g7: 000000=
0001010101=0AJun 15 07:27:00 oekalux08 kernel: o0: 00000000effffaf0 o1: 000=
0000000000800 o2: 0000000003ffffff o3: 00000000701677b0=0AJun 15 07:27:00 o=
ekalux08 kernel: o4: 000000000000000f o5: 0000000000000007 sp: 00000000efff=
ec38 ret_pc: 00000000700bc52c=0AJun 15 07:27:00 oekalux08 kernel: l0: 00000=
000 l1: 00000000 l2: 00000000 l3: 00000000 l4: 00000000 l5: 00000000 l6: 00=
000000 l7: 701878d4=0AJun 15 07:27:00 oekalux08 kernel: i0: efffed00 i1: ef=
fff2f0 i2: 00000800 i3: effff2f0 i4: 70183704 i5: fffff594 i6: efffeca0 i7:=
 700b170c=0AJun 15 07:27:00 oekalux08 kdm[830]: Server for display :0 termi=
nated unexpectedly=0AJun 15 07:27:01 oekalux08 kdm[830]: Server unexpectedl=
y died=0AJun 15 07:27:16 oekalux08 kdm[830]: Server for display :0 can't be=
 started, session disabled=0A
------_=_NextPart_000_01C452DB.92A1AD06
Content-Type: text/plain; name="ooopsout.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="ooopsout.txt"

ksymoops 2.4.2 on sparc64 2.4.26-SMP.  Options used=0A     -V (default)=0A =
    -k /proc/ksyms (default)=0A     -l /proc/modules (default)=0A     -o /l=
ib/modules/2.4.26-SMP/ (default)=0A     -m /boot/System.map-2.4.26-SMP (spe=
cified)=0A     -t elf64-sparc -a sparc:v9=0A=0AWarning (compare_maps): ksym=
s_base symbol GPLONLY___ide_do_rw_disk not found in System.map.  Ignoring k=
syms_base entry=0AWarning (compare_maps): ksyms_base symbol GPLONLY_ide_add=
_generic_settings not found in System.map.  Ignoring ksyms_base entry=0AWar=
ning (compare_maps): ksyms_base symbol GPLONLY_ide_build_dmatable not found=
 in System.map.  Ignoring ksyms_base entry=0AWarning (compare_maps): ksyms_=
base symbol GPLONLY_ide_destroy_dmatable not found in System.map.  Ignoring=
 ksyms_base entry=0AWarning (compare_maps): ksyms_base symbol GPLONLY_ide_d=
ma_intr not found in System.map.  Ignoring ksyms_base entry=0AWarning (comp=
are_maps): ksyms_base symbol GPLONLY_ide_get_best_pio_mode not found in Sys=
tem.map.  Ignoring ksyms_base entry=0AWarning (compare_maps): ksyms_base sy=
mbol GPLONLY_ide_pci_register_driver not found in System.map.  Ignoring ksy=
ms_base entry=0AWarning (compare_maps): ksyms_base symbol GPLONLY_ide_pci_u=
nregister_driver not found in System.map.  Ignoring ksyms_base entry=0AWarn=
ing (compare_maps): ksyms_base symbol GPLONLY_ide_pio_timings not found in =
System.map.  Ignoring ksyms_base entry=0AWarning (compare_maps): ksyms_base=
 symbol GPLONLY_ide_set_xfer_rate not found in System.map.  Ignoring ksyms_=
base entry=0AWarning (compare_maps): ksyms_base symbol GPLONLY_ide_setup_dm=
a not found in System.map.  Ignoring ksyms_base entry=0AWarning (compare_ma=
ps): ksyms_base symbol GPLONLY_ide_setup_pci_device not found in System.map=
.  Ignoring ksyms_base entry=0AWarning (compare_maps): ksyms_base symbol GP=
LONLY_ide_setup_pci_devices not found in System.map.  Ignoring ksyms_base e=
ntry=0AWarning (compare_maps): ip_conntrack symbol GPLONLY_ip_conntrack_exp=
ect_find_get not found in /lib/modules.dirs/2.4.26-SMP-test/kernel/net/ipv4=
/netfilter/ip_conntrack.o.  Ignoring /lib/modules.dirs/2.4.26-SMP-test/kern=
el/net/ipv4/netfilter/ip_conntrack.o entry=0AWarning (compare_maps): ip_con=
ntrack symbol GPLONLY_ip_conntrack_expect_put not found in /lib/modules.dir=
s/2.4.26-SMP-test/kernel/net/ipv4/netfilter/ip_conntrack.o.  Ignoring /lib/=
modules.dirs/2.4.26-SMP-test/kernel/net/ipv4/netfilter/ip_conntrack.o entry=
=0AWarning (compare_maps): ip_conntrack symbol GPLONLY_ip_conntrack_find_ge=
t not found in /lib/modules.dirs/2.4.26-SMP-test/kernel/net/ipv4/netfilter/=
ip_conntrack.o.  Ignoring /lib/modules.dirs/2.4.26-SMP-test/kernel/net/ipv4=
/netfilter/ip_conntrack.o entry=0AWarning (compare_maps): ip_conntrack symb=
ol GPLONLY_ip_conntrack_put not found in /lib/modules.dirs/2.4.26-SMP-test/=
kernel/net/ipv4/netfilter/ip_conntrack.o.  Ignoring /lib/modules.dirs/2.4.2=
6-SMP-test/kernel/net/ipv4/netfilter/ip_conntrack.o entry=0AJun 15 07:27:00=
 oekalux08 kernel:               \|/ ____ \|/=0AJun 15 07:27:00 oekalux08 k=
ernel:               "@'/ .. \`@"=0AJun 15 07:27:00 oekalux08 kernel:      =
         /_| \__/ |_\=0AJun 15 07:27:00 oekalux08 kernel:                  =
\__U_/=0AJun 15 07:27:00 oekalux08 kernel: CPU[0]: local_irq_count[0] irqs_=
running[0]=0AJun 15 07:27:00 oekalux08 kernel: TSTATE: 0000000011f09606 TPC=
: 000000000044d80c TNPC: 000000000044d810 Y: 00000000    Tainted: P =0AJun =
15 07:27:00 oekalux08 kernel: g0: 000000000000000f g1: 00000000000000f9 g2:=
 0000000000000000 g3: 0000000080000000=0AJun 15 07:27:00 oekalux08 kernel: =
g4: fffff80000000000 g5: 0000000000000003 g6: fffff8004c53c000 g7: 00000000=
00000003=0AJun 15 07:27:00 oekalux08 kernel: o0: 0000000000000000 o1: 00000=
0000001f800 o2: 0000000000000000 o3: 000000000072ad80=0AJun 15 07:27:00 oek=
alux08 kernel: o4: 000000000066b898 o5: 0000000000000000 sp: fffff8004c53f3=
51 ret_pc: 00000000004ea420=0AJun 15 07:27:00 oekalux08 kernel: l0: fffff80=
040e53000 l1: 0000000000414000 l2: 0000000000414ac8 l3: 0000000000000000=0A=
Jun 15 07:27:00 oekalux08 kernel: l4: 0000000000758d40 l5: 0000000000759d40=
 l6: 0000000000000000 l7: 0000000070147434=0AJun 15 07:27:00 oekalux08 kern=
el: i0: 50535943484f2050 i1: fffff800487a8138 i2: 0000000000000000 i3: ffff=
f80046fde2b8=0AJun 15 07:27:00 oekalux08 kernel: i4: 00000000006906d8 i5: 0=
0000000005fee20 i6: fffff8004c53f411 i7: 000000000048badc=0AJun 15 07:27:00=
 oekalux08 kernel: Caller[000000000048badc]=0AJun 15 07:27:00 oekalux08 ker=
nel: Caller[000000000048bedc]=0AJun 15 07:27:00 oekalux08 kernel: Caller[00=
00000000433a6c]=0AJun 15 07:27:00 oekalux08 kernel: Caller[0000000000410eb4=
]=0AJun 15 07:27:00 oekalux08 kernel: Caller[00000000000a8590]=0AJun 15 07:=
27:00 oekalux08 kernel: Instruction DUMP: 9de3bf40  b5520000  9190200f <ce6=
e0000> 0ac1c5a7  8143e00a  b6066010  c65e6010  c45ee008 =0A=0A>>TPC; 000000=
000044d80c <remove_wait_queue+c/60>   <=3D=3D=3D=3D=3D=0A>>O7;  00000000004=
ea420 <normal_poll+160/340>=0A>>I7;  000000000048badc <poll_freewait+1c/60>=
=0ATrace; 000000000048badc <poll_freewait+1c/60>=0ATrace; 000000000048bedc =
<do_select+1fc/220>=0ATrace; 0000000000433a6c <sys32_select+30c/4e0>=0ATrac=
e; 0000000000410eb4 <linux_sparc_syscall32+34/40>=0ATrace; 00000000000a8590=
 Before first symbol=0ACode;  000000000044d800 <remove_wait_queue+0/60>=0A0=
000000000000000 <_TPC>:=0ACode;  000000000044d800 <remove_wait_queue+0/60>=
=0A   0:   9d e3 bf 40       save  %sp, -192, %sp=0ACode;  000000000044d804=
 <remove_wait_queue+4/60>=0A   4:   b5 52 00 00       rdpr  %pil, %i2=0ACod=
e;  000000000044d808 <remove_wait_queue+8/60>=0A   8:   91 90 20 0f       w=
rpr  0xf, %pil=0ACode;  000000000044d80c <remove_wait_queue+c/60>   <=3D=3D=
=3D=3D=3D=0A   c:   ce 6e 00 00       ldstub  [ %i0 ], %g7   <=3D=3D=3D=3D=
=3D=0ACode;  000000000044d810 <remove_wait_queue+10/60>=0A  10:   0a c1 c5 =
a7       brnz,pn   %g7, 16ac <_TPC+0x16ac> 000000000044eeac <__mmdrop+10c/2=
40>=0ACode;  000000000044d814 <remove_wait_queue+14/60>=0A  14:   81 43 e0 =
0a       membar  #StoreStore|#StoreLoad=0ACode;  000000000044d818 <remove_w=
ait_queue+18/60>=0A  18:   b6 06 60 10       add  %i1, 0x10, %i3=0ACode;  0=
00000000044d81c <remove_wait_queue+1c/60>=0A  1c:   c6 5e 60 10       ldx  =
[ %i1 + 0x10 ], %g3=0ACode;  000000000044d820 <remove_wait_queue+20/60>=0A =
 20:   c4 5e e0 08       ldx  [ %i3 + 8 ], %g2=0A=0AJun 15 07:27:00 oekalux=
08 kernel: CPU[1]: local_irq_count[0] irqs_running[0]=0AJun 15 07:27:00 oek=
alux08 kernel: TSTATE: 0000009900000a05 TPC: 00000000700bd2a8 TNPC: 0000000=
0700bd2ac Y: 007ab870    Tainted: P =0AJun 15 07:27:00 oekalux08 kernel: g0=
: 0000000000000000 g1: 00000000002e5000 g2: 0000000000000000 g3: 0000000000=
000000=0AJun 15 07:27:00 oekalux08 kernel: g4: 000000000000006e g5: 0000000=
000000000 g6: 0000000000000000 g7: 0000000001010101=0AJun 15 07:27:00 oekal=
ux08 kernel: o0: 00000000effffaf0 o1: 0000000000000800 o2: 0000000003ffffff=
 o3: 00000000701677b0=0AJun 15 07:27:00 oekalux08 kernel: o4: 0000000000000=
00f o5: 0000000000000007 sp: 00000000efffec38 ret_pc: 00000000700bc52c=0AJu=
n 15 07:27:00 oekalux08 kernel: l0: 00000000 l1: 00000000 l2: 00000000 l3: =
00000000 l4: 00000000 l5: 00000000 l6: 00000000 l7: 701878d4=0AJun 15 07:27=
:00 oekalux08 kernel: i0: efffed00 i1: effff2f0 i2: 00000800 i3: effff2f0 i=
4: 70183704 i5: fffff594 i6: efffeca0 i7: 700b170c=0A=0A>>TPC; 00000000700b=
d2a8 <END_OF_CODE+6dfb476a/????>   <=3D=3D=3D=3D=3D=0A>>O7;  00000000700bc5=
2c <END_OF_CODE+6dfb39ee/????>=0A>>I7;  00000000700b170c <END_OF_CODE+6dfa8=
bce/????>=0A=0A=0A17 warnings issued.  Results may not be reliable.=0A
------_=_NextPart_000_01C452DB.92A1AD06--
