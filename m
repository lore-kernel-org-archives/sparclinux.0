From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
Date: Thu, 31 Aug 2006 04:56:59 +0000
Subject: AW: [PATCH] sun disk label: fix signed int usage for sector count
Message-Id: <DA6197CAE190A847B662079EF7631C0602E1B832@OEKAW2EXVS03.hbi.ad.harman.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

Dear listmembers,
the change did not change anything apparently - what had had to be expected=
, as the negative numbers presented for the size of partition three must be=
 caused by some printfs' into /proc/partitions or alike.
If someone would kindly guide me as where to look for this issue I am willi=
ng to test - using unsigned should increase the limit by a factor of two - =
not too much, but neither too bad.
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
>=20
>=20
> --=20
> ________________________________________________
>=20
> HARMAN BECKER AUTOMOTIVE SYSTEMS
>=20
> Dr.-Ing. Dieter Jurzitza
> Manager Hardware Systems
>    System Development
>=20
> Industriegebiet Ittersbach
> Becker-G=F6ring Str. 16
> D-76307 Karlsbad / Germany
>=20
> Phone: +49 (0)7248 71-1577
> Fax:   +49 (0)7248 71-1216
> eMail: DJurzitza@harmanbecker.com
> Internet: http://www.becker.de
> =20
>=20
> > -----Urspr=FCngliche Nachricht-----
> > Von: linux-kernel-owner@vger.kernel.org
> > [mailto:linux-kernel-owner@vger.kernel.org] Im Auftrag von=20
> > Jurzitza, Dieter
> > Gesendet: Dienstag, 29. August 2006 06:52
> > An: linux-kernel@vger.kernel.org
> > Betreff: [PATCH] sun disk label: fix signed int usage for=20
> sector count
> >=20
> >=20
> > Dear listmembers,
> > citing Jeff Mahoney:
> >=20
> > > I'm not sure how many people out there are using Sun disk
> > labels with
> > > sizes > 1TB. It seems like a pretty rare corner case, but
> > there's no
> > > reason any data stored in those partitions wouldn't be
> > invalid, and it
> > > will suddenly cut them off. Is this a rare enough
> > occurrence that we
> > > don't care?
> >=20
> > I am one of those guys using Sun disklabels with sizes > 1TB.
> > And I would highly appreciate if nobody out there would make=20
> > my disk drive useless by simply discarding anything larger=20
> > than 1 TB. This would render our department server useless,=20
> > what is everything but desirable :-)
> >=20
> > Fdisk says:
> >=20
> > Kommando (m f=FCr Hilfe):
> > Disk /dev/sda (Sun disk label): 1024 heads, 63 sectors, 36187=20
> > cylinders Units =3D Zylinder of 64512 * 512 bytes
> >=20
> >     Ger=E4t Flag    Start       End    Blocks   Id  System
> > /dev/sda1             0         1     32256   83  Linux native
> > /dev/sda2  u          1        64   2032128   82  Linux Swap
> > /dev/sda3             0     36187 -980235776    5  Whole disk
> > /dev/sda4            64       320   8257536    1  Boot
> > /dev/sda5           320      4864 146571264   83  Linux native
> > /dev/sda6          4864     16384 371589120   83  Linux native
> > /dev/sda7         16384     36187 638765568   83  Linux native
> >=20
> > Kommando (m f=FCr Hilfe):
> >=20
> > cat /proc/partitions says:
> > /home/fred> cat /proc/partitions
> > major minor  #blocks  name
> >=20
> >    8     0 1171874880 sda
> >    8     1      32256 sda1
> >    8     2    2032128 sda2
> >    8     3 -980235776 sda3
> >    8     4    8257536 sda4
> >    8     5  146571264 sda5
> >    8     6  371589120 sda6
> >    8     7  638765568 sda7
> >=20
> > but do not leave sda3 useless by changing the code. If there
> > would be a chance to make fdisk and /proc/partitions not to=20
> > display negative numbers (since, though obvious, they are=20
> > nonsense) it would be preferrable.
> >=20
> > Many thanks for your help,
> > take care
> >=20
> >=20
> > Dieter Jurzitza
> >=20
> > --
> > ________________________________________________
> >=20
> > HARMAN BECKER AUTOMOTIVE SYSTEMS
> >=20
> > Dr.-Ing. Dieter Jurzitza
> > Manager Hardware Systems
> >    System Development
> >=20
> > Industriegebiet Ittersbach
> > Becker-G=F6ring Str. 16
> > D-76307 Karlsbad / Germany
> >=20
> > Phone: +49 (0)7248 71-1577
> > Fax:   +49 (0)7248 71-1216
> > eMail: DJurzitza@harmanbecker.com
> > Internet: http://www.becker.de
> > =20
> >=20
> >=20
> > *******************************************
> > Diese E-Mail enthaelt vertrauliche und/oder rechtlich
> > geschuetzte Informationen. Wenn Sie nicht der richtige=20
> > Adressat sind oder diese E-Mail irrtuemlich erhalten haben,=20
> > informieren Sie bitte sofort den Absender und loeschen Sie=20
> > diese Mail. Das unerlaubte Kopieren sowie die unbefugte=20
> > Weitergabe dieser Mail ist nicht gestattet.
> > =20
> > This e-mail may contain confidential and/or privileged
> > information. If you are not the intended recipient (or have=20
> > received this e-mail in error) please notify the sender=20
> > immediately and delete this e-mail. Any unauthorized copying,=20
> > disclosure or distribution of the contents in this e-mail is=20
> > strictly forbidden.
> > *******************************************
> >=20
> > -
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-kernel" in the body of a message to=20
> > majordomo@vger.kernel.org More majordomo info at =20
> > http://vger.kernel.org/majordomo-> info.html
> > Please read the=20
> > FAQ at  http://www.tux.org/lkml/
> >=20
> -
> To unsubscribe from this list: send the line "unsubscribe=20
> linux-kernel" in the body of a message to=20
> majordomo@vger.kernel.org More majordomo info at =20
> http://vger.kernel.org/majordomo-> info.html
> Please read the=20
> FAQ at  http://www.tux.org/lkml/
>=20
