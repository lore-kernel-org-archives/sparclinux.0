From: David Miller <davem@davemloft.net>
Date: Thu, 27 Mar 2008 06:33:54 +0000
Subject: Re: sparc64 BUG: using smp_processor_id() in preemptible
Message-Id: <20080326.233354.102892522.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080326.041626.224135350.davem@davemloft.net>
	<20080326.042516.261621639.davem@davemloft.net>
	<20080326202502.f06938bd.akpm@linux-foundation.org>
In-Reply-To: <20080326202502.f06938bd.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org
Cc: m.kozlowski@tuxland.pl, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 26 Mar 2008 20:25:02 -0700

> On Wed, 26 Mar 2008 04:25:16 -0700 (PDT) David Miller <davem@davemloft.net> wrote:
> 
> >  	preempt_disable();
> >  
> > +	mp = &__get_cpu_var(mmu_gathers);
> 
> that's an open-coded get_cpu_var().
> 
> fwiw.  Which isn't much, IMO.  Sometimes it's nice to see things open-coded.

Good point, I might restructure that to use {get,put}_cpu_var().
