From: Robert Reif <reif@earthlink.net>
Date: Mon, 01 Sep 2008 13:27:14 +0000
Subject: tty compile warnings
Message-Id: <48BBEDB2.3080207@earthlink.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

I have been getting these compile warnings on sparc32 for a few weeks now:

CC drivers/char/n_tty.o
drivers/char/n_tty.c: In function =91normal_poll=92:
drivers/char/n_tty.c:1555: warning: array subscript is above array bounds
drivers/char/n_tty.c:1564: warning: array subscript is above array bounds
drivers/char/n_tty.c: In function =91read_chan=92:
drivers/char/n_tty.c:1269: warning: array subscript is above array bounds
CC drivers/char/tty_ioctl.o
drivers/char/tty_ioctl.c: In function =91set_termios=92:
drivers/char/tty_ioctl.c:533: warning: array subscript is above array bounds
drivers/char/tty_ioctl.c:537: warning: array subscript is above array bounds
drivers/char/tty_ioctl.c: In function =91tty_mode_ioctl=92:
drivers/char/tty_ioctl.c:662: warning: array subscript is above array bounds
drivers/char/tty_ioctl.c:892: warning: array subscript is above array bounds
drivers/char/tty_ioctl.c:896: warning: array subscript is above array bounds
drivers/char/tty_ioctl.c:577: warning: array subscript is above array bounds
drivers/char/tty_ioctl.c:928: warning: array subscript is above array bounds
drivers/char/tty_ioctl.c:934: warning: array subscript is above array bounds

