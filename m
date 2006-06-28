From: Raymond Burns <rayburns@comcast.net>
Date: Wed, 28 Jun 2006 16:43:43 +0000
Subject: Re: [PATCH] sparc: remove sunzilog_console_init
Message-Id: <Pine.LNX.4.10.10606280952180.16067-100000@coalcreekmill.cm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20060628141601.GA31139@palantir8>
In-Reply-To: <20060628141601.GA31139@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi

Odd but I went the other direction, I added the line:

console_initcall(sunzilog_console_init);

near the bottom of the sunzilog.c file.

which removes the compiler warning but did not solve the trouble I
have where /dev/console cannot be opened: 

Warning: unable to open an initial console.

Someone has went to length to rewrite a fair portion of the serial
code to attain compatability with generic handling of serial ports.

What direction is serial port code going now?


On Wed, 28 Jun 2006, Martin Habets wrote:

> Hi,
> 
> This patch against 2.6.17 resolves the following build warning:
>   CC      drivers/serial/sunzilog.o
> drivers/serial/sunzilog.c:1390: warning: `sunzilog_console_init' defined but not used
> 
> It was tested on a SS20 with the console on a sunzilog.
> 
> Martin
> 
> 	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>
> ---
> --- 2.6.17/drivers/serial/sunzilog.c.old	2006-06-28 15:04:17.000000000 +0100
> +++ 2.6.17/drivers/serial/sunzilog.c	2006-06-28 15:07:43.000000000 +0100
> @@ -1386,28 +1386,6 @@
>  	.data   =	&sunzilog_reg,
>  };
>  
> -static int __init sunzilog_console_init(void)
> -{
> -	int i;
> -
> -	if (con_is_present())
> -		return 0;
> -
> -	for (i = 0; i < NUM_CHANNELS; i++) {
> -		int this_minor = sunzilog_reg.minor + i;
> -
> -		if ((this_minor - 64) = (serial_console - 1))
> -			break;
> -	}
> -	if (i = NUM_CHANNELS)
> -		return 0;
> -
> -	sunzilog_console.index = i;
> -	sunzilog_port_table[i].flags |= SUNZILOG_FLAG_IS_CONS;
> -	register_console(&sunzilog_console);
> -	return 0;
> -}
> -
>  static inline struct console *SUNZILOG_CONSOLE(void)
>  {
>  	int i;
> @@ -1432,7 +1410,6 @@
>  
>  #else
>  #define SUNZILOG_CONSOLE()	(NULL)
> -#define sunzilog_console_init() do { } while (0)
>  #endif
>  
>  /*
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Thanx
  Ray


