From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 15 Jan 2009 22:06:57 +0000
Subject: Re: ilog2() problems with gcc-3.4.5
Message-Id: <20090115140657.1f1f438e.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20090115133037.42ee52aa.akpm@linux-foundation.org>
In-Reply-To: <20090115133037.42ee52aa.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 15 Jan 2009 22:54:44 +0100
Sam Ravnborg <sam@ravnborg.org> wrote:

> On Thu, Jan 15, 2009 at 01:30:37PM -0800, Andrew Morton wrote:
> > 
> > My sparc64 gcc-3.4.5 cross-compiler has decided to start emitting calls
> > to ____ilog2_NaN, due to
> > 
> >         eq_context->log_eq_size   = ilog2(eq->nent);
> > 
> > in drivers/net/mlx4/eq.c.  There's another reference coming out of
> > drivers/net/mlx4/srq.s.
> > 
> > I guess this is a gcc bug - it's gone and decided that
> > __builtin_constant_p(eq->nent) is true :(
> > 
> > We've had this __builtin_constant_p() bogon occur before now - it
> > happened with one or two kmalloc() callsites on x86 for some gcc
> > versions, but we seemed to make it go away by some means.
> 
> Googled a bit.
> Seems to be influenced by use of -Os versus -O2.
> 

Thanks.

<checks>

It's happening with both -Os and -O2.
