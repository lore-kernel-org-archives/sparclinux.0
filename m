From: William Lee Irwin III <wli@holomorphy.com>
Date: Thu, 12 Feb 2004 09:55:19 +0000
Subject: Re: 2.6.x SMP RED_state in prom_startcpu()
Message-Id: <20040212095519.GZ699@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040131025909.GD624@holomorphy.com>
In-Reply-To: <20040131025909.GD624@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Jan 30, 2004 at 10:52:12PM -0500, Ben Collins wrote:
>>> The cross-compilation may be the issue. Want to try a native build to
>>> make sure?

On Fri, Jan 30, 2004 at 08:24:26PM -0800, William Lee Irwin III wrote:
>> Trying to get luserspace bootstrapped enough to do this now. I'll start
>> pinging gcc hackers if that works and hence shows cross builds bust.

On Sat, Feb 07, 2004 at 09:06:10PM -0800, William Lee Irwin III wrote:
> I got a native toolchain going. 2.4.24 flies with the 2nd cpu online.
> 2.6.x fails in prom_startcpu(). Cross-builds fail for both.

I've "reseated" the cpus and the RAM, as best I can anyway (I couldn't
fully dislodge them for reinsertion, so I had to settle for pressing
down on them a bit without actually removing them). Going over things
again shows that the current conclusions are:

(a) cross-builds of both 2.4 and 2.6 are bust in SMP regardless of
	compiler version, but both 2.4 and 2.6 work UP regardless of
	compiler version
(b) 2.6 SMP is also bust built natively, regardless of compiler version
(c) The only working Linux SMP datapoints are native builds of 2.4.24,
	regardless of compiler version.
(d) Solaris still boots and works SMP.

This is weird, because u2's supposedly fly in 2.6 for others.

I'm going to have to ignore the cross-build issue and move on to why
2.6 is exploding. I've narrowed the window where the exception happens
down to the call to prom_startcpu() via prom_printf(). I like to think
that I usually have more clue but I'm a bit new to UltraSPARC, so a
general direction like "go dump $FOO via prom_printf()" or "try to
install a RED_state handler" (which I've actually tried and failed at
once) might be handy here.

Thanks.


-- wli
