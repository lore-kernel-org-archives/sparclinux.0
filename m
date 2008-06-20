From: David Miller <davem@davemloft.net>
Date: Fri, 20 Jun 2008 03:20:52 +0000
Subject: Re: [PATCH] sparc: correct module name in Kconfig help for
Message-Id: <20080619.202052.61770411.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200806171353.49127.elendil@planet.nl>
In-Reply-To: <200806171353.49127.elendil@planet.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Frans Pop <elendil@planet.nl>
Date: Wed, 18 Jun 2008 18:14:25 +0200

> How about this:
> 
>  	   This is the driver for the Sun ESP SCSI host adapter. The ESP
> -	   chipset is present in most SPARC SBUS-based computers.
> +	   chipset is present in most SPARC SBUS-based computers and
> +	   supports the Emulex family of ESP SCSI chips (esp100, esp100A,
> +	   esp236, fas101, fas236) as well as the Qlogic fas366 SCSI chip.
> 
> Not sure if the chip details are correct, but I suspect you will :-)
> 
> If OK, would you prefer a separate patch for this or can you merge it into 
> my previous patch?

I merged it into your previous patch, thanks Frans.
