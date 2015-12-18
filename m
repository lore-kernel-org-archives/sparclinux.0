From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 18 Dec 2015 12:11:41 +0000
Subject: Re: [PATCH v3 4/4] printk/nmi: Increase the size of NMI buffer and make it configurable
Message-Id: <20151218121141.GR6373@twins.programming.kicks-ass.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1449667265-17525-1-git-send-email-pmladek@suse.com>
 <1449667265-17525-5-git-send-email-pmladek@suse.com>
 <CAMuHMdXVgr58YjoePGrRbMyMncQ27f85prL7G5SpeHeNxoYrXQ@mail.gmail.com>
 <20151211124159.GB3729@pathway.suse.cz>
 <20151211145725.b0e81bb4bb18fcd72ef5f557@linux-foundation.org>
 <20151211232113.GZ8644@n2100.arm.linux.org.uk>
 <alpine.LNX.2.00.1512120024370.9922@cbobk.fhfr.pm>
 <5673DD60.7080302@linaro.org>
 <20151218112902.GO6344@twins.programming.kicks-ass.net>
In-Reply-To: <20151218112902.GO6344@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Dec 18, 2015 at 12:29:02PM +0100, Peter Zijlstra wrote:
> On Fri, Dec 18, 2015 at 10:18:08AM +0000, Daniel Thompson wrote:
> > I'm not entirely sure that this is an improvement.
> 
> What I do these days is delete everything in vprintk_emit() and simply
> call early_printk().

On that, whoever made the device model use vprintk_emit() broke the
debugger (KGDB/KDB) printk intercept, and the whole vprintk_func
redirection scheme.
