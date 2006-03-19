From: "David S. Miller" <davem@davemloft.net>
Date: Sun, 19 Mar 2006 23:26:52 +0000
Subject: Re: Switch default page size to 64k?
Message-Id: <20060319.152652.113371955.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <ed9ea0040603191435t36c95a80k47d2bf4903a66811@mail.gmail.com>
In-Reply-To: <ed9ea0040603191435t36c95a80k47d2bf4903a66811@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Holger Berger" <holger.s.berger@googlemail.com>
Date: Sun, 19 Mar 2006 23:35:43 +0100

> Would it be possible to make the 64k page size the default for
> Linux/SPARC64 (e.g. UltraSPARCs except the original UltraSPARC-III)?
> IMO it would result in some performance gains for HPC applications
> with small and medium memory usage.

But it would kill performance for workloads using small files.  Each
and every file needs to use at least one page in the file system page
cache, and even currently at 8K there is a huge amount of memory
wasted on small files.

And we will not go to using different page sizes on different chips,
we have a single sparc64 kernel image that works on all sparc64
processor types, and after working so hard to maintain that for the
sanity of distribution maintainers we are not moving away from that
without a good reason.

I'd like the whole list to know that Holger's agenda is aparently to
get Linux to move to a 64K default page size on Niagara in order to
pressure the OpenSolaris folks to do the same.  And that's not a
reason for Linux to make such a technical decision.
