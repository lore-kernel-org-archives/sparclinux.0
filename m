From: Joe Perches <joe@perches.com>
Date: Mon, 13 Sep 2010 20:22:18 +0000
Subject: Re: [PATCH 18/25] drivers/serial/suncore.c: Use static const char
Message-Id: <1284409338.26719.47.camel@Joe-Laptop>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1284406638.git.joe@perches.com>
	 <0ab674aa32a5fcc364982c78efdf44864a61523b.1284406639.git.joe@perches.com>
	 <20100913213613.223e10a5@lxorguk.ukuu.org.uk>
In-Reply-To: <20100913213613.223e10a5@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

On Mon, 2010-09-13 at 21:36 +0100, Alan Cox wrote:
> On Mon, 13 Sep 2010 12:47:56 -0700
> Joe Perches <joe@perches.com> wrote:
> > diff --git a/drivers/serial/suncore.c b/drivers/serial/suncore.c
> > @@ -106,7 +106,7 @@ void sunserial_console_termios(struct console *con, struct device_node *uart_dp)
> >  		if (of_console_options)
> >  			c = *of_console_options;
> >  
> > -		mode_prop[3] = c;
> > +		sprintf(mode_prop, "tty%c-mode", c);
> Whats the point of all this. It's trivial code being replaced by
> something complicated, harder to understand and much slower ?

There are many cases of char foo[] = "bar" that
should be actually be [static] const char foo[] etc.
The patch set was done to change those cases.

This case isn't actually any sort of saving.

As I just wrote in 5/25 to Jonathan Cameron:

It tries to standardize the style use and it avoids possible
future checkpatch warnings of:
	char foo[] = "bar"
char array could possibly be static const.

There was another use with "%1.1d" somewhere.

The end result is the same, so I don't really care much
if this sort of change is applied or not.  The possible
checkpatch message could just be considered noise but
Mike Frysinger seemed to prefer it, so I thought I could
try to accommodate him.

cheers, Joe

