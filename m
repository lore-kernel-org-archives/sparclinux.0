From: David Miller <davem@davemloft.net>
Date: Thu, 11 Oct 2007 06:27:43 +0000
Subject: Re: [PATCH] [SPARC/64] move of_platform_driver initialisations:
Message-Id: <20071010.232743.58782077.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20071011152448.c762f034.sfr@canb.auug.org.au>
In-Reply-To: <20071011152448.c762f034.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 11 Oct 2007 15:24:48 +1000

> We no longer initialise the name field of the of_platform_driver, but
> use the name field of the embedded device_driver's name field instead.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Applied, thanks Stephen.
