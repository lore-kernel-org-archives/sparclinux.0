From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Wed, 22 Sep 2010 18:53:28 +0000
Subject: Re: [GIT] Sparc
Message-Id: <20100922185328.GD19804@ZenIV.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20100922.111019.200357319.davem@davemloft.net>
 <20100922183200.GC19804@ZenIV.linux.org.uk>
 <AANLkTi=DWk2_=wMqcM1jgJEuNRj_ni2OkM3osYCUg57Y@mail.gmail.com>
In-Reply-To: <AANLkTi=DWk2_=wMqcM1jgJEuNRj_ni2OkM3osYCUg57Y@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>, akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Sep 22, 2010 at 11:46:27AM -0700, Linus Torvalds wrote:
> On Wed, Sep 22, 2010 at 11:32 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > That has unpleasant results - for starters, delivery of SIGSEGV upon
> > failure to set sigframe up is delayed unpredictably; we will take it
> > only when we trap again.
> 
> I think this whole argument is a total red herring.
> 
> It's a bug in next_signal() if we allow this to happen. We need to
> enqueue those synchronous signals first, and NO AMOUNT OF SIGNAL
> QUEUEING will ever change that.
> 
> The fact is, even if you queue up all the signals at once, you need to
> queue up the synchronous ones first. Otherwise their instruction
> pointer information etc will simply be bogus. It's that simple. Your
> argument about queuing up one, two, or more signals is bogus, for the
> simple reason that it doesn't matter: whether you queue or not is
> irrelevant, since the "innermost" one in the queue always has to be
> the SIGSEGV.
> 
> Whether we queue other signals on top of that (and they get executed
> first, since it's a stack) doesn't matter. That's a timing issue, and
> the program acts as if those asynchronous signals happened before the
> trap. But that's fine. All that matters is that the actual synchronous
> signal has the register contents of the time of the synchronous trap,
> ie it gets enqueued first.
> 
> It's why we have that "if (x & SYNCHRONOUS_MASK)" in next_signal().
> It's not pretty, it's not perfect, but it's required.

Um, no.  You've *already* called get_signal_to_deliver().  There had been
no SIGSEGV in sight.  You happily went on to set a sigframe for e.g.
SIGHUP, but ran out of stack.  At that point you get force_sigsegv()
from handle_signal().  _NOW_ you have a pending SIGSEGV; whether you'll
be able to handle it (e.g. if your SIGSEGV handler is set to run on
altstack) or not, you won't get to it until you call get_signal_to_deliver()
again.  Which requires do_signal() to run.

Sure, it will be the first one to be picked, but we need to try and pick
_something_ to get it.
