From: Pete Zaitcev <zaitcev@redhat.com>
Date: Sun, 04 Jan 2004 08:18:24 +0000
Subject: Re: [PATCH] [SPARC] Use drivers/block/Kconfig
Message-Id: <20040104081824.GA5274@devserv.devel.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040103212307.GL6982@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040103212307.GL6982@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Jan 03, 2004 at 09:23:08PM +0000, Matthew Wilcox wrote:

> Sparc32 is currently missing a way to select CRYPTOLOOP due to not using
> drivers/blok/Kconfig.  Since there doesn't seem to be any reason not to,
> this patch switches sparc to use the generic Kconfig file.

> +++ arch/sparc/Kconfig	3 Jan 2004 21:18:53 -0000
> @@ -300,138 +300,7 @@ if !SUN4
>  source "drivers/sbus/char/Kconfig"
>  endif
>  
> -
> -menu "Block devices"
>[...]

Looks good, except that diff must be done for patch -p1 to work.
Keith?

-- Pete
