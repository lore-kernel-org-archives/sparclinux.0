From: Johan Hovold <johan@kernel.org>
Date: Mon, 21 Nov 2016 14:58:45 +0000
Subject: Re: [PATCH] USB: serial: cp210x: Use tcflag_t to fix incompatible pointer type
Message-Id: <20161121145845.GA27409@localhost>
List-Id: <sparclinux.vger.kernel.org>
References: <1479730771-17759-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1479730771-17759-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Nov 21, 2016 at 01:19:31PM +0100, Geert Uytterhoeven wrote:
> On sparc32, tcflag_t is unsigned long, unlike all other architectures:
> 
>     drivers/usb/serial/cp210x.c: In function 'cp210x_get_termios':
>     drivers/usb/serial/cp210x.c:717:3: warning: passing argument 2 of 'cp210x_get_termios_port' from incompatible pointer type
>        cp210x_get_termios_port(tty->driver_data,
>        ^
>     drivers/usb/serial/cp210x.c:35:13: note: expected 'unsigned int *' but argument is of type 'tcflag_t *'
>      static void cp210x_get_termios_port(struct usb_serial_port *port,
> 		 ^
> 
> Consistently use tcflag_t to fix this.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Applied for -next as this an old warning for something that should be
benign on 32-bit.

Thanks,
Johan
