From: andrew@walrond.org
Date: Sun, 05 Nov 2006 22:43:11 +0000
Subject: Re: Strange kernel messages bootinh 2.6.18.2 on an E4000
Message-Id: <20061105224311.GB11406@pelagius.h-e-r-e-s-y.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20061105120547.GA3665@pelagius.h-e-r-e-s-y.com>
In-Reply-To: <20061105120547.GA3665@pelagius.h-e-r-e-s-y.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Nov 05, 2006 at 02:21:15PM -0800, David Miller wrote:
> 
> I've built a native gdb64 under Dapper and it works just fine.

Ok; thats a useful datapoint. I'll see what patches they are using.

> 
> A pure-64bit userland on sparc64 is an _incredibly_ _stupid_ idea.

Sniff ;)

> The only thing you'll get is larger binaries, worse performance, and
> maybe 1 or 2 tools which work a slightly better but could be easily
> fixed to work properly as a 32-bit app too.

I don't disagree, but my distro is all built from source, and is a
quick port from the pure 64bit x86_64 version. One glibc and a
non-multilib gcc makes everything _so_ much simpler to build :)

But the "speed" of the distro apps is irrelevant; the peformance
of my custom massively threaded 64bit apps are the only thing that
matters. I've been benchmarking a T1000 to see how it peforms
against the x86_64 kit I am more used to. And I bought a pallet load
of E4500's to play with, since they were almost free :)

Andrew
