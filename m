From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Wed, 13 Feb 2008 02:57:39 +0000
Subject: Re: [patch] sparc: fix build
Message-Id: <20080213025739.GO27894@ZenIV.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20080207231230.GE7198@cs181133002.pp.htv.fi> <alpine.DEB.1.00.0802071538440.15050@chino.kir.corp.google.com> <20080210153355.GA6737@palantir8> <alpine.DEB.1.00.0802101117510.5043@chino.kir.corp.google.com> <47AF7048.3060200@earthlink.net> <alpine.DEB.1.00.0802101529310.17892@chino.kir.corp.google.com> <20080212184654.85d5ae20.akpm@linux-foundation.org>
In-Reply-To: <20080212184654.85d5ae20.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Rientjes <rientjes@google.com>, Adrian Bunk <bunk@kernel.org>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, Robert Reif <reif@earthlink.net>

On Tue, Feb 12, 2008 at 06:46:54PM -0800, Andrew Morton wrote:
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -20,9 +20,6 @@
> >  #ifndef _LINUX_MEMCONTROL_H
> >  #define _LINUX_MEMCONTROL_H
> >  
> > -#include <linux/rcupdate.h>
> > -#include <linux/mm.h>
> > -
> >  struct mem_cgroup;
> >  struct page_cgroup;
> >  struct page;
> 
> This really should have been in a separate patch and extensively tested.
> 
> Have we checked that every file which directly or indirectly includes
> memcontrol.h does not have an requirement for rcupdate.h and mm.h, where
> that requirement was satisfied only via this nested inclusion?  For all
> architectures and for all config selections?  Think not.
> 
> Sadly, removal of nested includes is a *big* deal, and it takes quite a lot
> of time to get it all shaken down.
> 
> If we can confirm that all files (.c and .h) which include memcontrol.h
> also directly include rcupdate.h and mm.h then we're _probably_ ok (modulo
> ordering issues).
> 
> Otherwise we should perhaps be taking a second look at how to fix the sparc
> problem.

I've run allmodconfig builds on a bunch of target, FWIW (essentially the
same patch).  Note that these includes are recent addition caused by
added inline function that had since then become a define.  So while I
agree with your comments in general, in _this_ case it's pretty safe.

Commit that had done it is 3062fc67dad01b1d2a15d58c709eff946389eca4
and switch to #define is 60c12b1202a60eabb1c61317e5d2678fcea9893f (BTW,
that warranted mentioning in changelog of the latter).
