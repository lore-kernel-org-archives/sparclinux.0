From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Thu, 25 Mar 2004 18:18:59 +0000
Subject: Re: Other GCC-3.5 compilation errors
Message-Id: <20040325181859.GA2413@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040325174645.GD11895@artsapartment.org>
In-Reply-To: <20040325174645.GD11895@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Mar 25, 2004 at 11:46:45AM -0600, Art Haas wrote:

> arch/sparc/kernel/sun4m_smp.c: line 99: Too few arguments in init_idle()
> arch/sparc/kernel/sun4d_smp.c: line 103: Too few arguments in init_idle()
> 
> The signal.c error looks like something in the get_user() macro
> needs tweaking. I haven't looked too much at the init_idle() problem,
> though I guess just stuffing in some arguments would help, and even
> better solution would be using correct and valid arguments as well. :-)

SMP doesn't build, period.  I've been applying patches over the last
few weeks, and I have patches currently that make it build and
_almost_ boot.  These will be applied when it boots to userland.

> needs some help. I'm guessing that people are sticking with GCC-3.3
> for kernel compilation, or is the common suggestion using an older
> compiler like gcc-2.95? Any other tips, tricks, or suggestions
> regarding compilers that people care to pass along?

I use 3.3.3.  3.2.3 is also known to work well.  3.4 and 3.5 are more
or less completely untested.

For those using 3.4+, does it get init_thread_union right?  3.3 does
not, so I'm probably going to change it to
__attribute__(aligned(THREAD_SIZE)) __attribute__(section(".text")).

-- 
Keith M Wesolowski
