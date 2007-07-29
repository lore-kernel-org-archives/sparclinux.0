From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Sun, 29 Jul 2007 20:56:24 +0000
Subject: Re: Sparc32 not working:2.6.23-rc1 (git commit
Message-Id: <20070729225624.5591c73a.krzysztof.h1@wp.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0707281903350.27869@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707281903350.27869@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, 29 Jul 2007 17:45:35 +0200
Krzysztof Helt <krzysztof.h1@wp.pl> wrote:

> It is not DMA I suppose. It does not happen in any specific place. It is easy to trigger by loading 
> and unloading the sunlance module, but it hangs linux in other places (init process, console login).
> 
> It happens only in SMP. If it happens in the sunlance module it happens in sparc_lance_probe_one()
> (in probing function). I thought it is due to openprom accesses so I commented them out (and put 
> hardcoded values there). No real change. It is always in the probe_one method before any DMA is
> started.
> 

I was able to find out that it is definitely prom related. When I removed also prom_node_has_property() call,
there is no bug any more. It locks inside prom_XXX access functions (e.g. __prom_nextprop or prom_getproplen).

The old prom system was working so I think the new openprom patches created this bug.

How does the new system access the prom? Is the old prom lock is taken into consideration?

Regards,
Krzysztof

