From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
Date: Thu, 22 Jul 2004 07:03:32 +0000
Subject: Solution for an old problem
Message-Id: <CFE6A2529AC5FA439B3D852B0F2A6837DAAFEB@OEKAW2EXVS02.hbi.ad.harman.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Dear listmembers,
I would like to inform you that you should not use the old SuSE 7.3 64-Bit =
kernel compiler on Ultra 64 / SMP-systems any more (I cannot distinguish th=
e root cause).

Using the same source tree and the same .config file when building the kern=
el on a Debian Sarge results in a rock solid operation (booting from CD, ru=
ntime SuSE).

The same based on the SuSE-gcc (egcs-2.92.11) results in undeterministic sy=
stem crashes. This was why I asked for help every other time on different l=
ists.

The 32-Bit application world appears to be ok, as seems the 2.95 32-Bit com=
piler.

This is tested on two U60 only and the problems show with higher net load (=
we have more than 50 clients attached) when copying huge amounts of data ov=
er the network.

Yust for your information. It seems to be time to upgrade.

Take care



Dieter Jurzitza



--=20
________________________________________________

HARMAN BECKER AUTOMOTIVE SYSTEMS

Dr.-Ing. Dieter Jurzitza
Manager Hardware Systems
         ESI

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

