From: David Miller <davem@davemloft.net>
Date: Fri, 02 Jul 2010 19:20:13 +0000
Subject: Re: Checking for v9v/64v capability
Message-Id: <20100702.122013.11961802.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LSU.2.01.0912220054220.25079@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LSU.2.01.0912220054220.25079@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jan Engelhardt <jengelh@medozas.de>
Date: Fri, 2 Jul 2010 15:27:44 +0200 (CEST)

> But is there a C-programmatical way that does not rely on external
> files? /proc may not be mounted. auxv is usually not accessible,
> and forking is a sin too. OpenSSL uses assembler tricks and traps
> to determine if something has 4v or not, which leaves the realm of C.
> But it looks like it's okay, given x86 programs also do asm/cpuid
> to determine SSE availability.

I would really prefer that people use the AUXV information.

Right now this is what GLIBC uses to determine which optimized
memset/memcpy/etc. routines to use.  And this is also the case
when STT_GNU_IFUNC is used.

There are mechanisms by which you can mask the AUXV bits out, and by
doing so you can cause libraries that correctly inspect the AUXV for
feature bits to use the other optimized code cases.

You'd want to use this, for example, to run test suites over
all the available optimization cases on a single machine.

And that's something I really want a capability for.

You can pretty much test all the sparc64 optimized cases on a Niagara2
chip and the performance is reasonable.
