From: David Miller <davem@davemloft.net>
Date: Tue, 19 Sep 2017 17:31:20 +0000
Subject: Re: [PATCH] sparc64: Expose mdesc to sysfs
Message-Id: <20170919.103120.280529551716525872.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
In-Reply-To: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Eric Saint Etienne <eric.saint.etienne@oracle.com>
Date: Tue, 19 Sep 2017 07:43:51 +0100

> 
>> I still stand by my decision, sorry.
> I am sorry for every Sparc users because it was a chance for them to
> easily explore and use machine description without having to install
> an external tool and a scripting language plus dependencies
> (potentially a lot of dependency). Users may also not know about
> /dev/mdesc whereas a mere "grep -ri cache /sys" would be fruitful.
> 
> Also mdesc is root accessible only. Exposing all or even just a
> selection of machine description nodes to users via sysfs provides
> them with the visibility of for instance TLBs and Caches (number,
> size, and more importantly how they are organized in the processor).

I originally made /proc/openprom which tried to interpret all of the
properites and print them in a reasonable way, and I deeply regret
having done this.  The powerpc folks, on the other hand, just provided
the raw data and had userland tools interpret the properties and
pretty print them.

That's what guided my decision to implement /dev/mdesc.

All of that complexity and knowledge of formatting properties this way
or that has no business in the kernel, and belongs completely in
userspace.
