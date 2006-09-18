From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
Date: Mon, 18 Sep 2006 05:23:58 +0000
Subject: Patch 2.4 kernel / allow to read more than 2048 (1821) Symbols from
Message-Id: <DA6197CAE190A847B662079EF7631C06015692C9@OEKAW2EXVS03.hbi.ad.harman.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Cc: Willy Tarreau <w@1wt.eu>

Problem:
The 2.4 kernel series uses sys32_get_kernel_syms(struct kernel_sym32 *table=
) for reading the kernel symbols (on sparc64). The size of struct kernel_sy=
m is 64 byte on "normal" arches, but 72 byte on sparc64.
The memory for the table holding all the structs is currently kmalloc'd, gi=
ving a limitation of 2048*sizeof(struct kernel_sym) for "normal" and 1820*s=
izeof(struct kernel_sym) for "sparc64" arches, the latter being caused by d=
ifferent sizes of unsigned longs and the need for alingnment bytes. This ca=
uses an "error reading System.map" message for no reason.

Solution (significantly helped by Dave Miller):
replace kmalloc() by vmalloc() to circumvent the size limit of 2^17 for kma=
lloc.

Other arches:
ppc64 defines value in struct kernel_sym as u32 in contrast to sparc, so we=
 have the 2048 units limit here, but this would profit from using vmalloc()=
, too, since the limitation to 2048 is neither helpful nor neccessary. I la=
ck sufficient understanding of the details to predict the impact on other a=
rches. This patch refers to sparc64 but someone with deeper insight might w=
ant to look into this for other arches, too.

Signed off by: Dieter Jurzitza <DJurzitza@HarmanBecker.com>

--- linux/arch/sparc64/kernel/sys_sparc32.c     2006-08-11 06:18:20.0000000=
00 +
+++ linux/arch/sparc64/kernel/sys_sparc32.c     2006-08-25 12:37:42.0000000=
00 +
@@ -3730,7 +3730,7 @@
       =20
        len =3D sys_get_kernel_syms(NULL);
        if (!table) return len;
-       tbl =3D kmalloc (len * sizeof (struct kernel_sym), GFP_KERNEL);
+       tbl =3D vmalloc (len * sizeof (struct kernel_sym));
        if (!tbl) return -ENOMEM;
        old_fs =3D get_fs();=20
        set_fs (KERNEL_DS);
@@ -3741,7 +3741,7 @@
                    copy_to_user (table->name, tbl[i].name, 60))
                        break;
        }
-       kfree (tbl);
+       vfree (tbl);
        return i;
 }

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

