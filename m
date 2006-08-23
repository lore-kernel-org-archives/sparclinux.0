From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
Date: Wed, 23 Aug 2006 05:20:05 +0000
Subject: Two bugletts on Sparc 64 @ kernel 2.4
Message-Id: <DA6197CAE190A847B662079EF7631C0601569295@OEKAW2EXVS03.hbi.ad.harman.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Dear Mr. Miller,
dear listmembers,

I have been gently advised to send this message to the list directly, so he=
re you go. Sorry for the bounces. This refers to replacing the unsigned lon=
g against unsigned int in struct kernel_sym in linux/include/linux/module.h:
--- linux/include/linux/module.h	2004-12-15 08:34:44.000000000 +0100
+++ linux/include/linux/module.h	2004-12-15 08:45:32.000000000 +0100
@@ -31,7 +31,11 @@
 /* Used by get_kernel_syms, which is obsolete.  */
 struct kernel_sym
 {
-	unsigned long value;
+#ifdef __ARCH_SPARC64_ATOMIC__
+	  unsigned int value;
+#else
+          unsigned long value;
+#endif
 	char name[60];		/* should have been 64-sizeof(long); oh well */
 };

For your explanation, the posting below I had had sent initially in 2004 - =
quite some time ago. See below. As nobody reacted and the list says: be pat=
ient, I thought it might be a good idea to send this to the kernel mailing =
list directly.=20
Sorry, maybe I sent to debian sparc instead of sparclinux, and I did not ma=
ke a CC to sparclinux right now. Here you see two debug - messages "Size of=
 table: 1843, what is too much to work, because SPARC 64 kernel "off stock"=
 can only do 1820 for Size of table.

     Dec 13 09:35:10 oekalux09 syslogd 1.4.1#16: restart.
     Dec 13 09:35:10 oekalux09 kernel: klogd 1.4.1#16, log source =3D /proc=
/kmsg started.
     Dec 13 09:35:10 oekalux09 kernel: Inspecting /boot/System.map-2.4.26-S=
MP
     Dec 13 09:35:11 oekalux09 kernel: Loaded 14411 symbols from /boot/Syst=
em.map-2.4.26-SMP.
     Dec 13 09:35:11 oekalux09 kernel: Symbols match kernel version 2.4.26.
**** Dec 13 09:35:11 oekalux09 kernel: Loading kernel module symbols - Size=
 of table: 1843 Sizeof alloc: >>117952 /* debugging */
**** Dec 13 09:35:11 oekalux09 kernel: We use __GLIBC__ for klogd  /* debug=
ging */
>>>> Dec 13 09:35:11 oekalux09 kernel: Error reading kernel symbols -=20
>>>> Cannot allocate memory
     Dec 13 09:35:11 oekalux09 kernel: Errno was: -1=20
     Dec 13 09:35:11 oekalux09 kernel: PROMLIB: Sun IEEE Boot Prom 3.23.1 1=
999/07/16 12:08
     Dec 13 09:35:12 oekalux09 kernel: Linux version 2.4.26-SMP (root@oekal=
ux09) (gcc-Version 3.3.4 (Debian 1:3.3.4-13)) #1 SMP Mo Dez 13 09:01:5

And the root cause is, (citing myself):
> What I found is that the allocation works up to 1820 elements of the=20
> size 72 Bytes, however, we would need a tiny little more (1843 in my=20
> case, please take a look into the attachement).

and the solution is: use an unsigned int rather than an unsigned long for "=
value" in struct kernel_sym. We get usually 60 Bytes from char name[] and a=
nother 4 Byte from unsigned long value on i386. However, in kernel space si=
zeof (unsigned long) gives 8 for sparc64, thereby enlarging sizeof(kernel_s=
ym) to 68. We have to be word aligned, so we end up with 72Byte per struct =
kernel_sym rather than 64Byte per struct kernel_sym on i386. This in turn a=
llows 2^17/72 symbols to be read in contrast to 2^17/64 symbols to be read.=
 Therefore on sparc64 one does not get more than 1820 symbols in contrast t=
o 2048 symbols on i386.

the only possible cause IMHO is the fact that sizeof (unsgned long) in kern=
el space is 8 and not 4, because the array of char in struct kernel_sym can=
not cause this.

Using my suggested patch I get (today since then ...) no error, no warning:

Aug 15 06:48:54 oekalux08 syslogd 1.4.1: restart.
Aug 15 06:48:55 oekalux08 in.identd[634]: started
Aug 15 06:48:59 oekalux08 kernel: klogd 1.4.1, log source =3D /proc/kmsg st=
arted.=20
Aug 15 06:48:59 oekalux08 kernel: Inspecting /boot/System.map-2.4.33-SMP
Aug 15 06:49:00 oekalux08 kernel: Loaded 14439 symbols from /boot/System.ma=
p-2.4.33-SMP.
Aug 15 06:49:00 oekalux08 kernel: Symbols match kernel version 2.4.33.
Aug 15 06:49:00 oekalux08 kernel: Loaded 241 symbols from 11 modules.
Aug 15 06:49:00 oekalux08 kernel: ip_tables: (C) 2000-2002 Netfilter core t=
eam
Aug 15 06:49:00 oekalux08 kernel: ip_conntrack version 2.1 (4015 buckets, 3=
2120 max) - 416 bytes per conntrack
*******

I readily mentionend back in 2004 that I do not think my using this #define=
 was very smart, I think that the "kernel gurus" out there can do much bett=
er here.
I cannot think of any reason value should be larger than 2^32, but maybe I =
am wrong. AFAIK there is no way to make kmalloc() provide more than 2^17 By=
te, but maybe I am wrong here, too.

If you say this cannot work: please be more specific. If you need even debu=
g output / a patch showing exactly this, I can provide. As a matter of fact=
: it works. If the reason why it works differs from my explanation I would =
highly appreciate to be told why.

Just saying: "I cannot see why this should work" is hardly of any help for =
understanding things.

Take care



Dieter Jurzitza



--=20
________________________________________________

HARMAN BECKER AUTOMOTIVE SYSTEMS

Dr.-Ing. Dieter Jurzitza
Manager Hardware Systems
   System Development

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

