From: Raymond Burns <rayburns@comcast.net>
Date: Mon, 22 May 2006 06:09:41 +0000
Subject: Re: serial console
Message-Id: <Pine.LNX.4.10.10605220007520.11270-100000@coalcreekmill.cm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.10.10605211029540.11270-200000@coalcreekmill.cm.com>
In-Reply-To: <Pine.LNX.4.10.10605211029540.11270-200000@coalcreekmill.cm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi

On Sun, 21 May 2006, David S. Miller wrote:

> 
> Why does booting with the "-p" option not work?
> That uses the PROM as the output console just like
> your patch does.
> 

I believe testing -p was where I placed 
 if (serial_console=0)
before 
 conswitchp = &(dummy_con/prom_con)

The result of testing -p which led to this was the console (wyse 150
as vt100) tried to do some sort of mode change / clear screen then
fill a screen buffer with blanks (?) then sit inertly at top left
corner. The prom_printf's I have been adding to track down troubles
did not show.

I could not determine if this was something to do with frame buffer or
virtual terminal, but it interfered with prom_printf. I do have
virtual terminals enabled for use with telnet / rlogin from
un-beheaded boxes when it boots and have found no way to turn off the
CONFIG_VT_CONSOLE if CONFIG_VT is set (editing .config doesn't).

With the patch I get prom_printf's and printk's 
Without the patch I get prom_printf only 
And yes with -p I get nothing (I am sorry, once I got printk's on the
screen I did not go back and test the -p so I don't know what it does
after the patch).

I would not mind testing patches that attempt to do this "right"

Thanx
  Ray


