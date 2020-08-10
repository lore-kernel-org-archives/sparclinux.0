From: peterz@infradead.org
Date: Mon, 10 Aug 2020 11:16:44 +0000
Subject: Re: [sparc64] enabling CONFIG_PROVE_LOCKING makes kernel unable to build
Message-Id: <20200810111644.GP2674@hirez.programming.kicks-ass.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqybxFr5reVmYM2_h+KUzqL3PU5Qo9nrZSieQPYq+gWWCg@mail.gmail.com>
 <20200804133438.GK2674@hirez.programming.kicks-ass.net>
 <CADxRZqy+PcHrMu1a6VZp_SNEybVUax88eqO09Sbq7v3yjivVKw@mail.gmail.com>
In-Reply-To: <CADxRZqy+PcHrMu1a6VZp_SNEybVUax88eqO09Sbq7v3yjivVKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anatoly Pugachev <matorola@gmail.com>
Cc: Sparc kernel list <sparclinux@vger.kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>

On Mon, Aug 10, 2020 at 12:23:48PM +0300, Anatoly Pugachev wrote:
> On Tue, Aug 4, 2020 at 4:34 PM <peterz@infradead.org> wrote:
> >
> > On Tue, Aug 04, 2020 at 04:17:16PM +0300, Anatoly Pugachev wrote:
> > > Hello!
> > >
> > > Linus git master sources:
> > >
> > > $ git desc
> > > v5.8-2483-gc0842fbc1b18
> > >
> >
> > Ooh, it looks like that series wasn't cut back far enough :/
> >
> > 859247d39fb0 ("seqlock: lockdep assert non-preemptibility on seqcount_t
> > write") does indeed also introduce problems.
> >
> > I've been working on untangling the header mess for the full series and
> > the below patch is what I currently have.
> >
> > ---
> > Subject: seqlock,headers: Untangle the spaghetti monster
> > From: Peter Zijlstra <peterz@infradead.org>
> > Date: Thu Jul 30 13:20:47 CEST 2020
> >
> > By using lockdep_assert_*() from seqlock.h, the spaghetti monster
> > attacked.
> 
> Thanks Peter!
> 
> It doesn't apply cleanly over master git, but it least makes kernel
> compilable / bootable on sparc64:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent

Should contain an updated version.
