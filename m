From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
Date: Fri, 25 Aug 2006 14:40:41 +0000
Subject: two bugletts on sparc - Dave Miller is always right, isn't he? :-)))
Message-Id: <DA6197CAE190A847B662079EF7631C060156929E@OEKAW2EXVS03.hbi.ad.harman.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

Dear listmembers,
thanks to the inputs to David Miller there is a fix for the kmalloc issue w=
ith sys32_get_kernel_syms() in linux/arch/sparc64/kernel/sys_sparc32.c, pre=
venting the kernel from reading the entire symbol table due to a memory lim=
itation.

Rather than my initial suggestion to change the unsigned long to an unsigne=
d int in struct kernel_syms, the kmalloc() should be changed into a vmalloc=
() giving significant improvement with regard to the max amount of symbols =
that can be read. So, I would suggest (tested on my U60) to integrate the f=
ollowing patch into the kernel 2.4-tree (cannot tell about 2.6). I would ex=
pect similar issues on other 32/64 arches, but cannot test. x86_64 contains=
 the very same function with the very same call in linux/arc/x86_64/kernel/=
ia32/sys_ia32.c.

The number of symbols that can be read by sys32_get_kernel_syms is limited =
to 2048 at max, what is not enough IMHO. Dave Miller suggested to replace t=
he kmalloc() by a vmalloc(), this should be uncritical here as I do not thi=
nk the delay is of significance. This increases the memsize-limit from 2^17=
 i. e. 128k to several MByte, what should be sufficient.

Successfully tested here (kernel 2.4.33):

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


Thanks to Dave Miller once again,
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

