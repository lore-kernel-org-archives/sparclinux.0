From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
Date: Tue, 29 Aug 2006 06:13:11 +0000
Subject: WG: [PATCH] sun disk label: fix signed int usage for sector count
Message-Id: <DA6197CAE190A847B662079EF7631C0602E1B81D@OEKAW2EXVS03.hbi.ad.harman.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Dear listmembers,
though I cannot remember the original message to have popped up in sparclin=
ux, I think this discussion would be worthwile placing in sparclinux, too, =
as it affects sparc systems only. The original posting went AFAIR to linux-=
kernel only.
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
> Gesendet: Dienstag, 29. August 2006 06:52
> An: linux-kernel@vger.kernel.org
> Betreff: [PATCH] sun disk label: fix signed int usage for sector count
>=20
>=20
> Dear listmembers,
> citing Jeff Mahoney:
>=20
> > I'm not sure how many people out there are using Sun disk=20
> labels with=20
> > sizes > 1TB. It seems like a pretty rare corner case, but=20
> there's no=20
> > reason any data stored in those partitions wouldn't be=20
> invalid, and it=20
> > will suddenly cut them off. Is this a rare enough=20
> occurrence that we=20
> > don't care?
>=20
> I am one of those guys using Sun disklabels with sizes > 1TB.=20
> And I would highly appreciate if nobody out there would make=20
> my disk drive useless by simply discarding anything larger=20
> than 1 TB. This would render our department server useless,=20
> what is everything but desirable :-)
>=20
> Fdisk says:
>=20
> Kommando (m f=FCr Hilfe):=20
> Disk /dev/sda (Sun disk label): 1024 heads, 63 sectors, 36187=20
> cylinders Units =3D Zylinder of 64512 * 512 bytes
>=20
>     Ger=E4t Flag    Start       End    Blocks   Id  System
> /dev/sda1             0         1     32256   83  Linux native
> /dev/sda2  u          1        64   2032128   82  Linux Swap
> /dev/sda3             0     36187 -980235776    5  Whole disk
> /dev/sda4            64       320   8257536    1  Boot
> /dev/sda5           320      4864 146571264   83  Linux native
> /dev/sda6          4864     16384 371589120   83  Linux native
> /dev/sda7         16384     36187 638765568   83  Linux native
>=20
> Kommando (m f=FCr Hilfe):=20
>=20
> cat /proc/partitions says:
> /home/fred> cat /proc/partitions=20
> major minor  #blocks  name
>=20
>    8     0 1171874880 sda
>    8     1      32256 sda1
>    8     2    2032128 sda2
>    8     3 -980235776 sda3
>    8     4    8257536 sda4
>    8     5  146571264 sda5
>    8     6  371589120 sda6
>    8     7  638765568 sda7
>=20
> but do not leave sda3 useless by changing the code. If there=20
> would be a chance to make fdisk and /proc/partitions not to=20
> display negative numbers (since, though obvious, they are=20
> nonsense) it would be preferrable.
>=20
> Many thanks for your help,
> take care
>=20
>=20
> Dieter Jurzitza
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
>=20
> *******************************************
> Diese E-Mail enthaelt vertrauliche und/oder rechtlich=20
> geschuetzte Informationen. Wenn Sie nicht der richtige=20
> Adressat sind oder diese E-Mail irrtuemlich erhalten haben,=20
> informieren Sie bitte sofort den Absender und loeschen Sie=20
> diese Mail. Das unerlaubte Kopieren sowie die unbefugte=20
> Weitergabe dieser Mail ist nicht gestattet.
> =20
> This e-mail may contain confidential and/or privileged=20
> information. If you are not the intended recipient (or have=20
> received this e-mail in error) please notify the sender=20
> immediately and delete this e-mail. Any unauthorized copying,=20
> disclosure or distribution of the contents in this e-mail is=20
> strictly forbidden.
> *******************************************
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe=20
> linux-kernel" in the body of a message to=20
> majordomo@vger.kernel.org More majordomo info at =20
> http://vger.kernel.org/majordomo-> info.html
> Please read the=20
> FAQ at  http://www.tux.org/lkml/
>=20
