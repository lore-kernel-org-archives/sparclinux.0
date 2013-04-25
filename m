From: Meelis Roos <mroos@linux.ee>
Date: Thu, 25 Apr 2013 06:24:05 +0000
Subject: Re: sparc64, mm BUG in 3.9-rc8
Message-Id: <alpine.SOC.1.00.1304250923320.21668@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1304230019030.12820@math.ut.ee> <20130423.161751.2116707386990845036.davem@davemloft.net> <20130424.143615.334401973542739420.davem@davemloft.net> <20130424.195350.1927101733139114761.davem@davemloft.net>
In-Reply-To: <20130424.195350.1927101733139114761.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

> This fixes it, I'll push this to Linus immediately.
> 
> Thanks for your report!
> 
> --------------------
> sparc64: Fix missing put_cpu_var() in tlb_batch_add_one() when not batching.

Thank you, this patch fixes it on my 220R and 420R too.

-- 
Meelis Roos (mroos@linux.ee)
