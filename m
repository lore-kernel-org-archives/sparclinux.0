From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
Date: Fri, 25 Aug 2006 05:44:45 +0000
Subject: AW: Two bugletts on Sparc 64 @ kernel 2.4
Message-Id: <DA6197CAE190A847B662079EF7631C060156929B@OEKAW2EXVS03.hbi.ad.harman.com>
List-Id: <sparclinux.vger.kernel.org>
References: <DA6197CAE190A847B662079EF7631C0601569295@OEKAW2EXVS03.hbi.ad.harman.com>
In-Reply-To: <DA6197CAE190A847B662079EF7631C0601569295@OEKAW2EXVS03.hbi.ad.harman.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Dear listmembers,
dear Mr. Miller,
after the hint I parsed through klogd and through my old documentation and =
found the following:
the failing call is a kernel function, it is not klogd:

linux/arch/sparc64/kernel/sys32_kernel_syms(struct kernel_sym32 *table)

(line 3747 @ 2.4.33):
tbl=3Dkmalloc (len*sizeof (struct kernel_sym), GFP_KERNEL);

this function fails on sparc64 for module counts larger than 1820 given an =
unsigned long is used for "value" within struct kernel_sym; the reason for =
this has been explained. 72*1820 hits the border of 2^17 for kmalloc. I see=
 no way how klogd should change this behaviour (besides not using this func=
tion).

So, there is a small deficiency in this regard within the sparc64 kernel, a=
s the sparc64 kernel is capable of reading less many symbols of type kernel=
_sym than 32 Bit kernels on i686 for example. The very same function exists=
 in linux/arch/x86_64/ia32; so my guess would be that similar problems woul=
d show on x86 given a 32Bit userland and a 64Bit kernel. I haven't recogniz=
ed this on x86_64 until now, I would be very happy if someone could kindly =
give me an advice on how this is taken care of on such machines. klogd is a=
lways 1.4.1, this cannot be the place where the problem is taken care for.

Thanks for your efforts,
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

> -----Urspr=FCngliche Nachricht-----
> Von: David Miller [mailto:davem@davemloft.net]=20
> Gesendet: Mittwoch, 23. August 2006 07:26
> An: Jurzitza, Dieter
> Cc: linux-kernel-owner@vger.kernel.org; sparclinux@vger.kernel.org
> Betreff: Re: Two bugletts on Sparc 64 @ kernel 2.4
>=20
>=20
>=20
> The klogd program needs to be adjusted to determine the data=20
> type the kernel is using for module symbols, just like modutils does.
>=20
> What modutils does is it asks the system what type it is,=20
> 32-bit or 64-bit, by making a uname() call.
>=20
> Using this information, modutils will adjust the data types=20
> it uses internally, as appropriate.
>=20
> This handled properly a 32-bit binary running on a 64-bit kernel.
>=20
> So the kernel change you are proposing is not the correct fix=20
> for this problem.
>=20


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

