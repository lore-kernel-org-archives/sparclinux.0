From: David Miller <davem@davemloft.net>
Date: Sat, 25 Aug 2007 21:39:45 +0000
Subject: Re: Questions about prom functions and restore_current()
Message-Id: <20070825.143945.109066602.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070825231840.5c0ddc2a.krzysztof.h1@wp.pl>
In-Reply-To: <20070825231840.5c0ddc2a.krzysztof.h1@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Sat, 25 Aug 2007 23:18:40 +0200

> I try to trace problems with prom and SMP. I wonder what actually
> the restore_current() function does (it restores g6 register, but I do
> not understand why).

The current task pointer is kept in register %g6.
We were concerned that calling PROM functions would
clobber that register, and that's why we need to restore
it.

> The restore_current() uses the macro below, which seems to have the first
> line redundant unless some magic is involved. The __b_load_current load
> is overwritten by the boot_cpu_id4 load in the third line.

These instructions are patched at early boot time depending upon what
kind of cpu we are on.
