From: Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 18 Dec 2015 23:03:20 +0000
Subject: Re: [PATCH v3 4/4] printk/nmi: Increase the size of NMI buffer and make it configurable
Message-Id: <20151218150320.5d377789ee6253379b82412d@linux-foundation.org>
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
 <20151218121141.GR6373@twins.programming.kicks-ass.net>
In-Reply-To: <20151218121141.GR6373@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, 18 Dec 2015 13:11:41 +0100 Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Dec 18, 2015 at 12:29:02PM +0100, Peter Zijlstra wrote:
> > On Fri, Dec 18, 2015 at 10:18:08AM +0000, Daniel Thompson wrote:
> > > I'm not entirely sure that this is an improvement.
> > 
> > What I do these days is delete everything in vprintk_emit() and simply
> > call early_printk().
> 
> On that, whoever made the device model use vprintk_emit() broke the
> debugger (KGDB/KDB) printk intercept, and the whole vprintk_func
> redirection scheme.

crap, we have a whole set of interfaces which are broken this way. 
printk_emit(), vprintk(), vprintk_emit().


commit 7ff9554bb578ba02166071d2d487b7fc7d860d62
Author:     Kay Sievers <kay@vrfy.org>
AuthorDate: Thu May 3 02:29:13 2012 +0200
Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CommitDate: Mon May 7 16:53:02 2012 -0700

    printk: convert byte-buffer to variable-length record buffer

