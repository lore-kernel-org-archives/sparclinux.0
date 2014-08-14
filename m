From: Meelis Roos <mroos@linux.ee>
Date: Thu, 14 Aug 2014 12:20:38 +0000
Subject: Re: sparc64 WARNING: at mm/mmap.c:2757 exit_mmap+0x13c/0x160()
Message-Id: <alpine.SOC.1.00.1408141519440.24828@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1407310101550.2065@math.ut.ee> <20140730.150722.861254999466992321.davem@davemloft.net> <alpine.SOC.1.00.1408131327250.18696@math.ut.ee> <20140813.124611.767426770013677.davem@davemloft.net>
In-Reply-To: <20140813.124611.767426770013677.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: aaro.koskinen@iki.fi, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, hughd@google.com, cat.schulze@alice-dsl.net

> > Did not test current git more.
> 
> Current git fails to boot without this fix which I posted the other
> day:
> 
> ==========
> [PATCH 1/2] sparc64: Do not disable interrupts in nmi_cpu_busy()

Thanks, I noticed it on sparclinux@ but did not add one and one 
together. Now it seems to work with at least T2000. Will test other 
machines as I get some time.

-- 
Meelis Roos (mroos@linux.ee)
