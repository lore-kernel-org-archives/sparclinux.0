From: David Miller <davem@davemloft.net>
Date: Mon, 25 Jan 2010 21:27:14 +0000
Subject: Re: memory barriers on sparc
Message-Id: <20100125.132714.27479557.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4B5DE8AC.7040606@nortel.com>
In-Reply-To: <4B5DE8AC.7040606@nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Chris Friesen" <cfriesen@nortel.com>
Date: Mon, 25 Jan 2010 12:53:32 -0600

> 
> Someone asked a question on comp.programming.threads about memory
> barriers, which led me to the discovery that glibc and the kernel use
> different semantics for memory barriers on sparc64 (and maybe sparc too,
> didn't check).
> 
> The kernel uses:
> 
> read : LoadLoad
> write : StoreStore
> 
> This matches my understanding of the behaviour of other architectures as
> well.  I got confused when I saw that glibc (as of 2.8 at least) uses:
> 
> read: LoadLoad | LoadStore
> write: StoreLoad | StoreStore
> 
> I'm curious about the difference.  Could someone explain why glibc uses
> additional restrictions and the kernel doesn't?

The kernel knows some things about what ordering modes it will ever
operate in (I'm referring to the current memory model as is programmed
into the %pstate register), and the details of all existing sparc64
chips.  So it can elide several kinds of barrier specifiations.

GLIBC could do it too, at least under Linux, but to be
"fully Sparc V9 compliant" it needs to use the full barriers.
