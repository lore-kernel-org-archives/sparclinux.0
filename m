From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
Date: Tue, 29 Aug 2006 06:15:04 +0000
Subject: WG: [PATCH] sun disk label: fix signed int usage for sector count
Message-Id: <DA6197CAE190A847B662079EF7631C0602E1B81E@OEKAW2EXVS03.hbi.ad.harman.com>
List-Id: <sparclinux.vger.kernel.org>
References: <DA6197CAE190A847B662079EF7631C0602E1B81D@OEKAW2EXVS03.hbi.ad.harman.com>
In-Reply-To: <DA6197CAE190A847B662079EF7631C0602E1B81D@OEKAW2EXVS03.hbi.ad.harman.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Dear listmembers,
this is the very same issue as before. Therefore I forward this email to sp=
arclinux, too.
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

> -----Urspr=FCngliche Nachricht-----
> Von: linux-kernel-owner@vger.kernel.org=20
> [mailto:linux-kernel-owner@vger.kernel.org] Im Auftrag von=20
> Jurzitza, Dieter
> Gesendet: Dienstag, 29. August 2006 06:58
> An: linux-kernel@vger.kernel.org
> Betreff: AW: [PATCH] sun disk label: fix signed int usage for=20
> sector count
>=20
>=20
> Dear listmembers,
> referring to my own question (and to Jeff Mahoneys email),=20
> would it be sufficient to simply change
>=20
> - --- linux-2.6.17/fs/partitions/sun.c	2006-01-02=20
> 22:21:10.000000000 -0500
> +++ linux-2.6.17.fix/fs/partitions/sun.c	2006-08-26=20
> 11:54:54.000000000 -0400
> @@ -74,10 +74,10 @@ int sun_partition(struct parsed_partitio
>  	spc =3D be16_to_cpu(label->ntrks) * be16_to_cpu(label->nsect);
>  	for (i =3D 0; i < 8; i++, p++) {
>  		unsigned long st_sector;
> - -		int num_sectors;
> +		unsigned int num_sectors;
> =20
>  		st_sector =3D be32_to_cpu(p->start_cylinder) * spc;
>  		num_sectors =3D be32_to_cpu(p->num_sectors);
>=20
> in order to get rid of the meaningless negative numbers? If=20
> possible this would be highly preferrable over a solution=20
> that renders this partition useless. If Sun Os cannot handle=20
> this, maybe an error message when configuring such a disk=20
> would be helpful.
>=20
> Once again, thank you for your feedback,
> best regards
>=20
>=20
>=20
>=20
> Dieter Jurzitza


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

