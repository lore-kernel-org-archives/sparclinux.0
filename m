From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
Date: Thu, 29 Apr 2004 05:48:40 +0000
Subject: Another OOPS
Message-Id: <CFE6A2529AC5FA439B3D852B0F2A68371A2B29@OEKAW2EXVS02.hbi.ad.harman.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----_=_NextPart_000_01C42DAD.9F6AC66E"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C42DAD.9F6AC66E
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Dear Listmembers,
currently I see oopses about once a day, no matter which one of the two U60
we have is in use. Because this is highly inconvinient for the about 50
people working on this system I wonder whether I should switch from Sparc to
i386, because I cannot help myself any more - and it seems to me as if no
one out there has an idea what problems I am trying to track down.

Thus, once again an attempt to supply the rare output of an oops to the list
- every other time I get one. If any nice soul out there would have an idea
on the meaning of this, please let me know. I am willing to supply any
information required - if I only knew what to supply.

Did ever ever anybody run sparc linux in a professional environment having
many people working in parallel on the system? By any means, my degree of
frustration is rising continuously.

So, if any nice guy out there would be willing to help - I am willing to
support whatever is required if I only knew ...
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
se notify the sender immediately and delete this e-mail. Any unauthorized c=
opying, disclosure or distribution of the contents in this e-mail is strict=
ly forbidden.
*******************************************


------_=_NextPart_000_01C42DAD.9F6AC66E
Content-Type: application/octet-stream; name="oops-U60.neu"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="oops-U60.neu"

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
6-SMP-test/kernel/net/ipv4/netfilter/ip_conntrack.o entry=0AApr 28 11:23:35=
 oekalux08 kernel:               \|/ ____ \|/=0AApr 28 11:23:35 oekalux08 k=
ernel:               "@'/ .. \`@"=0AApr 28 11:23:35 oekalux08 kernel:      =
         /_| \__/ |_\=0AApr 28 11:23:35 oekalux08 kernel:                  =
\__U_/=0AApr 28 11:23:35 oekalux08 kernel: CPU[1]: local_irq_count[0] irqs_=
running[0]=0AApr 28 11:23:35 oekalux08 kernel: TSTATE: 0000000011f09606 TPC=
: 000000000044d824 TNPC: 000000000044d828 Y: 01800000    Tainted: P =0AApr =
28 11:23:35 oekalux08 kernel: g0: fffff800464ebb1c g1: 00000000000000f9 g2:=
 fffff80046cce358 g3: 65320a2020393a20=0AApr 28 11:23:35 oekalux08 kernel: =
g4: fffff80000000000 g5: 0000000000000003 g6: fffff800464e8000 g7: 00000000=
00000000=0AApr 28 11:23:35 oekalux08 kernel: o0: 0000000000000000 o1: 00000=
0000001f800 o2: 0000000000000000 o3: 0000000000000000=0AApr 28 11:23:35 oek=
alux08 kernel: o4: 000000000066b898 o5: 0000000000000000 sp: fffff800464eb3=
51 ret_pc: fffff800464ebc90=0AApr 28 11:23:35 oekalux08 kernel: l0: 0000000=
000758c00 l1: fffff8006fea4000 l2: fffff8006fea4ac8 l3: 0000000000001fff=0A=
Apr 28 11:23:35 oekalux08 kernel: l4: 0000000000000001 l5: 000000000000000f=
 l6: 000000000000000f l7: 0000000070147434=0AApr 28 11:23:35 oekalux08 kern=
el: i0: fffff80046cce350 i1: fffff800452a00a8 i2: 0000000000000000 i3: ffff=
f800452a00b8=0AApr 28 11:23:35 oekalux08 kernel: i4: 00000000006906d8 i5: 0=
0000000005fee20 i6: fffff800464eb411 i7: 000000000048badc=0AApr 28 11:23:35=
 oekalux08 kernel: Caller[000000000048badc]=0AApr 28 11:23:35 oekalux08 ker=
