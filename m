From: Robert Reif <reif@earthlink.net>
Date: Wed, 03 Sep 2008 23:11:23 +0000
Subject: [PATCH] tty compile warnings
Message-Id: <48BF199B.1080006@earthlink.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020608030700020205080006"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------020608030700020205080006
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable

This patch fixes tty compile warnings as sugested by Alan Cox:

CC drivers/char/n_tty.o
drivers/char/n_tty.c: In function =91normal_poll=92:
drivers/char/n_tty.c:1555: warning: array subscript is above array bounds
drivers/char/n_tty.c:1564: warning: array subscript is above array bounds
drivers/char/n_tty.c: In function =91read_chan=92:
drivers/char/n_tty.c:1269: warning: array subscript is above array bounds
CC drivers/char/tty_ioctl.o
drivers/char/tty_ioctl.c: In function =91set_termios=92:
drivers/char/tty_ioctl.c:533: warning: array subscript is above array=20
bounds
drivers/char/tty_ioctl.c:537: warning: array subscript is above array=20
bounds
drivers/char/tty_ioctl.c: In function =91tty_mode_ioctl=92:
drivers/char/tty_ioctl.c:662: warning: array subscript is above array=20
bounds
drivers/char/tty_ioctl.c:892: warning: array subscript is above array=20
bounds
drivers/char/tty_ioctl.c:896: warning: array subscript is above array=20
bounds
drivers/char/tty_ioctl.c:577: warning: array subscript is above array=20
bounds
drivers/char/tty_ioctl.c:928: warning: array subscript is above array=20
bounds
drivers/char/tty_ioctl.c:934: warning: array subscript is above array=20
bounds

Signed-off-by: Robert Reif <reif@earthlink.net>

--------------020608030700020205080006
Content-Type: text/plain;
 name="tty.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tty.diff.txt"

diff --git a/arch/sparc/include/asm/termbits.h b/arch/sparc/include/asm/termbits.h
index d6ca3e2..c154288 100644
--- a/arch/sparc/include/asm/termbits.h
+++ b/arch/sparc/include/asm/termbits.h
@@ -29,10 +29,11 @@ struct termios {
 	tcflag_t c_cflag;		/* control mode flags */
 	tcflag_t c_lflag;		/* local mode flags */
 	cc_t c_line;			/* line discipline */
+#ifndef __KERNEL__
 	cc_t c_cc[NCCS];		/* control characters */
-#ifdef __KERNEL__
+#else
+	cc_t c_cc[NCCS+2];	/* kernel needs 2 more to hold vmin/vtime */
 #define SIZEOF_USER_TERMIOS sizeof (struct termios) - (2*sizeof (cc_t))
-	cc_t _x_cc[2];                  /* We need them to hold vmin/vtime */
 #endif
 };
 
@@ -42,8 +43,7 @@ struct termios2 {
 	tcflag_t c_cflag;		/* control mode flags */
 	tcflag_t c_lflag;		/* local mode flags */
 	cc_t c_line;			/* line discipline */
-	cc_t c_cc[NCCS];		/* control characters */
-	cc_t _x_cc[2];                  /* padding to match ktermios */
+	cc_t c_cc[NCCS+2];		/* control characters */
 	speed_t c_ispeed;		/* input speed */
 	speed_t c_ospeed;		/* output speed */
 };
@@ -54,8 +54,7 @@ struct ktermios {
 	tcflag_t c_cflag;		/* control mode flags */
 	tcflag_t c_lflag;		/* local mode flags */
 	cc_t c_line;			/* line discipline */
-	cc_t c_cc[NCCS];		/* control characters */
-	cc_t _x_cc[2];                  /* We need them to hold vmin/vtime */
+	cc_t c_cc[NCCS+2];		/* control characters */
 	speed_t c_ispeed;		/* input speed */
 	speed_t c_ospeed;		/* output speed */
 };

--------------020608030700020205080006--
