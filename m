From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
Date: Mon, 14 Aug 2006 10:03:33 +0000
Subject: latest 2.4.33 kernel
Message-Id: <DA6197CAE190A847B662079EF7631C0601569276@OEKAW2EXVS03.hbi.ad.harman.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Dear listmembers,
the latest smbfs.o module in 2.4.33 makes headache on sparc. The reason for=
 this is the fact, that a new patch had been introduced into dir.c that is =
based on memchr().

Unfortunately memchr() is not defined in asm-sparcXX/string.h; therefore de=
pmod fails for smbfs.o and smbfs.o remains unusable if i am right.

Any suggestions? I was thinking of replacing memchr () by memscan (), howev=
er, memscan () gives a different result, so could someone tell me whether r=
eplacing

        /* Do not allow lookup of names with backslashes in */
        error =3D -EINVAL;
        if (memchr(dentry->d_name.name, '\\', dentry->d_name.len))
                goto out;


by=20

        /* Do not allow lookup of names with backslashes in */
        error =3D -EINVAL;
        if ( dentry->d_name.name =3D ((memscan(dentry->d_name.name, '\\', d=
entry->d_name.len))-dentry->d_name.len) )
                goto out; =20

would be ok?

Thank you for helping out,
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

