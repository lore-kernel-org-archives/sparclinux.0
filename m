From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
Date: Fri, 09 Jan 2004 10:27:51 +0000
Subject: Bootproblem with CD
Message-Id: <1F6206BC53BCD3119059009027D1D3A20CC6AF42@OEKAEX01.becker.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Dear Listmembers,
currently I do a lot of testing with the new 2.4.23 kernel. About a year ago
I posted into this list that I get an error message when booting saying:
****
Inspecting /boot/System.map
Loaded 13363 symbols from /boot/System.map
Symbols match kernel version 2.4.2X
Error reading kernel symbols - Cannot allocate memory
****
this error is still persistent and is due to the fact that I boot using an
initrd from a CD (what I have to do because the HDD is connected to a
aha29160 controler who is not detected prior to loading the appropriate
module from somewhere) The error happens when the mapfile is accessed the
*second* time and data are taken from the HDD, not from the CDROM any more
(since there are only a few modules that have to be loaded at the very
begin)

If anybody of you guru's would find the time to test this on your own - I
cannot figure out what is going wrong. If I boot *this* kernel using *this*
System.map and *this* initrd from an harddisk attached to the symbios logic
controler, everything is fine. No error, no allocation issue.

I did a:

mkisofs -silo-boot /boot/second.b -s /boot/silo.conf -o /home/image.iso -R
/var/adm/bootCD

and burned the result using xcdroast.

Using this initrd from the harddisk directly does not end up in such errors.

Therefore there must be something wrong with the initrd (??) or whatsoever.
I have no clue, maybe you do.
Many thanks for your efforts in advance,
take care


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
se notify the sender immediately and delete this e-mail. Any unauthorised c=
opying, disclosure or distribution of the contents in this e-mail is strict=
ly forbidden.
*******************************************

