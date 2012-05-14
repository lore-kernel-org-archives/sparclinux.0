From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 14 May 2012 20:39:43 +0000
Subject: Re: [PATCH] sparc32: Move cache and TLB flushes over to method ops.
Message-Id: <20120514203943.GA4500@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20120513.235611.828382132525916634.davem@davemloft.net>
In-Reply-To: <20120513.235611.828382132525916634.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, May 14, 2012 at 04:35:47PM -0400, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Mon, 14 May 2012 12:44:50 +0200
> 
> >> [PATCH] sparc32: Implement hard_smp_processor_id() via instruction patching.
> >> 
> >> This is the last non-trivial user of btfixup.
> >> 
> >> Like sparc64, use a special patch section to resolve the various
> >> implementations of how to read the current CPU's ID when we don't
> >> have current_thread_info()->cpu necessarily available.
> >> 
> >> Signed-off-by: David S. Miller <davem@davemloft.net>
> > 
> > Boot tested UP and SMP builds on my ss5 - works!
> > 
> > This variant is much easier to read/understand compared
> > to the "blackbox" way!
> 
> Thanks for testing.
> 
> >> +1:	rd		%tbr, %g1
> >> +	srl		%g1, 12, %o0
> >> +	and		%o0, 3, %o0
> >> +	.section	.cpuid_patch, "ax"
> >> +	/* Instruction location. */
> >> +	.word		661b
> > 
> > You wanted to say:  .word 1b here...
> 
> I decided to use 661: to be consistent with the LOAD_CURRENT
> macro.
> 
> Fixed up and pushed out, thanks again Sam.

Baah, I am the one thanking here.
It would have taken me days to cook up this patch myself.

	Sam
