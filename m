From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
Date: Wed, 15 Dec 2004 11:52:25 +0000
Subject: U60  / get_kernel_syms issue on 64 Bit systems
Message-Id: <CFE6A2529AC5FA439B3D852B0F2A683701E136D0@OEKAW2EXVS02.hbi.ad.harman.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Dear listmembers,
I found the root cause for the problem reading the symbol table, I have a p=
atch for the kernel and I would appreciate your comments.
Sparc 64 uses a wrapper for get_symbol_table that in fact uses a 64 Bit ker=
nel call to perform the action. In the 32Bit world the structure kernel_sym=
 consists of an unsigned long (4Byte) and a char - array (60Byte) summing u=
p to 64 Byte total size.
When wrapping this call to the 64Bit kernel the size of the struct grows tw=
ice: first of all our unsigned long turns into 8 Byte, then things have to =
be word aligned. So the struct grows up to 72Byte in total.
This is where trouble begins. The kmalloc() call in use here is capable to =
allocate not more than 131048Byte, this boundary is hit here.
Erraneously I had thought this was related to SMP - it isnt. Accidentally t=
he map-size was a little smaller for the non - SMP kernel thereby fitting i=
nto the available memory.
What I suggest now (as a first step) is to modify in linux/include/linux/mo=
dule.h:

struct kernel_sym
{
#ifdef __ARCH_SPARC64_ATOMIC__  =20
          unsigned int value;
#else
          unsigned long value;
#endif
        char name[60];          /* should have been 64-sizeof(long); oh wel=
l */
};

Thereby the size of kernel_sym remains 64Byte and we do not need 4 addition=
al alignment Byte to make things work again. So the limitation is pushed up=
wards from 1820 symbols (now) up to 2047 symbols (see above).
I honestly see no real reason for using a unsigned long here since it is al=
most always 4 Byte long - except on 64 Bit architectures. Moreover that it =
will take a little more time until we actually need more than 32 Bit for th=
e description of kernel adresses (if I am guessing right that would the ker=
nel to grow over the 4GByte boundary).
I am 100% sure that the kernel junkees know a better switch than __ARCH_SPA=
RC64_ATOMIC__ what I took from atomic.h knowing the latter being included i=
nto module.h.

So, who would be the right person to address this to? As I initially assume=
d, this is not a klogd issue - apart from the fact that klogd relies on get=
_kernel_symbols.
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

