From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
Date: Tue, 27 Sep 2005 05:35:11 +0000
Subject: Patch for kernel 2.4
Message-Id: <DA6197CAE190A847B662079EF7631C06010B3554@OEKAW2EXVS03.hbi.ad.harman.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C5C325.3AD9BAEC"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5C325.3AD9BAEC
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Dear listmembers,
I attached a patch that allows for kernel 2.4 to read more kernel symbols w=
ithout doing any (for me) apparent harm to anything. The only thing to disc=
uss is the define __ARCH_SPARC64_ATOMIC__ in use to determine whether to us=
e the unsigned long or not.
The reason for this comes from the fact that the size of the struct kernel_=
syms is 72 byte on sparc64 in contrast to 64 byte on any 32 bit architectur=
e what reduces the number of kernel symbols that can be stored by 64/72. Re=
gular 32-bit kernels allow 2048 kernel symbols to be read before kmalloc() =
hits it's allocation limit; on sparc64 this is reduced to 1820 kernel symbo=
ls - using the unsigned long that is used currently.
This is a poor limitation anyway and I know that this is not used any more =
in 2.6 kernels - but based on this patch the restriction for 32 and 64 bit =
systems is at least identical.

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


------_=_NextPart_001_01C5C325.3AD9BAEC
Content-Type: application/octet-stream; name="linux-2.4.31-module.h.patch"
Content-Transfer-Encoding: base64
Content-Description: linux-2.4.31-module.h.patch
Content-Disposition: attachment; filename="linux-2.4.31-module.h.patch"

LS0tIGxpbnV4L2luY2x1ZGUvbGludXgvbW9kdWxlLmgJMjAwNC0xMi0xNSAwODozNDo0NC4wMDAw
MDAwMDAgKzAxMDAKKysrIGxpbnV4L2luY2x1ZGUvbGludXgvbW9kdWxlLmgJMjAwNC0xMi0xNSAw
ODo0NTozMi4wMDAwMDAwMDAgKzAxMDAKQEAgLTMxLDcgKzMxLDExIEBACiAvKiBVc2VkIGJ5IGdl
dF9rZXJuZWxfc3ltcywgd2hpY2ggaXMgb2Jzb2xldGUuICAqLwogc3RydWN0IGtlcm5lbF9zeW0K
IHsKLQl1bnNpZ25lZCBsb25nIHZhbHVlOworI2lmZGVmIF9fQVJDSF9TUEFSQzY0X0FUT01JQ19f
CisJICB1bnNpZ25lZCBpbnQgdmFsdWU7CisjZWxzZQorICAgICAgICAgIHVuc2lnbmVkIGxvbmcg
dmFsdWU7CisjZW5kaWYKIAljaGFyIG5hbWVbNjBdOwkJLyogc2hvdWxkIGhhdmUgYmVlbiA2NC1z
aXplb2YobG9uZyk7IG9oIHdlbGwgKi8KIH07CiAK

------_=_NextPart_001_01C5C325.3AD9BAEC--
