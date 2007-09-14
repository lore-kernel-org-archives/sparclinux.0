From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
Date: Fri, 14 Sep 2007 06:40:27 +0000
Subject: AW: netconsole support for kernel 2.4 / sunhme patch
Message-Id: <DA6197CAE190A847B662079EF7631C0602E1C433@OEKAW2EXVS03.hbi.ad.harman.com>
List-Id: <sparclinux.vger.kernel.org>
References: <DA6197CAE190A847B662079EF7631C0602E1C431@OEKAW2EXVS03.hbi.ad.harman.com>
In-Reply-To: <DA6197CAE190A847B662079EF7631C0602E1C431@OEKAW2EXVS03.hbi.ad.harman.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Dear listmembers,
and, naturally, it should to be
> +       happy_meal_interrupt (dev->irq, dev, NULL);
> +       enable_irq(dev->irq);
> +}
> +#endif
instead of sis900_interrupt (dev->irq, dev NULL);

Thanks & take care




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

Phone:  +49 (0)7248 71-1577
Mobile: +49 0151 - 16 339 017
Fax:    +49 (0)7248 71-1216
eMail:  DJurzitza@harmanbecker.com
Internet: http://www.becker.de=20
=20
*******************************************
Harman Becker Automotive Systems GmbH
Geschaeftsfuehrung:  Dr. Peter Geiselhart  -  Michael Mauser  -  Edwin Summ=
ers  -  Regis Baudot
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
