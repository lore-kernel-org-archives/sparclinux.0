From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
Date: Mon, 05 Apr 2004 06:28:11 +0000
Subject: Question on OOPS / U60 / Kernel 2.4.24-SMP
Message-Id: <CFE6A2529AC5FA439B3D852B0F2A68371A2A96@OEKAW2EXVS02.hbi.ad.harman.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----_=_NextPart_000_01C41AD7.2B02F3A4"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C41AD7.2B02F3A4
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Dear listmembers,
please find an "oops" and the corresponding output of ksymoops. This
happened when doing heavy nettraffic between two systems ("oekap34i"
(PC-based) and "oekalux08" (U60)). oekap34i was mounted via NFS, in parallel
traffic was generated from another PC via SMB.

- U60, 512MB ram, 360 MHz, 2 CPU,
- 29160 SCSI-controller, Promise Raid Array as main drive
- Symbios SCSI-controller drives Scanner and boot-CD-drive
- PCI-network-card 100 MBit
- PCI Promise IDE-controller

I could provide /proc/<whatever - is required>. Pleasse let me know.

I think I should give some option regarding the system architecture to the
ksymoops call. I did not find out which ones; ksymoops -a '?' tells me
sparc
sparc:sparclet
sparc:sparclite
sparc:v8plus
sparc:v8plusa
sparc:sparclite_le
sparc:v9
sparc:v9a
sparc:v8plusb
sparc:v9b
which one to use for my U60, or does ksymoops know on itself what it is all
about the architecture?
Many thanks in advance,
take care



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


------_=_NextPart_000_01C41AD7.2B02F3A4
Content-Type: application/octet-stream; name="oops"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="oops"

Apr  5 05:36:00 oekalux08 /USR/SBIN/CRON[17579]: (root) CMD (/usr/bin/faxru=
nq) =0AApr  5 05:50:00 oekalux08 /USR/SBIN/CRON[17610]: (root) CMD (/usr/lo=
cal/bin/checkfax > /var/log/checkfax.dbg 2>&1) =0AApr  5 05:59:00 oekalux08=
 /USR/SBIN/CRON[17850]: (root) CMD ( rm -f /var/spool/cron/lastrun/cron.hou=
rly) =0AApr  5 06:06:00 oekalux08 /USR/SBIN/CRON[17875]: (root) CMD (/usr/b=
in/faxrunq) =0AApr  5 06:20:00 oekalux08 /USR/SBIN/CRON[17909]: (root) CMD =
(/usr/local/bin/checkfax > /var/log/checkfax.dbg 2>&1) =0AApr  5 06:22:31 o=
ekalux08 sshd[18150]: Accepted password for fred from ::ffff:172.16.57.131 =
port 1997 ssh2=0AApr  5 06:23:13 oekalux08 su: (to DJurzitza) fred on /dev/=
pts/2=0AApr  5 06:23:13 oekalux08 PAM-unix2[18406]: session started for use=
r DJurzitza, service su =0AApr  5 06:28:47 oekalux08 PAM-unix2[18406]: sess=
ion finished for user DJurzitza, service su =0AApr  5 06:29:27 oekalux08 su=
: (to root) fred on /dev/pts/2=0AApr  5 06:29:27 oekalux08 PAM-unix2[18437]=
: session started for user root, service su =0AApr  5 06:29:58 oekalux08 ke=
rnel: data_access_exception: SFSR[0000000000801009] SFAR[fffffe63730e3eb0],=
 going.=0AApr  5 06:29:58 oekalux08 kernel:               \|/ ____ \|/=0AAp=
