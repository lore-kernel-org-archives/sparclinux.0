From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 04 Jan 2005 18:46:56 +0000
Subject: Re: PAGE_SIZE and native vs. emulated 32-bit SPARC ABI
Message-Id: <20050104104656.08e4564c.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20041230110707.GC29332@holomorphy.com>
In-Reply-To: <20041230110707.GC29332@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 30 Dec 2004 03:07:07 -0800
William Lee Irwin III <wli@holomorphy.com> wrote:

> It seems that most/all 32-bit SPARC programs are written and compiled
> for emulated 32-bit on sun4u, which has an 8KB PAGE_SIZE, and returns
> 8KB for getpagesize(). This is unfortunately causing spectacular
> failures on some of my favorite regression tests for memory management,
> which are interpreters using memory protection-based garbage collectors.

The Sparc ABI states that one may make no assumptions about
the PAGE_SIZE in any way.  That's why 32-bit Sparc ELF binaries
compiled before sun4u even existed can execute properly on 8KB
PAGE_SIZE systems.

Not using getpagesize() is a pretty serious programming error.

There are even facilities in the Sparc ELF specification that allow
the binaries to work just fine for up to a 64KB page size.  A long
time ago, Kanoj Sarcar played around with changing the default PAGE_SIZE
of sparc64 to be 64K and all 32-bit binaries worked just fine.
