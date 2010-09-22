From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Wed, 22 Sep 2010 19:53:49 +0000
Subject: Re: [GIT] Sparc
Message-Id: <20100922195349.GF19804@ZenIV.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20100922.111019.200357319.davem@davemloft.net>
 <20100922183200.GC19804@ZenIV.linux.org.uk>
 <AANLkTi=DWk2_=wMqcM1jgJEuNRj_ni2OkM3osYCUg57Y@mail.gmail.com>
 <20100922185328.GD19804@ZenIV.linux.org.uk>
 <AANLkTi=pJUKRUQhpcVV8XAJF+BO1440v1Py5Opr34DR1@mail.gmail.com>
In-Reply-To: <AANLkTi=pJUKRUQhpcVV8XAJF+BO1440v1Py5Opr34DR1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>, akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Sep 22, 2010 at 12:08:53PM -0700, Linus Torvalds wrote:
> On Wed, Sep 22, 2010 at 11:53 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Um, no. ?You've *already* called get_signal_to_deliver(). ?There had been
> > no SIGSEGV in sight. ?You happily went on to set a sigframe for e.g.
> > SIGHUP, but ran out of stack. ?At that point you get force_sigsegv()
> > from handle_signal(). ?_NOW_ you have a pending SIGSEGV
> 
> Ahh. Ok. Different case from the one I thought you were worried about.
> And yeah, I guess that one does require us to mess with the low-level
> asm code (although I do wonder if we could not make the whole
> do_notify_resume + reschedule code be generic C code - it's a lot of
> duplicated subtle asm as it is).

Worse than just that...  Note that on sparc you need to deal with
fault_in_user_windows(), which can also trigger signals.  So much
for merging it cross-architecture, even if we ignore the differences
between the ways we pass data required for restart to do_signal().
Note that e.g. on alpha we pass _two_ values - one for overwritten
v0 (syscall number), another for overwritten a3 (error flag), etc.

Worse, quite a few targets do not save all registers on syscall entry.
Callee-saved stuff doesn't have to be in pt_regs.  Except that you
want *all* of them saved on stack when it's time to fill sigframes.
And once you've entered a C function you can't guarantee that compiler
hasn't already modified them; sure, they'll be restored on return, but
that doesn't help you to get to their values.  So you get switch_stack
built on stack around calling do_notify_resume() on those.  And you
really want to avoid doing that if you've got no signals - remember,
we hit that on exit from irqs as well, so it's one hell of a hot path.
For processors with big flat register file it can get very ugly.

There is a lot of ugly almost-duplication in there, no arguments about that.
Asm glue is actually not the worst part...
