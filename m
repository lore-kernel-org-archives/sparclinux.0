From: Peter Zijlstra <peterz@infradead.org>
Date: Mon, 10 Jan 2011 15:21:08 +0000
Subject: Re: sparc boot failure due to perf init
Message-Id: <1294672868.12715.0.camel@laptop>
List-Id: <sparclinux.vger.kernel.org>
References: <1294431832.2016.457.camel@laptop>
	 <1294432055.2016.458.camel@laptop>
	 <20110107203119.GA30408@merkur.ravnborg.org>
	 <20110109.153745.35032992.davem@davemloft.net>
In-Reply-To: <20110109.153745.35032992.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Sun, 2011-01-09 at 15:37 -0800, David Miller wrote:
> sparc64: Fix bootup regression due to perf init ordering.
> 
> Commit 004417a6d468e24399e383645c068b498eed84ad
> ("perf, arch: Cleanup perf-pmu init vs lockup-detector")
> move the perf events init to be an early_initcall.
> 
> But this won't work properly unless the dependencies for
> this code initialize beforehand.
> 
> Fix it by making cpu_type_probe and pcr_arch_init be
> an early_initcall as well.
> 
> Reported-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: David S. Miller <davem@davemloft.net> 

Thanks for sorting that David! and sorry for causing the breakage to
begin with.
