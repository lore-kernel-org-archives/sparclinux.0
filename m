From: David Miller <davem@davemloft.net>
Date: Thu, 13 Jan 2011 20:25:22 +0000
Subject: Re: sparc boot failure due to perf init
Message-Id: <20110113.122522.107108292.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110107203119.GA30408@merkur.ravnborg.org>
	<20110109.153745.35032992.davem@davemloft.net>
	<1294916129.19601.88.camel@laptop>
In-Reply-To: <1294916129.19601.88.camel@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: peterz@infradead.org
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 13 Jan 2011 11:55:28 +0100

> I just realized, doesn't this make bootability depend on link order?
> Since both the pmu init and its dependencies are now early_initcall()
> how do we guarantee pcr_arch_init() and cpu_type_probe() are in fact
> called _before_ init_hw_perf_events()?

Yes, it does, and I made sure the ordering in the sparc Makefile
satisfied the constraints.
