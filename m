From: Hugh Dickins <hugh.dickins@tiscali.co.uk>
Date: Wed, 16 Sep 2009 11:26:36 +0000
Subject: Re: [PATCH 0/3] /proc/kmem cleanups and hwpoison bits
Message-Id: <Pine.LNX.4.64.0909161211100.12659@sister.anvils>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="8323584-1472666607-1253100396=:12659"
List-Id: <sparclinux.vger.kernel.org>
References: <20090915021851.168285585@intel.com> 
 <20090915120939.bcc571e1.kamezawa.hiroyu@jp.fujitsu.com> 
 <20090915082200.GA2588@localhost>  <Pine.LNX.4.64.0909151057020.26095@sister.anvils>
 <10f740e80909160201l4834369s75e63fe8df0991aa@mail.gmail.com>
In-Reply-To: <10f740e80909160201l4834369s75e63fe8df0991aa@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wu Fengguang <fengguang.wu@intel.com>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Andrew Morton <akpm@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>, Nick Piggin <npiggin@suse.de>, LKML <linux-kernel@vger.kernel.org>, linux-m68k@vger.kernel.org, sparclinux@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1472666607-1253100396=:12659
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 16 Sep 2009, Geert Uytterhoeven wrote:
> On Tue, Sep 15, 2009 at 12:16, Hugh Dickins <hugh.dickins@tiscali.co.uk> =
wrote:
> > Warning: it may be rubbish, it may just be a hack which appeared to
> > work for me the last time I tried, on a particular address range of a
> > particular set of configurations of a particular set of architectures
> > (x86_32, x86_64, powerpc64). =C2=A0I've never thought it through enough=
 to
> > consider submitting, but it _might_ contain something useful for you
> > to factor into your own efforts.
> >
> > Sorry for chucking it over the wall to you in this way, but I guess
> > that's better than just sitting quietly on it for a few more years.
> >
> > Certainly-Not-Signed-off-by: Hugh Dickins <hugh.dickins@tiscali.co.uk>

I think that gives a good idea of the status of this patch:
I'm not making any policy decisions here or submitting to any tree.

> > --- 2.6.31/drivers/char/mem.c =C2=A0 2009-09-09 23:13:59.000000000 +010=
0
> > +++ 2.6.31d/drivers/char/mem.c =C2=A02009-09-10 09:38:30.000000000 +010=
0
>=20
> > -#ifdef __ARCH_HAS_NO_PAGE_ZERO_MAPPED
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* we don't have pag=
e 0 mapped on sparc and m68k.. */
>=20
> Is this `feature' removed?

The feature that some arches don't have page zero mapped?
No, I could hardly change that from drivers/char/mem.c,
and wouldn't wish to.

The feature that reading from one unmapped page gave zeroes
and writing to it threw away what you wrote?  Yes, in making
that patch, I was thinking that if we cope with unmapped areas
elsewhere by returning -ENXIO, it made little sense to have
special code to do something different for page zero.

But of course there might be userspace compatibility reasons
why that couldn't change e.g. a body of /dev/kmem users who
would be surprised by an error right at the "start" (though
in kmem's case, they've already had to seek to get anywhere).

Take the patch as saying "hmm, I wonder if we could do it this way".

Hugh
--8323584-1472666607-1253100396=:12659--