r  5 06:29:58 oekalux08 kernel:               "@'/ .. \`@"=0AApr  5 06:29:5=
8 oekalux08 kernel:               /_| \__/ |_\=0AApr  5 06:29:58 oekalux08 =
kernel:                  \__U_/=0AApr  5 06:29:58 oekalux08 kernel: smbd(18=
149): Dax=0AApr  5 06:29:58 oekalux08 kernel: CPU[1]: local_irq_count[0] ir=
qs_running[0]=0AApr  5 06:29:58 oekalux08 kernel: TSTATE: 0000009111009601 =
TPC: 000000000046fca4 TNPC: 000000000046fca8 Y: 563bbc28    Tainted: P =0AA=
pr  5 06:29:58 oekalux08 kernel: g0: fffff800471a6f11 g1: fffff800607cf880 =
g2: 0000000000000000 g3: fffff800471a7d80=0AApr  5 06:29:58 oekalux08 kerne=
l: g4: fffff80000000000 g5: 0000000000000011 g6: fffff800471a4000 g7: 00000=
00000000738=0AApr  5 06:29:58 oekalux08 kernel: o0: fffff8006dc4f320 o1: 00=
000000705e600d o2: 000000000000003b o3: fffff8006dc4f358=0AApr  5 06:29:58 =
oekalux08 kernel: o4: 000000000059bc80 o5: 0000000000000000 sp: fffff800471=
a6f41 ret_pc: 0000000000476f90=0AApr  5 06:29:58 oekalux08 kernel: l0: ffff=
f8006dc4f320 l1: 0000000000000002 l2: 0000000000000000 l3: 0000000000000000=
=0AApr  5 06:29:58 oekalux08 kernel: l4: 0000000000000000 l5: 0000000000000=
006 l6: 0000000000000000 l7: 0000000000000008=0AApr  5 06:29:58 oekalux08 k=
ernel: i0: 7a45ee63730e3e80 i1: 0000000000000000 i2: fffff800607cfe50 i3: 0=
00000000000000a=0AApr  5 06:29:58 oekalux08 kernel: i4: 0000000000000000 i5=
: 0000000000000000 i6: fffff800471a7001 i7: 000000000059f938=0AApr  5 06:29=
:58 oekalux08 kernel: Caller[000000000059f938]=0AApr  5 06:29:58 oekalux08 =
kernel: Caller[000000000059f984]=0AApr  5 06:29:58 oekalux08 kernel: Caller=
[000000000059fb14]=0AApr  5 06:29:58 oekalux08 kernel: Caller[00000000005ca=
4d4]=0AApr  5 06:29:58 oekalux08 kernel: Caller[00000000005ede6c]=0AApr  5 =
06:29:58 oekalux08 kernel: Caller[000000000059bbd0]=0AApr  5 06:29:58 oekal=
ux08 kernel: Caller[000000000059bcfc]=0AApr  5 06:29:58 oekalux08 kernel: C=
aller[0000000000476f90]=0AApr  5 06:29:58 oekalux08 kernel: Caller[00000000=
00410eb4]=0AApr  5 06:29:58 oekalux08 kernel: Caller[0000000000126af0]=0AAp=
r  5 06:29:58 oekalux08 kernel: Instruction DUMP: 01000000  01000000  9de3b=
f40 <d05e2030> 913a300e  808a2001  12680009  90102001  4006e74a =0AApr  5 0=
6:29:58 oekalux08 kernel: CPU[0]: local_irq_count[0] irqs_running[0]=0AApr =
 5 06:29:58 oekalux08 kernel: TSTATE: 0000009900000a00 TPC: 00000000700957e=
4 TNPC: 00000000700957e8 Y: 007a0bb0    Tainted: P =0AApr  5 06:29:58 oekal=
ux08 kernel: g0: 0000000000000000 g1: 0000000000000003 g2: 0000000000000000=
 g3: 0000000000000003=0AApr  5 06:29:58 oekalux08 kernel: g4: 0000000000000=
06e g5: 0000000000000000 g6: 0000000000000000 g7: 0000000001010101=0AApr  5=
 06:29:58 oekalux08 kernel: o0: 00000000efffebb8 o1: 0000000070167858 o2: 0=
0000000701819d0 o3: 00000000efffebb8=0AApr  5 06:29:58 oekalux08 kernel: o4=
: 0000000070183704 o5: 0000000000000000 sp: 00000000efffe428 ret_pc: 000000=
0070095eec=0AApr  5 06:29:58 oekalux08 kernel: l0: 00000003 l1: efffe428 l2=
: efffebb8 l3: 00000073 l4: 00000000 l5: 00000000 l6: 00000000 l7: 701878d4=
=0AApr  5 06:29:58 oekalux08 kernel: i0: 00000000 i1: 70167858 i2: efffed20=
 i3: 00000000 i4: 70183704 i5: fffff594 i6: efffeb58 i7: 700b171c=0AApr  5 =
