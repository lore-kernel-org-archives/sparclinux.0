From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
Date: Fri, 18 Feb 2005 16:22:11 +0000
Subject: size-differences of long(userspace) / long(kernel)
Message-Id: <DA6197CAE190A847B662079EF7631C060E8D30@OEKAW2EXVS03.hbi.ad.harman.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0502141648360.6890@l01.thnet>
In-Reply-To: <Pine.LNX.4.61.0502141648360.6890@l01.thnet>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Dear listmembers,
one more came to my head,
when doing either kmalloc() or compat_alloc_user_space in arch/sparc64/kern=
el/sys_sparc32.c, another error stems from the fact that in len * sizeof (s=
truct kernel_syms) the sizeof operator returns 64 Byte (60 char + one long(=
=3D4)) whereas in the 64 Bit world it ought to return 72 Byte (60 char + on=
e long(=3D8) + padding(=3D4))
How to realize this if not replacing the long by an int in the declaration =
of struct kernel_syms to avoid the growth in size?
Many thanks
take care



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

