From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
Date: Fri, 22 Sep 2006 05:26:41 +0000
Subject: AW: Patch 2.4 kernel / allow to read more than 2048 (1821) Symbols
Message-Id: <DA6197CAE190A847B662079EF7631C06015692D5@OEKAW2EXVS03.hbi.ad.harman.com>
List-Id: <sparclinux.vger.kernel.org>
References: <DA6197CAE190A847B662079EF7631C06015692C9@OEKAW2EXVS03.hbi.ad.harman.com>
In-Reply-To: <DA6197CAE190A847B662079EF7631C06015692C9@OEKAW2EXVS03.hbi.ad.harman.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Dear Mr. Miller,
dear Willy,
just for my understanding: apart from the fact that the maximum allocated s=
izes differ for vmalloc() and kmalloc(), is it also true that a non privile=
dged user couldn't call get_kernel_syms () with the current kmalloc() solut=
ion?

Given this, wouldn't it be sufficient (for safety reasons) to include a dum=
my call to kmalloc and return with an error if a non privileged user does t=
he call?=20

I mean, elegance is something different :-), but this could catch such a pr=
oblem.

Just like:

char *for_safety_reasons;

for_safety_reasons=3Dkmalloc(1, GFP_KERNEL);

if (!for_safety_reasons) return -ENOMEM; (or what soever)

kfree (for_safety_reasons);

Or is (in this regard) the only difference between vmalloc() and kmalloc() =
the maximum size of allocable memory? Given this, the question reduces down=
 to whether a fork bomb on vmalloc() or a fork bomb on kmalloc() is worse.

My two cents here.

Take care & many thanks for looking into it,



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
> Von: David Miller [mailto:davem@davemloft.net]=20
> Gesendet: Freitag, 22. September 2006 00:56
> 2) I dislike this fix because it means that users can lock down
>    a significant amount of non-swappable kernel memory.  There are
>    no privilege checks in the get_kernel_syms() system call, so
>    anyone can invoke it.  Imagine a fork bomb invoking this, and it
>    could also potentially eat up nearly all of the vmalloc() space.
>=20
> It may be, in the end, simply better to have a=20
> "compat_sys_get_kernel_syms" written that can be called so a=20
*****


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

