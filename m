From: "Frank Ch. Eigler" <fche@redhat.com>
Date: Wed, 07 Feb 2007 19:30:55 +0000
Subject: Re: [Ltt-dev] Linux Kernel Markers : sparc build issue
Message-Id: <20070207193055.GC7196@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20070207171912.GA5992@Krystal>
In-Reply-To: <20070207171912.GA5992@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi -

> It seems like I bust the 8k limit for the sparc GOT :
> The kallsyms_addresses is 8614 lines long (for a 33.6kB total) in the .S,
> and, according to
> http://gcc.gnu.org/onlinedocs/gcc-4.1.1/gcc/Code-Gen-Options.html :
> [...]

That could be it, but I don't see how that table of symbol addresses
    .long _text - 0xbeef
is using any GOT slots at all.  (Plus I don't know how a R_SPARC_32
could ever be truncated - maybe there is a 64- vs 32-bit toolchain
confusion happening somewhere?)

I could be misunderstanding things, but maybe what's wrong is that the
new markers section is located in a sensitive spot, and its size is
causing something else to no longer be reachable by shorter offsets.
What are the neighbouring regions in the linker script?

- FChE