06:30:08 oekalux08 kernel: nfs: server oekap34i not responding, timed out=
=0AApr  5 06:30:08 oekalux08 kernel: nfs_get_root: getattr error =3D 5=0AAp=
r  5 06:30:08 oekalux08 kernel: nfs_get_root: getattr error =3D 70=0AApr  5=
 06:30:08 oekalux08 kernel: nfs_read_super: get root inode failed=0AApr  5 =
06:30:08 oekalux08 kernel: nfs warning: mount version older than kernel=0AA=
pr  5 06:30:21 oekalux08 PAM-unix2[18437]: session finished for user root, =
service su =0AApr  5 07:00:29 oekalux08 syslogd 1.4.1: restart.=0A
------_=_NextPart_000_01C41AD7.2B02F3A4
Content-Type: application/octet-stream; name="ksymoops-oopsout"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="ksymoops-oopsout"

ksymoops 2.4.2 on sparc64 2.4.24-SMP.  Options used=0A     -v /home/fred/wo=
rk/kernel/linux/vmlinux (specified)=0A     -k /proc/ksyms (default)=0A     =
-l /proc/modules (default)=0A     -o /lib/modules/2.4.24-SMP/ (default)=0A =
    -m /boot/System.map-2.4.24-SMP (specified)=0A=0AWarning (compare_maps):=
 ksyms_base symbol GPLONLY___ide_do_rw_disk not found in vmlinux.  Ignoring=
 ksyms_base entry=0AWarning (compare_maps): ksyms_base symbol GPLONLY_ide_a=
dd_generic_settings not found in vmlinux.  Ignoring ksyms_base entry=0AWarn=
ing (compare_maps): ksyms_base symbol GPLONLY_ide_build_dmatable not found =
in vmlinux.  Ignoring ksyms_base entry=0AWarning (compare_maps): ksyms_base=
 symbol GPLONLY_ide_destroy_dmatable not found in vmlinux.  Ignoring ksyms_=
base entry=0AWarning (compare_maps): ksyms_base symbol GPLONLY_ide_dma_intr=
 not found in vmlinux.  Ignoring ksyms_base entry=0AWarning (compare_maps):=
 ksyms_base symbol GPLONLY_ide_get_best_pio_mode not found in vmlinux.  Ign=
oring ksyms_base entry=0AWarning (compare_maps): ksyms_base symbol GPLONLY_=
ide_pci_register_driver not found in vmlinux.  Ignoring ksyms_base entry=0A=
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_pci_unregister_driver=
 not found in vmlinux.  Ignoring ksyms_base entry=0AWarning (compare_maps):=
 ksyms_base symbol GPLONLY_ide_pio_timings not found in vmlinux.  Ignoring =
ksyms_base entry=0AWarning (compare_maps): ksyms_base symbol GPLONLY_ide_se=
t_xfer_rate not found in vmlinux.  Ignoring ksyms_base entry=0AWarning (com=
pare_maps): ksyms_base symbol GPLONLY_ide_setup_dma not found in vmlinux.  =
Ignoring ksyms_base entry=0AWarning (compare_maps): ksyms_base symbol GPLON=
LY_ide_setup_pci_device not found in vmlinux.  Ignoring ksyms_base entry=0A=
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_setup_pci_devices not=
 found in vmlinux.  Ignoring ksyms_base entry=0AWarning (compare_maps): ip_=
