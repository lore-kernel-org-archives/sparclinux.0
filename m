From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 04 Jan 2005 18:54:39 +0000
Subject: Re: PAGE_SIZE and native vs. emulated 32-bit SPARC ABI
Message-Id: <20050104185439.GK2708@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20041230110707.GC29332@holomorphy.com>
In-Reply-To: <20041230110707.GC29332@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Jan 04, 2005 at 10:46:56AM -0800, David S. Miller wrote:
> The Sparc ABI states that one may make no assumptions about
> the PAGE_SIZE in any way.  That's why 32-bit Sparc ELF binaries
> compiled before sun4u even existed can execute properly on 8KB
> PAGE_SIZE systems.
> Not using getpagesize() is a pretty serious programming error.
> There are even facilities in the Sparc ELF specification that allow
> the binaries to work just fine for up to a 64KB page size.  A long
> time ago, Kanoj Sarcar played around with changing the default PAGE_SIZE
> of sparc64 to be 64K and all 32-bit binaries worked just fine.

I'll have to reiterate the hard answer I told the maintainers of one of
these cases. One of the other cases hasn't been diagnosed or resolved
yet but they are more willing/able to fix it in userspace.


-- wli
