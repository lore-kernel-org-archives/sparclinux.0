From: Andrew Morton <akpm@linux-foundation.org>
Date: Sun, 16 Sep 2007 07:42:31 +0000
Subject: Re: SPARC{,64}: kernel_termios_to_user_termios_1 missing
Message-Id: <20070916004231.cf2df744.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200709152137.l8FLbtXP001446@laptop13.inf.utfsm.cl>
	<20070915.153602.74747413.davem@davemloft.net>
In-Reply-To: <20070915.153602.74747413.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: vonbrand@inf.utfsm.cl, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 15 Sep 2007 15:36:02 -0700 (PDT) David Miller <davem@davemloft.net> wrote:

> From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
> Date: Sat, 15 Sep 2007 17:37:55 -0400
> 
> > git-describe says this is v2.6.23-rc6-168-g53a3f30
> > I'm getting:
> > 
> >   drivers/char/tty_ioctl.c: In function 'n_tty_ioctl':
> >   drivers/char/tty_ioctl.c:799: error: implicit declaration of function 'kernel_termios_to_user_termios_1'
> > 
> > This is a macro at the very end of include/asm-<foo>/termios.h for i686, on
> > SPARC and SPARC64 it is missing. Sorry, I've got no clue on how to define
> > this correctly here.
> > 
> > It is also missing on alpha, blackfin, parisc, sh64, sh, xtensa
> 
> This has been reported and discussed extensively on the lists
> over the past 4 or 5 days.

Hopefully bb8bd3a52a5dbca8bea31bfc72dacfb384170e69 (merged six hours ago)
will have fixed this.  It Works For Me.
