From: Robert Reif <reif@earthlink.net>
Date: Thu, 06 Nov 2008 11:52:03 +0000
Subject: Re: tty warning
Message-Id: <4912DA63.6050909@earthlink.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081106152421.a9cf964f.sfr@canb.auug.org.au>
In-Reply-To: <20081106152421.a9cf964f.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@davemloft.net>, LKML <linux-kernel@vger.kernel.org>, "William L. Irwin" <wli@holomorphy.com>, sparclinux@vger.kernel.org

Stephen Rothwell wrote:
> Hi Alan,
>
> A sparc allmodconfig build gives these warnings:
>
> drivers/char/n_tty.c: In function 'n_tty_poll':
> drivers/char/n_tty.c:1592: warning: array subscript is above array bounds
> drivers/char/n_tty.c:1601: warning: array subscript is above array bounds
> drivers/char/n_tty.c: In function 'n_tty_read':
> drivers/char/n_tty.c:1306: warning: array subscript is above array bounds
> drivers/char/tty_ioctl.c: In function 'set_termios':
> drivers/char/tty_ioctl.c:574: warning: array subscript is above array bounds
> drivers/char/tty_ioctl.c:578: warning: array subscript is above array bounds
> drivers/char/tty_ioctl.c: In function 'tty_mode_ioctl':
> drivers/char/tty_ioctl.c:729: warning: array subscript is above array bounds
> drivers/char/tty_ioctl.c:963: warning: array subscript is above array bounds
> drivers/char/tty_ioctl.c:969: warning: array subscript is above array bounds
> drivers/char/tty_ioctl.c:618: warning: array subscript is above array bounds
> drivers/char/tty_ioctl.c:1007: warning: array subscript is above array bounds
> drivers/char/tty_ioctl.c:1015: warning: array subscript is above array bounds
>
> These are things like:
>
>                 termios->c_cc[VTIME] = 0;
>
> termios is a (struct ktermios *) which has "cc_t c_cc[NCCS];".  NCCS is
> 17 and VTIME is also 17.  I assume the intention is to actually fill in
> _x_cc[0], but why is it done this way and not more directly?
>
>   
There is a patch here that fixes it:  
http://marc.info/?l=linux-sparc&m2048348932653&w=2
