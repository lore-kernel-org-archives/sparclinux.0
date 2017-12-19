From: David Miller <davem@davemloft.net>
Date: Tue, 19 Dec 2017 15:31:16 +0000
Subject: Re: [PATCH] crypto: n2 - cure use after free
Message-Id: <20171219.103116.1726291053594167469.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20171216010117.13275-1-jengelh@inai.de>
In-Reply-To: <20171216010117.13275-1-jengelh@inai.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jan Engelhardt <jengelh@inai.de>
Date: Sat, 16 Dec 2017 02:01:17 +0100

> queue_cache_init is called for every crypto processor found.
> 
> When first invoked, queue_cache[0] is NULL and queue_cache_init will
> allocate a kmem_cache. If queue_cache_init returns a failure code, the
> caller, grab_global_resources, will call queue_cache_destroy to release said
> kmem_cache, but it does this without setting queue_cache_init[0] to NULL.

That's not what's happening exactly.

queue_cache_init() is not failing and returning a failure code.

In fact, it is a very simple function which does nothing more than
create kmem caches so is very much unlikely to fail, especially with
the repeatability that you are seeing (ie. every time).

Instead, what fails is the algorithm registry which you should look
more deeply into the cause of.

And this failure path is how we lead to the problem.

This does need to be fixed, so please fix you commit message and
_also_, more importantly, please CC: the crypto list as well as the
crypto maintainer so that Herbert can see and integrate the fix.

I would also like you to look into why the algorithm registry fails,
if the selftest is running and getting incorrect results for the
algorithm that is a huge issue and must be investigated and fixed.

That is the true regression which is causing the failure path you
see to run at all.

Thank you.
