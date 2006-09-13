From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
Date: Wed, 13 Sep 2006 05:06:25 +0000
Subject: AW: fix 2.4.33.3 / sun partition size
Message-Id: <DA6197CAE190A847B662079EF7631C06015692C4@OEKAW2EXVS03.hbi.ad.harman.com>
List-Id: <sparclinux.vger.kernel.org>
References: <DA6197CAE190A847B662079EF7631C06015692C2@OEKAW2EXVS03.hbi.ad.harman.com>
In-Reply-To: <DA6197CAE190A847B662079EF7631C06015692C2@OEKAW2EXVS03.hbi.ad.harman.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Willy Tarreau <w@1wt.eu>, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, Jeff Mahoney <jeffm@suse.com>, sparclinux@vger.kernel.org

Hi Willy,
> It would really depend on the on-disk format. If the=20
> partition table really stores 32 bit ints for sector counts,=20
> there's no point switching from ints to longs. But if it=20
> already stores 64 bits, then we're limiting it to 2 TB with=20
> 32 bit ints. I haven't checked the code right now, so I don't=20
> know. I hope Davem will enlighten us on this matter.
>=20
I see your point. The question is: what happens if we forcibly cast a 8 byt=
e unsigned long into a 4 byte (unsigned ...) int.
One point is only sun related here: the 1/2TByte limit for sun partitions. =
The other things are generic ones, independent of the architecture but no: =
at the very moment that a long differs in size from an int we run into prob=
lems IMHO. It's unclean, at last.
Do you think it would be better to do an explicit cast in each call to pinp=
oint the issue?
Thanks for your inputs, and, yes, it's been quiet on sparclinux, it sounds =
like Dave Miller is (hopefully!) off for holidays - and I think he deserves=
 it, doesn't he :-) ?
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

