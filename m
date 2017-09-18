From: David Miller <davem@davemloft.net>
Date: Mon, 18 Sep 2017 16:43:58 +0000
Subject: Re: [PATCH] sparc64: Expose mdesc to sysfs
Message-Id: <20170918.094358.1198348410996302850.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
In-Reply-To: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Eric Saint Etienne <eric.saint.etienne@oracle.com>
Date: Mon, 18 Sep 2017 15:23:57 +0100

> The aim of this patch is to ease browsing mdesc and implement
> utilities like lshw. If you look at lshw sources, you'll see that they
> make a real huge use of sysfs, the only binary device they use is for
> DMI tables (via /dev/dmi if present, or by directly accessing mmap'ed
> physical memory otherwise)

So you're telling me that there is support for image based handling in
the tool for the sake of DMI, so the tool could therefore just as
easily handle the current mdesc export format as well.

> Also, since mdesc is basically a tree it maps well to a filesystem
> structure like sysfs.

We don't export identical information two different ways in the kernel.

We have /dev/mdesc already.

For the other cases, sysfs was done first.  It wasn't duplicating an
existing mechanism.

I still stand by my decision, sorry.
