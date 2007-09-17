From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
Date: Mon, 17 Sep 2007 05:16:30 +0000
Subject: AW: netconsole support for kernel 2.4 / sunhme patch / update
Message-Id: <DA6197CAE190A847B662079EF7631C0604749F65@OEKAW2EXVS03.hbi.ad.harman.com>
List-Id: <sparclinux.vger.kernel.org>
References: <DA6197CAE190A847B662079EF7631C0602E1C431@OEKAW2EXVS03.hbi.ad.harman.com>
In-Reply-To: <DA6197CAE190A847B662079EF7631C0602E1C431@OEKAW2EXVS03.hbi.ad.harman.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Dear listmembers,
having the below mentioned issue fixed (copied from the bogus file) netcons=
ole is working (for me ...). However, I get some stray characters in front =
of the strings being transmitted - but this is less of an issue compared wi=
th the chance to debug via netconsole.
So, does anyone see a sense in providing the (corrected ...) patch for the =
sunhme driver to the kernel mailing list?
Thanks,
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

Phone:  +49 (0)7248 71-1577
Mobile: +49 0151 - 16 339 017
Fax:    +49 (0)7248 71-1216
eMail:  DJurzitza@harmanbecker.com
Internet: http://www.becker.de
=20

> -----Urspr=FCngliche Nachricht-----
> Von: David Miller [mailto:davem@davemloft.net]=20
> Gesendet: Freitag, 14. September 2007 19:22
> An: Jurzitza, Dieter
> Cc: sparclinux@vger.kernel.org
> Betreff: Re: netconsole support for kernel 2.4 / sunhme patch
>=20
>=20
> From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
> Date: Fri, 14 Sep 2007 08:25:45 +0200
>=20
> > +static void poll_happy_meal (struct net_device *dev)
> > +{
> > +       disable_irq(dev->irq);
> > +       sis900_interrupt (dev->irq, dev, NULL);
> > +       enable_irq(dev->irq);
> > +}
> > +#endif
>=20
> You obviously did not even try to use this, as you're calling=20
> the interrupt handler for another driver.
>=20
> This is what happens when you mindlessly cut and paste.
>=20
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
