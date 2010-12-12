From: David Miller <davem@davemloft.net>
Date: Sun, 12 Dec 2010 22:46:25 +0000
Subject: Re: [RFC 5/8] sparc: prom: Merge console_*.c into printf.c
Message-Id: <20101212.144625.260079801.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4CF9BC3B.10306@gmail.com>
In-Reply-To: <4CF9BC3B.10306@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Julian Calaby <julian.calaby@gmail.com>
Date: Sat, 04 Dec 2010 14:57:47 +1100

> prom_console_write_buf() is only used in prom/printf.c, so as it's
> the only remaining function in console_*.c, let's merge console_*.c
> into printf.c.
> 
> We'll also rename prom_nbputchar() to __prom_console_write_buf()
> and merge the definitions of prom_console_write_buf() as they're
> identical.
> 
> Signed-off-by: Julian Calaby <julian.calaby@gmail.com>

This doesn't make sense.

The whole idea is that when there is a 32-bit and 64-bit implementation
of the same interface, we have foo_32.c and foo_64.c to implement
them which is exactly what is happening here.
