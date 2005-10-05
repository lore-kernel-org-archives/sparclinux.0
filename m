From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 05 Oct 2005 19:19:55 +0000
Subject: Re: [PATCH] Remove some duplicated sparc32 config items
Message-Id: <20051005.121955.91772603.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Thu, 8 Sep 2005 03:56:16 +0100

> Remove some duplicated items due to the inclusion of the general
> drivers/Kconfig file. These are now taken from drivers/char/Kconfig,
> and can be turned off there as well (which is desirable sometimes).
> 
> Patch is against stock 2.6.13.
> 
> Martin
> 
> 	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>

This has been in my backlog, sorry for taking so long.
I'll apply this, thanks.
