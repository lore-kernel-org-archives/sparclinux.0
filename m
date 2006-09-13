From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
Date: Wed, 13 Sep 2006 05:40:26 +0000
Subject: AW: fix 2.4.33.3 / sun partition size
Message-Id: <DA6197CAE190A847B662079EF7631C06015692C6@OEKAW2EXVS03.hbi.ad.harman.com>
List-Id: <sparclinux.vger.kernel.org>
References: <DA6197CAE190A847B662079EF7631C06015692C2@OEKAW2EXVS03.hbi.ad.harman.com>
In-Reply-To: <DA6197CAE190A847B662079EF7631C06015692C2@OEKAW2EXVS03.hbi.ad.harman.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Willy Tarreau <w@1wt.eu>
Cc: linux-kernel@vger.kernel.org, Jeff Mahoney <jeffm@suse.com>, sparclinux@vger.kernel.org, davem@davemloft.net

Dear Willy,
one final thougth here: ist there any real reason to *not* make
add_gd_partition (struct gendisk, int minor, unsigned long start, unsigned =
long size){...}
(see fs/partitions/check.c)
as:

- within add_gd_partition the two values start and size are assigned to a f=
ield of type unsigned long,
- we both agree that there is no reason to use signed ints in this case,
- any byte size conversion issue would be covered by the fact that it does =
not hurt assigning too small numbers to oversized ones.

Just my two cents here ...

Take care




Dieter


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

