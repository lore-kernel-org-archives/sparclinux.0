From: David Miller <davem@davemloft.net>
Date: Fri, 23 Nov 2012 19:21:10 +0000
Subject: Re: [PATCH] of/address: sparc: Declare of_iomap as an extern function for sparc again
Message-Id: <20121123.142110.835354734152648777.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1353669849-23697-1-git-send-email-andreas@gaisler.com>
In-Reply-To: <1353669849-23697-1-git-send-email-andreas@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: andreas@gaisler.com
Cc: sam@ravnborg.org, rob.herring@calxeda.com, grant.likely@secretlab.ca, sparclinux@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, software@gaisler.com

From: Andreas Larsson <andreas@gaisler.com>
Date: Fri, 23 Nov 2012 12:24:09 +0100

> This bug-fix makes sure that of_iomap is defined extern for sparc so that the
> sparc-specific implementation of_iomap is once again used when including
> include/linux/of_address.h in a sparc context. OF_GPIO that is now available for
> sparc relies on this.
> 
> The bug was inadvertently introduced in a850a75, "of/address: add empty static
> inlines for !CONFIG_OF", that added a static dummy inline for of_iomap when
> !CONFIG_OF_ADDRESS. However, CONFIG_OF_ADDRESS is never defined for sparc, but
> there is a sparc-specific implementation /arch/sparc/kernel/of_device_common.c.
> 
> This fix takes the same approach as 0bce04b that solved the equivalent problem
> for of_address_to_resource.
> 
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>

Grant, can you possibly merge this to Linus while I'm travelling?
That would help me a lot.

Thanks!
