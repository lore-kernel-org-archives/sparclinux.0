From: David Dillow <dave@thedillows.org>
Date: Sun, 04 Jan 2004 06:38:07 +0000
Subject: [PATCH] Re: Oops on 2.6.1-rc1 serial access
Message-Id: <1073198287.3960.38.camel@ori.thedillows.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-ruPz4fF0ChP2kc2FGPZQ"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-ruPz4fF0ChP2kc2FGPZQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2004-01-03 at 22:07, David Dillow wrote:
> The oops occurs when running the command without arguments, which causes
> it to scan for available ports. According to the attached strace output,
> it dies opening ttyS2 -- both ttyS0 & ttyS1 are ok.

Sunzilog was telling the serial core that we were going to register 4
ports, but then only registered 2. Serial core was calling uart_close()
on ports that had never been set up (ttyS2 & ttyS3), therefore the
illegal access.

The attached patch teaches Sunzilog to not count ports attached to a
keyboard or mouse when registering with serial_core. With this patch, I
no longer get an oops when opening the problem ports.

There's probably a simpler way (like, oh, subtracting 2 from
NUM_CHANNELS), but this way doesn't care how many keyboard/mice ports
are there, as long as they are marked.

Dave

--=-ruPz4fF0ChP2kc2FGPZQ
Content-Disposition: attachment; filename=sunzilog.patch
Content-Type: text/plain; name=sunzilog.patch; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

--- linux-2.6.1-rc1/drivers/serial/sunzilog.c.orig	2004-01-04 01:31:36.0000=
00000 -0500
+++ linux-2.6.1-rc1/drivers/serial/sunzilog.c	2004-01-04 01:32:19.000000000=
 -0500
@@ -1631,6 +1631,8 @@
 {
 	struct zs_probe_scan scan;
 	int ret;
+	int uart_count;
+	int i;
=20
 	printk(KERN_DEBUG "SunZilog: %d chips.\n", NUM_SUNZILOG);
=20
@@ -1650,18 +1652,27 @@
 	sunzilog_init_hw();
=20
 	/* We can only init this once we have probed the Zilogs
-	 * in the system.
+	 * in the system. Do not count channels assigned to keyboards
+	 * or mice when we are deciding how many ports to register.
 	 */
-	sunzilog_reg.nr =3D NUM_CHANNELS;
+	uart_count =3D 0;
+	for (i =3D 0; i < NUM_CHANNELS; i++) {
+		struct uart_sunzilog_port *up =3D &sunzilog_port_table[i];
+
+		if (ZS_IS_KEYB(up) || ZS_IS_MOUSE(up))
+			continue;
+
+		uart_count++;
+	}
+	=09
+	sunzilog_reg.nr =3D uart_count;
 	sunzilog_reg.cons =3D SUNZILOG_CONSOLE;
=20
 	sunzilog_reg.minor =3D sunserial_current_minor;
-	sunserial_current_minor +=3D NUM_CHANNELS;
+	sunserial_current_minor +=3D uart_count;
=20
 	ret =3D uart_register_driver(&sunzilog_reg);
 	if (ret =3D=3D 0) {
-		int i;
-
 		for (i =3D 0; i < NUM_CHANNELS; i++) {
 			struct uart_sunzilog_port *up =3D &sunzilog_port_table[i];
=20

--=-ruPz4fF0ChP2kc2FGPZQ--
