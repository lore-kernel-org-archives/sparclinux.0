From: David Miller <davem@davemloft.net>
Date: Tue, 17 Jan 2012 17:56:56 +0000
Subject: Re: silo fails to build with recent ext2fs libraries
Message-Id: <20120117.125656.365332574617446445.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120115140938.GA7564@wooyd.org>
In-Reply-To: <20120115140938.GA7564@wooyd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurij@wooyd.org>
Date: Sun, 15 Jan 2012 14:09:39 +0000

> Recently I've discovered that silo fails to build with recent ext2fs 
> libraries. Debian bug report [0] shows the relevant part of the build 
> log. Someone also reported the same problem on gentoo forum just a few 
> days ago [1].

First of all, the sources used in that package are out of date,
current SILO in GIT has a posix_memalign() and it was added exactly
one year ago.

So that part of the build failure is just due to an out of date
copy of the SILO sources.

I'm looking into the rest.
