From: David Miller <davem@davemloft.net>
Date: Tue, 06 Jun 2006 04:15:41 +0000
Subject: Re: 2.6.17-rc5 does not build for sparc
Message-Id: <20060605.211541.59656905.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4478bffd45960@wp.pl>
In-Reply-To: <4478bffd45960@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Date: Sat, 27 May 2006 23:09:17 +0200

> I tried to build the 2.6.17-rc5 for sparc with SMP enabled. The
> kernel was not build due to a missing macro. Here is a patch
> which fixes this (I copied the macro from a sparc64 header).

I was going to apply this just to fix the build, but it's
not correct.

Because we embed a spinlock in the rwlock_t, we have to spin
waiting for the lock bits to be clear before we can trust the
sample of the rest of the lock.  We used to have to do this
when we embedded a spinlock into the atomic_t's on sparc32.
