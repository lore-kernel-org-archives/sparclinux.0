From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Tue, 13 Jul 2004 20:41:49 +0000
Subject: Re: sparc32 status
Message-Id: <20040713204149.GA31934@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040713160257.GA8148@foobazco.org>
In-Reply-To: <20040713160257.GA8148@foobazco.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Jul 13, 2004 at 09:00:07PM +0100, C.Newport wrote:

> > /*
> >  * XXX This functions appears to be a distorted version of
> >  * prom_sbus_ranges_init(), with all sun4d stuff cut away.
> >  * Ask DaveM what is going on here, how is sun4d supposed to work... XXX
> >  */
> 
> I tracked down a man in Sun who designed this stuff and gave his contact info 
> to Keith. Sun4D should now be fixable.

I'm sure he can help, especially with SMP, but most of the breakage is
Linux-specific and has little to do with lack of hardware knowledge.
The above example points out code that worked in 2.2 and has since
been broken.  Under the circumstances, I can only assume the reason I
haven't gotten a patch for this is that nobody cares.  Which is why I
spent nearly all my time on 4m, a platform that people actually seem
to use.  4d is also impossible to work on in summer; it's too hot and
costs too much to run, even for a short time.

> > ... blow away all of the a.out build support cruft.
> > There is zero use for any of this ancient crap anymore.
> >
> > This means C_SYMBOL() et al. may die as well.

> ISTM that this effectively blows Sun4 support out of the water.
> Sun4 has not worked in a long while - Decision time ?.
> Do we need Sun4 support ? - I have a 4/110 here tested with SunOS4.1.4
> if someone would like to make the effort.

This has no effect on sun4 support.  In fact I recently made sun4
build again for the first time in ages.

The only effect of this change is that you can no longer _build_ a
kernel using ancient tools.  Such tools might be found on SunOS, which
might be running on a sun4, but there's nothing specific to sun4 about
it.  It's doubtful you could get a working kernel out of anything that
old anyway.  True, you can't _boot_ an ELF kernel directly on sun4,
but then, you can't boot them directly anywhere else either.  Which is
why we have elftoaout and things like tilo that use it.

Sun4 is another platform, like 4d, that nobody cares about.  The lack
of interest in fact is so great that I actually have a tree somewhere
that supports only 4m.  I'd already decided that sun4 surely would be
gone in 2.7, and that 2.7.0 would come out with a public statement to
the effect that 2.8 would be the last kernel with 4c support.  But
this won't be my decision to make.

> Add to list :- fc.c, fcal.c, pluto.c  Needs updating to new SCSI API.
> 	Most sun4d machines came with fc and pluto storage so they are
>        rather cramped  for disk space without this. 

Yes.  But really the Big Three needed fixes are:

1. Integrate the smp32 patch, and get userland reliable with it.
2. Fix the hypersparc DMA problem.
3. Identify and correct the huge performance degradation from 2.2->2.4.

Beyond this things like an srmmu rewrite, iommu resource index,
flush_dcache_page, and thread_info start to come into the picture.

-- 
Keith M Wesolowski
