From: Ben Collins <bcollins@debian.org>
Date: Wed, 07 Jan 2004 18:25:30 +0000
Subject: [BKPATCH]: Add option to define default command line to kernel.
Message-Id: <20040107182529.GK17280@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

=================================

ChangeSet@1.1482.1.10, 2004-01-07 12:29:51-05:00, bcollins@debian.org
  [SPARC64]: Add option to define default command line to kernel.


 Kconfig        |   16 ++++++++++++++++
 prom/bootstr.c |    4 ++++
 2 files changed, 20 insertions(+)


diff -Nru a/arch/sparc64/Kconfig b/arch/sparc64/Kconfig
--- a/arch/sparc64/Kconfig	Wed Jan  7 13:22:20 2004
+++ b/arch/sparc64/Kconfig	Wed Jan  7 13:22:20 2004
@@ -489,6 +489,22 @@
 	  machines.  The watchdog timeout period is normally one minute but
 	  can be changed with a boot-time parameter.
 
+config CMDLINE_BOOL
+	bool "Default bootloader kernel arguments"
+
+config CMDLINE
+	string "Initial kernel command string"
+	depends on CMDLINE_BOOL
+	default "console=ttyS0,9600 root=/dev/sda1"
+	help
+	  Say Y here if you want to be able to pass default arguments to
+	  the kernel. This will be overridden by the bootloader, if you
+	  use one (such as SILO). This is most useful if you want to boot
+	  a kernel from TFTP, and want default options to be available
+	  with having them passed on the command line.
+
+	  NOTE: This option WILL override the PROM bootargs setting!
+
 endmenu
 
 source "drivers/base/Kconfig"
diff -Nru a/arch/sparc64/prom/bootstr.c b/arch/sparc64/prom/bootstr.c
--- a/arch/sparc64/prom/bootstr.c	Wed Jan  7 13:22:20 2004
+++ b/arch/sparc64/prom/bootstr.c	Wed Jan  7 13:22:20 2004
@@ -21,6 +21,10 @@
 	char bootstr_buf[BARG_LEN];
 } bootstr_info = {
 	.bootstr_len = BARG_LEN,
+#ifdef CONFIG_CMDLINE
+	.bootstr_valid = 1,
+	.bootstr_buf = CONFIG_CMDLINE,
+#endif
 };
 
 char * __init

=================================

This BitKeeper patch contains the following changesets:
1.1482.1.10
## Wrapped with gzip_uu ##


M'XL( %Q._#\  [56:V_;-A3];/Z*N^3+ACD223UMP$/2)&V-NK$1IQB&K@AH
MD8Z$R)(A2LXRZ,?O4I;RKH-UBRV $,5[>!_G\'(?OFA5#'N+*$_3)--D'S[F
MNASVI%HD(K/RX@JGSO,<I^Q*%[8N(OM:%9E*;5Q?_77 +9_@DIDHHQ@VJM##
M'K.<NYGR=JV&O?/3#U\F1^>$C$9P'(OL2LU5":,1*?-B(U*I#T49IWEFE87(
M]$J5PHKR57VWM.:4<OQ[+'"HY]?,IVY01TPR)ERF).5NZ+NDB^+PWOO'&"YE
MU&>A$WIA34,/34Z 6<P-N84#!>K:E-DT ,:'?##TV 'UAI3""\#P*X<#2M[!
M_QO",8G@ZWQV='[LN]^&<"0EY.LRR3/<!Z1:)IDR@ZC2$A!_)3()J9G$S]NZ
M6.03A(A%9O>I)@?_\D<(%93\!G\GZ[5*#[>E7OGAM0G]:Q?RMUH446SK-0Z^
M:W^*\FR97#61,NI@NAW.'?/JL=J5,AH([OF4!GXHPI=R^ETX4[> !=QW>>T.
MF.^A:[OS_@AI7>0K>X$DUF5A10\JX5(^J#V7A4$M?3?R(C_RE8P4]_W7_7N.
M>N>F%]0\X)PUA-]A]+H$_G,<1(J-6AUF5:FM+,FNA94A&5^!=3 ,GV&E7 ]?
MP\!K=.(]UH<_]()=^G#?2A]X9,'Q].S]^,/E\>>3R?CL%)9Y<2<+45SI/B3+
M5B[2"&);C2D<%#?-@PR?[2K,#PAFS!UPR7ZRQ&V?N$=Z5HM\B:E()(R ]1],
M+JHE3CVVZ9-]E<ED^9Q"K2X,=]Y.GB^>I=^#<QCC 67.@+$:87G8T,5E3_GB
M\EU\8?Y;$<:<HAU3MJ>I-J38GB2[2-'&^"-L0'!@/FEKU>Y^^6XZG9 >UCV%
MO9.6KX8%:2ZD*MH3W#"X6JFLU'ODSR<(I(>$2;(KV!MG29F(M+/IFL'V\Q[!
M#KY& FG UO%X]TXG>XBL\U2-RO)V3OL#+#T4Z,O(EFIC:RD8HL0J79,>P%S<
MPA\0JT(99=WF%=R(K#1=9Z% +-*F :V%U@]EN T"OQB$,E9=AX*+.-%PDZ2I
ML<[QUE D4JH,%K?-LON,]-O=#$"%LL^QT_VL*[Q8" WS\63Z2PN&SPHO+F;1
MLDJ?^8B !D)TV5JBVN'B_<6L#R9IS;K.\98A76P;D:0F0&-_DY0QQ&)C"H".
MKIJ(E30Y-GX_;,@6E@XMSJ87I\.MBVT?_WT\F70QJ\9L=C[]W+AH3B[0JBP1
=_R>TO[M%1;&*KG6U&M&E8BA4A_P#V?58;[D)    
 

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
