From: Meelis Roos <mroos@linux.ee>
Date: Wed, 30 Jul 2014 22:02:53 +0000
Subject: Re: sparc64 WARNING: at mm/mmap.c:2757 exit_mmap+0x13c/0x160()
Message-Id: <alpine.SOC.1.00.1407310101550.2065@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20140414184353.GA5630@drone.musicnaut.iki.fi> <20140416.145822.1317931249717152474.davem@davemloft.net> <alpine.SOC.1.00.1404170119550.20193@math.ut.ee> <20140729.162635.638786990787878495.davem@davemloft.net>
In-Reply-To: <20140729.162635.638786990787878495.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: aaro.koskinen@iki.fi, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, hughd@google.com, cat.schulze@alice-dsl.net

> Here is something I'd like you guys to test.

Very interesting.

[...]
> Could you guys please try this patch below?  Thanks.

  CC      arch/sparc/mm/init_64.o
arch/sparc/mm/init_64.c: In function 'update_mmu_cache_pmd':
arch/sparc/mm/init_64.c:2625:6: error: 'pte' may be used uninitialized in this function [-Werror=uninitialized]

gcc 4.6.4.

-- 
Meelis Roos (mroos@linux.ee)
