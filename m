From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 27 Mar 2008 03:25:02 +0000
Subject: Re: sparc64 BUG: using smp_processor_id() in preemptible
Message-Id: <20080326202502.f06938bd.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LFD.1.00.0803251856450.2775@woody.linux-foundation.org>
	<200803261142.07422.m.kozlowski@tuxland.pl>
	<20080326.041626.224135350.davem@davemloft.net>
	<20080326.042516.261621639.davem@davemloft.net>
In-Reply-To: <20080326.042516.261621639.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: m.kozlowski@tuxland.pl, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Wed, 26 Mar 2008 04:25:16 -0700 (PDT) David Miller <davem@davemloft.net> wrote:

>  	preempt_disable();
>  
> +	mp = &__get_cpu_var(mmu_gathers);

that's an open-coded get_cpu_var().

fwiw.  Which isn't much, IMO.  Sometimes it's nice to see things open-coded.
