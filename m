From: David Miller <davem@davemloft.net>
Date: Sun, 11 Jun 2006 06:33:14 +0000
Subject: Re: [PATCH 0/4] sparc32: smp fixes
Message-Id: <20060610.233314.85416723.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <448BB4E4.4060408@mc.net>
In-Reply-To: <448BB4E4.4060408@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Breuer <breuerr@mc.net>
Date: Sun, 11 Jun 2006 01:15:00 -0500

> Here's a set of patches to get sparc32 caught back up to the moving SMP
> target:
>  1 - add topology_init
>  2 - setup cpu_possible_map
>  3 - add missing rw can_lock macros
>  4 - mark smp init functions as cpuinit
> 
> I have tested these successfully with 2.6.17-rc5.  With 2x
> SuperSPARC-II, I can rebuild the kernel with "make -j6" while running
> the SMP kernel.  I've verified that UP still builds and runs.  No luck
> yet with dual hyperSPARC's, but it will fully boot when restricted to
> just one.

Thanks Bob, I'll try to integrate these over the weekend.
