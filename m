From: David Miller <davem@davemloft.net>
Date: Thu, 27 Sep 2007 20:22:13 +0000
Subject: Re: [PATCH] [SPARC/64] Prepare to remove of_platform_driver name
Message-Id: <20070927.132213.62213165.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070921181041.79c998a2.sfr@canb.auug.org.au>
In-Reply-To: <20070921181041.79c998a2.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 21 Sep 2007 18:10:41 +1000

> The name field of of_platform_driver is just copied into the
> included device_driver.  By not overriding an already initialised
> device_driver name, we can convert the drivers over time to stop using
> the of_platform_driver name.
> 
> Also we were not copying the owner field from of_platform_driver, so do
> the same with it.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

I've queued this up for 2.6.24, thanks!

> Do you guys want these split SPARC/SPARC64?

No, it actually makes more work for me :-)