nel: Caller[000000000048bedc]=0AApr 28 11:23:35 oekalux08 kernel: Caller[00=
00000000433a6c]=0AApr 28 11:23:35 oekalux08 kernel: Caller[0000000000410eb4=
]=0AApr 28 11:23:35 oekalux08 kernel: Caller[000000007090ec24]=0AApr 28 11:=
23:35 oekalux08 kernel: Instruction DUMP: b6066010  c65e6010  c45ee008 <c47=
0e008> c6708000  c0766010  c076e008  8143e00c  c02e0000 =0A=0A>>TPC; 000000=
000044d824 <remove_wait_queue+24/60>   <=3D=3D=3D=3D=3D=0A>>O7;  fffff80046=
4ebc90 <END_OF_CODE+fffff800443dd152/????>=0A>>I7;  000000000048badc <poll_=
freewait+1c/60>=0ATrace; 000000000048badc <poll_freewait+1c/60>=0ATrace; 00=
0000000048bedc <do_select+1fc/220>=0ATrace; 0000000000433a6c <sys32_select+=
30c/4e0>=0ATrace; 0000000000410eb4 <linux_sparc_syscall32+34/40>=0ATrace; 0=
00000007090ec24 <END_OF_CODE+6e8000e6/????>=0ACode;  000000000044d818 <remo=
ve_wait_queue+18/60>=0A0000000000000000 <_TPC>:=0ACode;  000000000044d818 <=
remove_wait_queue+18/60>=0A   0:   b6 06 60 10       add  %i1, 0x10, %i3=0A=
Code;  000000000044d81c <remove_wait_queue+1c/60>=0A   4:   c6 5e 60 10    =
   ldx  [ %i1 + 0x10 ], %g3=0ACode;  000000000044d820 <remove_wait_queue+20=
/60>=0A   8:   c4 5e e0 08       ldx  [ %i3 + 8 ], %g2=0ACode;  00000000004=
4d824 <remove_wait_queue+24/60>   <=3D=3D=3D=3D=3D=0A   c:   c4 70 e0 08   =
    stx  %g2, [ %g3 + 8 ]   <=3D=3D=3D=3D=3D=0ACode;  000000000044d828 <rem=
ove_wait_queue+28/60>=0A  10:   c6 70 80 00       stx  %g3, [ %g2 ]=0ACode;=
  000000000044d82c <remove_wait_queue+2c/60>=0A  14:   c0 76 60 10       cl=
rx  [ %i1 + 0x10 ]=0ACode;  000000000044d830 <remove_wait_queue+30/60>=0A  =
18:   c0 76 e0 08       clrx  [ %i3 + 8 ]=0ACode;  000000000044d834 <remove=
_wait_queue+34/60>=0A  1c:   81 43 e0 0c       membar  #StoreStore|#LoadSto=
re=0ACode;  000000000044d838 <remove_wait_queue+38/60>=0A  20:   c0 2e 00 0=
0       clrb  [ %i0 ]=0A=0AApr 28 11:23:35 oekalux08 kernel: CPU[0]: local_=
irq_count[0] irqs_running[0]=0AApr 28 11:23:35 oekalux08 kernel: TSTATE: 00=
00004400000a06 TPC: 00000000700ea118 TNPC: 00000000700ea11c Y: 007acfc0    =
Tainted: P =0AApr 28 11:23:35 oekalux08 kernel: g0: 0000000000000000 g1: ff=
ffffffff424453 g2: 0000000000000000 g3: 0000000000000018=0AApr 28 11:23:35 =
oekalux08 kernel: g4: 0000000000000000 g5: 0000000000000000 g6: 00000000000=
00000 g7: ffffffffff000000=0AApr 28 11:23:35 oekalux08 kernel: o0: 00000000=
fffffd64 o1: 00000000fffffd70 o2: 0000000070189c04 o3: fffffffffffffff8=0AA=
pr 28 11:23:35 oekalux08 kernel: o4: 0000000070183de8 o5: 0000000070189c08 =
sp: 00000000efffec70 ret_pc: 00000000700e9fe8=0AApr 28 11:23:35 oekalux08 k=
ernel: l0: 70183de8 l1: ffffffff l2: 70183de8 l3: 0002a3e4 l4: 70189bf4 l5:=
 70189bf8 l6: 00000001 l7: 701878d4=0AApr 28 11:23:35 oekalux08 kernel: i0:=
 70189bec i1: 00000001 i2: fffffc00 i3: efffed38 i4: 7018bea8 i5: 408f7817 =
i6: efffecd8 i7: 700e8d5c=0AWarning (Oops_read): Code line not seen, dumpin=
g what data is available=0A=0A>>TPC; 00000000700ea118 <END_OF_CODE+6dfdb5da=
/????>   <=3D=3D=3D=3D=3D=0A>>O7;  00000000700e9fe8 <END_OF_CODE+6dfdb4aa/?=
???>=0A>>I7;  00000000700e8d5c <END_OF_CODE+6dfda21e/????>=0A=0A=0A18 warni=
ngs issued.  Results may not be reliable.=0A
------_=_NextPart_000_01C42DAD.9F6AC66E--