conntrack symbol GPLONLY_ip_conntrack_expect_find_get not found in /lib/mod=
ules.dirs/2.4.24-SMP-test/kernel/net/ipv4/netfilter/ip_conntrack.o.  Ignori=
ng /lib/modules.dirs/2.4.24-SMP-test/kernel/net/ipv4/netfilter/ip_conntrack=
.o entry=0AWarning (compare_maps): ip_conntrack symbol GPLONLY_ip_conntrack=
_expect_put not found in /lib/modules.dirs/2.4.24-SMP-test/kernel/net/ipv4/=
netfilter/ip_conntrack.o.  Ignoring /lib/modules.dirs/2.4.24-SMP-test/kerne=
l/net/ipv4/netfilter/ip_conntrack.o entry=0AWarning (compare_maps): ip_conn=
track symbol GPLONLY_ip_conntrack_find_get not found in /lib/modules.dirs/2=
.4.24-SMP-test/kernel/net/ipv4/netfilter/ip_conntrack.o.  Ignoring /lib/mod=
ules.dirs/2.4.24-SMP-test/kernel/net/ipv4/netfilter/ip_conntrack.o entry=0A=
Warning (compare_maps): ip_conntrack symbol GPLONLY_ip_conntrack_put not fo=
und in /lib/modules.dirs/2.4.24-SMP-test/kernel/net/ipv4/netfilter/ip_connt=
rack.o.  Ignoring /lib/modules.dirs/2.4.24-SMP-test/kernel/net/ipv4/netfilt=
er/ip_conntrack.o entry=0AApr  5 06:29:58 oekalux08 kernel:               \=
|/ ____ \|/=0AApr  5 06:29:58 oekalux08 kernel:               "@'/ .. \`@"=
=0AApr  5 06:29:58 oekalux08 kernel:               /_| \__/ |_\=0AApr  5 06=
:29:58 oekalux08 kernel:                  \__U_/=0AApr  5 06:29:58 oekalux0=
8 kernel: CPU[1]: local_irq_count[0] irqs_running[0]=0AApr  5 06:29:58 oeka=
lux08 kernel: TSTATE: 0000009111009601 TPC: 000000000046fca4 TNPC: 00000000=
0046fca8 Y: 563bbc28    Tainted: P =0AUsing defaults from ksymoops -t elf32=
-sparc -a sparc=0AApr  5 06:29:58 oekalux08 kernel: g0: fffff800471a6f11 g1=
: fffff800607cf880 g2: 0000000000000000 g3: fffff800471a7d80=0AApr  5 06:29=
:58 oekalux08 kernel: g4: fffff80000000000 g5: 0000000000000011 g6: fffff80=
0471a4000 g7: 0000000000000738=0AApr  5 06:29:58 oekalux08 kernel: o0: ffff=
f8006dc4f320 o1: 00000000705e600d o2: 000000000000003b o3: fffff8006dc4f358=
=0AApr  5 06:29:58 oekalux08 kernel: o4: 000000000059bc80 o5: 0000000000000=
000 sp: fffff800471a6f41 ret_pc: 0000000000476f90=0AApr  5 06:29:58 oekalux=
08 kernel: l0: fffff8006dc4f320 l1: 0000000000000002 l2: 0000000000000000 l=
3: 0000000000000000=0AApr  5 06:29:58 oekalux08 kernel: l4: 000000000000000=
0 l5: 0000000000000006 l6: 0000000000000000 l7: 0000000000000008=0AApr  5 0=
6:29:58 oekalux08 kernel: i0: 7a45ee63730e3e80 i1: 0000000000000000 i2: fff=
ff800607cfe50 i3: 000000000000000a=0AApr  5 06:29:58 oekalux08 kernel: i4: =
0000000000000000 i5: 0000000000000000 i6: fffff800471a7001 i7: 000000000059=
f938=0AApr  5 06:29:58 oekalux08 kernel: Caller[000000000059f938]=0AApr  5 =
06:29:58 oekalux08 kernel: Caller[000000000059f984]=0AApr  5 06:29:58 oekal=
ux08 kernel: Caller[000000000059fb14]=0AApr  5 06:29:58 oekalux08 kernel: C=
aller[00000000005ca4d4]=0AApr  5 06:29:58 oekalux08 kernel: Caller[00000000=
005ede6c]=0AApr  5 06:29:58 oekalux08 kernel: Caller[000000000059bbd0]=0AAp=
r  5 06:29:58 oekalux08 kernel: Caller[000000000059bcfc]=0AApr  5 06:29:58 =
oekalux08 kernel: Caller[0000000000476f90]=0AApr  5 06:29:58 oekalux08 kern=
el: Caller[0000000000410eb4]=0AApr  5 06:29:58 oekalux08 kernel: Caller[000=
0000000126af0]=0AApr  5 06:29:58 oekalux08 kernel: Instruction DUMP: 010000=
00  01000000  9de3bf40 <d05e2030> 913a300e  808a2001  12680009  90102001  4=
006e74a =0A=0A>>PC;  0046fca4 <__free_pages+4/40>   <=3D=3D=3D=3D=3D=0A>>O7=
;  00476f90 <sys_read+b0/160>=0A>>I7;  0059f938 <skb_release_data+58/a0>=0A=
Trace; 0059f938 <skb_release_data+58/a0>=0ATrace; 0059f984 <kfree_skbmem+4/=
a0>=0ATrace; 0059fb14 <__kfree_skb+f4/120>=0ATrace; 005ca4d4 <tcp_recvmsg+8=
54/ba0>=0ATrace; 005ede6c <inet_recvmsg+2c/60>=0ATrace; 0059bbd0 <sock_recv=
msg+30/e0>=0ATrace; 0059bcfc <sock_read+7c/a0>=0ATrace; 00476f90 <sys_read+=
b0/160>=0ATrace; 00410eb4 <linux_sparc_syscall32+34/40>=0ATrace; 00126af0 B=
efore first symbol=0ACode;  0046fc98 <get_zeroed_page+38/40>=0A00000000 <_P=
C>:=0ACode;  0046fc98 <get_zeroed_page+38/40>=0A   0:   01 00 00 00       n=
op =0ACode;  0046fc9c <get_zeroed_page+3c/40>=0A   4:   01 00 00 00       n=
op =0ACode;  0046fca0 <__free_pages+0/40>=0A   8:   9d e3 bf 40       save =
 %sp, -192, %sp=0ACode;  0046fca4 <__free_pages+4/40>   <=3D=3D=3D=3D=3D=0A=
   c:   d0 5e 20 30       unknown   <=3D=3D=3D=3D=3D=0ACode;  0046fca8 <__f=
