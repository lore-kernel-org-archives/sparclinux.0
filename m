From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
Date: Mon, 16 Apr 2007 05:10:44 +0000
Subject: AW: /proc/interrupts and timer
Message-Id: <DA6197CAE190A847B662079EF7631C0604749E5D@OEKAW2EXVS03.hbi.ad.harman.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0704141317001.13883@math>
In-Reply-To: <Pine.SOC.4.64.0704141317001.13883@math>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Dear Mr. Miller,
dear listmembers,
ok ok, 2.4 is not that interesting any more - but would you kindly consider=
 something for 2.4 too in case you touch 2.6 in this regard?

  0:  181134480          0  timer:dead

on 2.4 doesn't look ok, either.

But, nothing really serious, just in case you'd find the time.

Thank you very much,
take care



Dieter Jurzitza


-----Urspr=FCngliche Nachricht-----
Von:	sparclinux-owner@vger.kernel.org im Auftrag von David Miller
Gesendet:	Sa 14.04.2007 19:00
*****
Yeah, there is no interrupt controller driving the timer
interrupt so there is no "struct irq_chip" hung off of
it.  I could put some dummy entry there to make the
"<NULL>" read something more pleasant :-)
******=20
=20
*******************************************
Harman Becker Automotive Systems GmbH
Geschaeftsfuehrung:  Dr. Peter Geiselhart  -  Michael Mauser  -  William S.=
 Palin -  Edwin Summers  -  Regis Baudot
Sitz der Gesellschaft: Karlsbad - Registergericht: Mannheim HRB 361395
=20
*******************************************
Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte Informati=
onen. Wenn Sie nicht der richtige Adressat sind oder diese E-Mail irrtuemli=
ch erhalten haben, informieren Sie bitte sofort den Absender und loeschen S=
ie diese Mail. Das unerlaubte Kopieren sowie die unbefugte Weitergabe diese=
r Mail ist nicht gestattet.
This e-mail may contain confidential and/or privileged information. If you =
are not the intended recipient (or have received this e-mail in error) plea=
se notify the sender immediately and delete this e-mail. Any unauthorized c=
opying, disclosure or distribution of the contents in this e-mail is strict=
ly forbidden.
*******************************************
