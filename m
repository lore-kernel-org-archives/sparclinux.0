From: "Chris Friesen" <cfriesen@nortel.com>
Date: Mon, 25 Jan 2010 18:53:32 +0000
Subject: memory barriers on sparc
Message-Id: <4B5DE8AC.7040606@nortel.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Someone asked a question on comp.programming.threads about memory
barriers, which led me to the discovery that glibc and the kernel use
different semantics for memory barriers on sparc64 (and maybe sparc too,
didn't check).

The kernel uses:

read : LoadLoad
write : StoreStore

This matches my understanding of the behaviour of other architectures as
well.  I got confused when I saw that glibc (as of 2.8 at least) uses:

read: LoadLoad | LoadStore
write: StoreLoad | StoreStore

I'm curious about the difference.  Could someone explain why glibc uses
additional restrictions and the kernel doesn't?

Thanks,

Chris

