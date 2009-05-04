From: Josip Rodin <joy@entuzijast.net>
Date: Mon, 04 May 2009 09:57:15 +0000
Subject: Re: debian unusable on niagara
Message-Id: <20090504095715.GA27811@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <20090423.070943.158757350.davem@davemloft.net>
In-Reply-To: <20090423.070943.158757350.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, May 04, 2009 at 11:34:29AM +0200, Julien Cristau wrote:
> > > As far as I can tell, the main issue is that nobody's actively working
> > > on the debian sparc port in the first place.  And without active
> > > maintainers, that port is actually a disservice to users and the sparc
> > > linux community.
> > 
> > Even if nobody is currently volunteering to explicitly state that they are
> > working on the port as a whole (which has always been a fairly vague concept
> > anyway), the software is generally working fine (yes, even if it has bugs),
> > the buildds are happily churning (and are actually actively maintained),
> > new users do actually regularly come through, so I fail to see how it's
> > a disservice to everyone.
> > 
> And yet sid's kernel has been broken for some time without anyone
> noticing.

If you're talking about #525926, that's a) a relatively normal software bug
in unstable that gets found and fixed b) something that got resolved within
two weeks. I don't see how it's a reason to panic.

> And yet nobody replies when a package maintainer needs a patch tested and
> asks on the port mailing list (which means X is broken in lenny right
> now).

If you're referring to #488669, then this is a sore spot because that hit me
as well :) unsynchronized changes to the sparc kernel and X.org (both
upstream) caused it, and nobody caught it in time for release. Having a
person in Debian dedicated to trying to track it down preemptively would
have been very helpful, but it's still a bug not completely local to Debian,
and it's not really local to the sparc porting team because to fix it one
needs changes done in generic packages, meaning you'd have to track other
maintainers' schedules and releases. It's also not unfair to say that (once
reported and explained) the fixing is primarily in the jurisdiction of the
maintainers of kernel and X packages, because it isn't standard practice to
have porters do big sourceful uploads just to fix an architecture.

> > What is that statement supposed to mean, anyway? Would you prefer if
> > the port didn't exist at all?
> > 
> Than continue to exist without anyone volunteering to maintain it?  Yes.
> But hey, you can still change that...

I don't think we would gain much from cutting it off, and just because it
doesn't match one definition of an active port.

-- 
     2. That which causes joy or happiness.
