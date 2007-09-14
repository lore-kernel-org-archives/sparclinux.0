From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
Date: Fri, 14 Sep 2007 06:25:45 +0000
Subject: netconsole support for kernel 2.4 / sunhme patch
Message-Id: <DA6197CAE190A847B662079EF7631C0602E1C431@OEKAW2EXVS03.hbi.ad.harman.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Dear listmembers,
could some kind soul tell me whether the following patch is too naive in or=
der to try to add netconsole support to the sunhme - module?
Many thanks in advance,
take care



Dieter Jurzitza

--- linux/drivers/net/sunhme.c.original 2007-09-14 07:45:24.000000000 +0200
+++ linux/drivers/net/sunhme.c  2007-09-14 08:14:39.000000000 +0200
@@ -79,6 +79,7 @@
 MODULE_LICENSE("GPL");
=20
 static struct happy_meal *root_happy_dev;
+static void poll_happy_meal(struct net_device *dev);
=20
 #ifdef CONFIG_SBUS
 static struct quattro *qfe_sbus_list;
@@ -3140,6 +3141,9 @@
        dev->set_multicast_list =3D &happy_meal_set_multicast;
        dev->tx_timeout =3D &happy_meal_tx_timeout;
        dev->watchdog_timeo =3D 5*HZ;
+#ifdef HAVE_POLL_CONTROLLER
+        dev->poll_controller =3D &poll_happy_meal;
+#endif=20
        dev->do_ioctl =3D &happy_meal_ioctl;
        dev->irq =3D pdev->irq;
        dev->dma =3D 0;
@@ -3300,6 +3304,20 @@
        return 0;
 }
 =20
+#ifdef HAVE_POLL_CONTROLLER
+/*
+ * Polling 'interrupt' - used by things like netconsole to send skbs
+ * without having to re-enable interrupts. It's not called while
+ * the interrupt routine is executing.
+ */
+  =20
+static void poll_happy_meal (struct net_device *dev)
+{
+       disable_irq(dev->irq);
+       sis900_interrupt (dev->irq, dev, NULL);
+       enable_irq(dev->irq);
+}
+#endif
=20
 static void __exit happy_meal_cleanup_module(void)
 {


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
