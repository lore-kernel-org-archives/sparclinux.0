From: David Miller <davem@davemloft.net>
Date: Tue, 18 Jul 2006 04:35:39 +0000
Subject: Re: sparc32 smp
Message-Id: <20060717.213539.58452399.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.10.10607130208320.4657-300000@coalcreekmill.cm.com>
In-Reply-To: <Pine.LNX.4.10.10607130208320.4657-300000@coalcreekmill.cm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Raymond Burns <rayburns@comcast.net>
Date: Thu, 13 Jul 2006 03:41:25 -0700 (PDT)

> The attached oops occurs during boot when the cache is converted from
> static to allocated cache ( kmem_cache_create() )
> 
> The attached patch might be a work around until mainline kernel slab
> code does something
> 
> The occurance in kmem_cache_destroy() is a best guess, my boot hasn't
> made it far enough to test it.
> 
> static cache is initialized prior to smp_init, the boot cpu is the
> only one running. There is no mechanism to initialize numa style cache
> heads per smp cpu (that I found). after the memcpy, accessing the
> array list_lock for cpu 2 causes the oops.
> 
> This got me past the slab stuff into the sunzilog oops ...

I don't think this patch is right.  It wants to iterate over
online cpus, not online NUMA nodes.  Since CONFIG_NUMA is
not enabled in sparc builds, what you've changed it to do
is simply iterate over cpu "0".

Something else is afoot here.  Perhaps the cpu maps or similar
are not setup early enough.  But if that was the case, Bob
would be seeing this problem on his smp sparc32 machines too.
