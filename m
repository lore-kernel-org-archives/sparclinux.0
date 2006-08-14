From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
Date: Mon, 14 Aug 2006 10:36:57 +0000
Subject: AW: latest 2.4.33 kernel
Message-Id: <DA6197CAE190A847B662079EF7631C0602E1B76C@OEKAW2EXVS03.hbi.ad.harman.com>
List-Id: <sparclinux.vger.kernel.org>
References: <DA6197CAE190A847B662079EF7631C0601569276@OEKAW2EXVS03.hbi.ad.harman.com>
In-Reply-To: <DA6197CAE190A847B662079EF7631C0601569276@OEKAW2EXVS03.hbi.ad.harman.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Dear listmembers,
dear Mr. Miller,
lib/string.c defines a=20
#infdef __HAVE_ARCH_MEMCHR
memchr() {
....
}
#endif

function. I thought initially it would be enough to put an #include <linux/=
string.h>  into linux/fs/smbfs/dir.c where memchr is declared, but this did=
 not help.=20

I am not the experienced C-programming guru, I just stumbled somewhat over =
a buglett and would appreciate any help regarding that matter.

Is it possible that __HAVE_ARCH_MEMCHR is defined even though it isn't avai=
lable? Should I try to undef it, and if so, where would I do this?

Thank you very much,
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

> -----Urspr=FCngliche Nachricht-----
> Von: sparclinux-owner@vger.kernel.org=20
> [mailto:sparclinux-owner@vger.kernel.org] Im Auftrag von David Miller
> Gesendet: Montag, 14. August 2006 12:17
> An: Jurzitza, Dieter
> Cc: sparclinux@vger.kernel.org
> Betreff: Re: latest 2.4.33 kernel
>=20
>=20
>=20
> If memchr() is going to be used by some part of the kernel, a=20
> default implementation should exist in lib/string.c and it's=20
> symbol exported.
*******


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

