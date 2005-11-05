From: "David S. Miller" <davem@davemloft.net>
Date: Sat, 05 Nov 2005 00:39:45 +0000
Subject: Re: possible cg6 fix for pixels repeating at display edge or fading
Message-Id: <20051104.163945.117561939.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4363EE58.1090508@mc.net>
In-Reply-To: <4363EE58.1090508@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Breuer <breuerr@mc.net>
Date: Sat, 29 Oct 2005 16:49:12 -0500

> @@ -658,7 +658,7 @@ static void cg6_chip_init(struct fb_info
>  	/* Disable cursor in Brooktree DAC. */
>  	sbus_writel(0x06 << 24, &par->bt->addr);
>  	tmp = sbus_readl(&par->bt->control);
> -	tmp &= ~(0x03 << 24);
> +	tmp |= (0x03 << 24);
>  	sbus_writel(tmp, &par->bt->control);
>  }

BTW, I noticed that the 2.4.x cgsix.c driver does set the bits here
instead of clear them.  I have no idea why when I moved this code over
while writing the 2.6.x driver I changed it to clear the bits :-/
