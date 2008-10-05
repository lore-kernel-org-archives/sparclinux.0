From: David Miller <davem@davemloft.net>
Date: Sun, 05 Oct 2008 02:25:37 +0000
Subject: Re: clock_tick printing in cpuinfo
Message-Id: <20081004.192537.193699081.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081002212059.GA13635@orion.carnet.hr>
In-Reply-To: <20081002212059.GA13635@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Sat, 4 Oct 2008 00:06:13 +0200

> It's not really obvious to me why glibc cares about this only on some
> architectures, though - sparc, i386, powerpc, ia64, x86_64 have
> __get_clockfreq(), but others don't. If I'm not missing something,
> the others are defaulting to a stub which does nothing...?

Only some architectures have GLIBC support implemented for highly
accurate timestamping.

And in fact, only some architectures can support this at all.
