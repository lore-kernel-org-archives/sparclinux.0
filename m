From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 May 2012 21:34:52 +0000
Subject: Re: [RFC PATCH] sparc32: make srmmu helpers leon compatible
Message-Id: <20120520213452.GA4618@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20120519200321.GA7617@merkur.ravnborg.org>
In-Reply-To: <20120519200321.GA7617@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, May 20, 2012 at 05:24:01PM -0400, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Sun, 20 May 2012 23:18:39 +0200
> 
> > Updated RFC patch below.
> 
> Looks good.
> 
> Two small things.
> 
> First, you might want to make the LEON case the default,
> because then it'll get tested more extensively.
Good point - will do.
 
> Second, have you audited to make sure that none of this
> code runs before the patchup code does?
Yes - but a lot of other places that require patching will run
long time before (wof.S, wuf.S etc). At least I assume so.

My plan is to introduce a sparc_start_kernel() function
in setup_32.c which is called from head_32.S.

There I will do the initial stuff like patching and prom_init.
And then call the real start_kernel().

The final patchset will establish this before introducing
any users so I do not change when I patch in the middle
of the patch-set.

The current patch was to make sure I was on the right track,
hence the RFC.

	Sam
