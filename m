From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
Date: Tue, 12 Sep 2006 11:32:40 +0000
Subject: fdisk for huge partitions
Message-Id: <DA6197CAE190A847B662079EF7631C06015692C3@OEKAW2EXVS03.hbi.ad.harman.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Dear listmembers,
given partition sizes beyond 1 TByte fdisk displays nonsense (i. e. negativ=
e numbers) on sparc (at least). I have prepared and tested a small patch to=
 cope with this (up to 2 TByte, at last). Can someone tell me whom to send =
the patch to?
Maintainers for the sparc portion were Mr. Jelinek and Mr. de Melho, but th=
at's close to 10 Years ago.
Thank you in advance,
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

