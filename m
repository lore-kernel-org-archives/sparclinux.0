From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
Date: Mon, 14 Aug 2006 12:31:15 +0000
Subject: AW: AW: latest 2.4.33 kernel
Message-Id: <DA6197CAE190A847B662079EF7631C0601569278@OEKAW2EXVS03.hbi.ad.harman.com>
List-Id: <sparclinux.vger.kernel.org>
References: <DA6197CAE190A847B662079EF7631C0601569276@OEKAW2EXVS03.hbi.ad.harman.com>
In-Reply-To: <DA6197CAE190A847B662079EF7631C0601569276@OEKAW2EXVS03.hbi.ad.harman.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Dear listmembers,
dear Mr. Miller,
thanks a lot for the hints - your suggestion made everything work as (you w=
ould have) expected.

I wonder how this works on 2.6.X, I found a EXPORT_SYMBOL(memchr), but ther=
e is also no ach-specific implementation of memchr() on sparc 2.6 (AFAIK).

So, please find a patch attached for both sparc and sparc64 against vanilla=
 2.4.33; IMHO it would make sense to integrate this into the 2.4 kernel tre=
e as it is very common for people to build smbfs as a module and not everyo=
ne would ask on this list for help (hopefully :-) ).

Maybe this would fit into 2.4.34X.

Thanks again for helping,
take care




Dieter Jurzitza


CUTCUTCUTCUTCUTCUTCUTCUTCUTCUTCUTCUTCUTCUTCUTCUTCUTCUTCUTCUTCUTCUTCUTCUTCUT=
CUTCUTCUTCUTCUT
--- linux/arch/sparc64/kernel/sparc64_ksyms.c.original	2005-11-16 20:12:54.=
000000000 +0100
+++ linux/arch/sparc64/kernel/sparc64_ksyms.c	2006-08-14 12:55:48.000000000=
 +0200
@@ -357,6 +357,7 @@
 EXPORT_SYMBOL_NOVERS(__ret_efault);
=20
 /* No version information on these, as gcc produces such symbols. */
+EXPORT_SYMBOL_NOVERS(memchr);
 EXPORT_SYMBOL_NOVERS(memcmp);
 EXPORT_SYMBOL_NOVERS(memcpy);
 EXPORT_SYMBOL_NOVERS(memset);
--- linux/arch/sparc/kernel/sparc_ksyms.c.original	2006-08-14 12:59:04.0000=
00000 +0200
+++ linux/arch/sparc/kernel/sparc_ksyms.c	2006-08-14 12:59:04.000000000 +02=
00
@@ -293,6 +293,7 @@
 EXPORT_SYMBOL_NOVERS(__ret_efault);
=20
 /* No version information on these, as gcc produces such symbols. */
+EXPORT_SYMBOL_NOVERS(memchr);
 EXPORT_SYMBOL_NOVERS(memcmp);
 EXPORT_SYMBOL_NOVERS(memcpy);
 EXPORT_SYMBOL_NOVERS(memset);
CUTCUTCUTCUTCUTCUTCUTCUTCUTCUTCUTCUTCUTCUTCUTCUTCUTCUTCUTCUTCUTCUTCUTCUTCUT=
CUTCUTCUTCUTCUT

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

> -----Urspr=FCngliche Nachricht-----
> Von: David Miller [mailto:davem@davemloft.net]=20
******
> In that case you need to add the line=20
> "EXPORT_SYMBOL_NOVERS(memchr);" to the file(s)=20
> arch/sparc{,64}/kernel/sparc{,64}_ksyms.c
******


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

