From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 21 Nov 2016 12:19:31 +0000
Subject: [PATCH] USB: serial: cp210x: Use tcflag_t to fix incompatible pointer type
Message-Id: <1479730771-17759-1-git-send-email-geert@linux-m68k.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

On sparc32, tcflag_t is unsigned long, unlike all other architectures:

    drivers/usb/serial/cp210x.c: In function 'cp210x_get_termios':
    drivers/usb/serial/cp210x.c:717:3: warning: passing argument 2 of 'cp210x_get_termios_port' from incompatible pointer type
       cp210x_get_termios_port(tty->driver_data,
       ^
    drivers/usb/serial/cp210x.c:35:13: note: expected 'unsigned int *' but argument is of type 'tcflag_t *'
     static void cp210x_get_termios_port(struct usb_serial_port *port,
		 ^

Consistently use tcflag_t to fix this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/usb/serial/cp210x.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index f61477bed3a8d3b1..e138decfc844dff8 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -33,7 +33,7 @@
 static void cp210x_close(struct usb_serial_port *);
 static void cp210x_get_termios(struct tty_struct *, struct usb_serial_port *);
 static void cp210x_get_termios_port(struct usb_serial_port *port,
-	unsigned int *cflagp, unsigned int *baudp);
+	tcflag_t *cflagp, unsigned int *baudp);
 static void cp210x_change_speed(struct tty_struct *, struct usb_serial_port *,
 							struct ktermios *);
 static void cp210x_set_termios(struct tty_struct *, struct usb_serial_port *,
@@ -718,7 +718,7 @@ static void cp210x_get_termios(struct tty_struct *tty,
 			&tty->termios.c_cflag, &baud);
 		tty_encode_baud_rate(tty, baud, baud);
 	} else {
-		unsigned int cflag;
+		tcflag_t cflag;
 		cflag = 0;
 		cp210x_get_termios_port(port, &cflag, &baud);
 	}
@@ -729,10 +729,10 @@ static void cp210x_get_termios(struct tty_struct *tty,
  * This is the heart of cp210x_get_termios which always uses a &usb_serial_port.
  */
 static void cp210x_get_termios_port(struct usb_serial_port *port,
-	unsigned int *cflagp, unsigned int *baudp)
+	tcflag_t *cflagp, unsigned int *baudp)
 {
 	struct device *dev = &port->dev;
-	unsigned int cflag;
+	tcflag_t cflag;
 	struct cp210x_flow_ctl flow_ctl;
 	u32 baud;
 	u16 bits;
-- 
1.9.1