ree_pages+8/40>=0A  10:   91 3a 30 0e       unknown=0ACode;  0046fcac <__fr=
ee_pages+c/40>=0A  14:   80 8a 20 01       btst  1, %o0=0ACode;  0046fcb0 <=
__free_pages+10/40>=0A  18:   12 68 00 09       unknown=0ACode;  0046fcb4 <=
__free_pages+14/40>=0A  1c:   90 10 20 01       mov  1, %o0=0ACode;  0046fc=
b8 <__free_pages+18/40>=0A  20:   40 06 e7 4a       call  1b9d48 <_PC+0x1b9=
d48> 006299e0 <__atomic_sub+0/20>=0ACode;  0046fcbc <__free_pages+1c/40>=0A=
  24:   00 00 00 00       unimp  0=0A=0AApr  5 06:29:58 oekalux08 kernel: C=
PU[0]: local_irq_count[0] irqs_running[0]=0AApr  5 06:29:58 oekalux08 kerne=
l: TSTATE: 0000009900000a00 TPC: 00000000700957e4 TNPC: 00000000700957e8 Y:=
 007a0bb0    Tainted: P =0AApr  5 06:29:58 oekalux08 kernel: g0: 0000000000=
000000 g1: 0000000000000003 g2: 0000000000000000 g3: 0000000000000003=0AApr=
  5 06:29:58 oekalux08 kernel: g4: 000000000000006e g5: 0000000000000000 g6=
: 0000000000000000 g7: 0000000001010101=0AApr  5 06:29:58 oekalux08 kernel:=
 o0: 00000000efffebb8 o1: 0000000070167858 o2: 00000000701819d0 o3: 0000000=
0efffebb8=0AApr  5 06:29:58 oekalux08 kernel: o4: 0000000070183704 o5: 0000=
000000000000 sp: 00000000efffe428 ret_pc: 0000000070095eec=0AApr  5 06:29:5=
8 oekalux08 kernel: l0: 00000003 l1: efffe428 l2: efffebb8 l3: 00000073 l4:=
 00000000 l5: 00000000 l6: 00000000 l7: 701878d4=0AApr  5 06:29:58 oekalux0=
8 kernel: i0: 00000000 i1: 70167858 i2: efffed20 i3: 00000000 i4: 70183704 =
i5: fffff594 i6: efffeb58 i7: 700b171c=0A=0A>>PC;  700957e4 <END_OF_CODE+6d=
f724ce/????>   <=3D=3D=3D=3D=3D=0A>>O7;  70095eec <END_OF_CODE+6df72bd6/???=
?>=0A>>I7;  700b171c <END_OF_CODE+6df8e406/????>=0A=0A=0A17 warnings issued=
.  Results may not be reliable.=0A
------_=_NextPart_000_01C41AD7.2B02F3A4--
