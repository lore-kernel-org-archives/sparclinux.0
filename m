From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 05 Jan 2009 19:54:15 +0000
Subject: Re: ftrace breaks sparc64 build
Message-Id: <20090105195415.GA6204@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20090105181922.GA25622@uranus.ravnborg.org> <alpine.DEB.1.10.0901051428370.27085@gandalf.stny.rr.com>
In-Reply-To: <alpine.DEB.1.10.0901051428370.27085@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <srostedt@redhat.com>, Ingo Molnar <mingo@elte.hu>, "David S. Miller" <davem@davemloft.net>, sparclinux <sparclinux@vger.kernel.org>

Hi Steven.

> 
> Honestly, that code is a little obfuscated, and would be better to write 
> it as:
> 
> 	if (vp->major = 0 && vp->minor=0)
> 		return ldc_abort(lp);
> 
> 	vap = find_by_major(vp->major);
> 	if (!vap)
> 		return ldc_abort(lp);
> 
> 	[...]
> 
> This is much easier to read and we can remove the else statement 
> altogether. And I bet the warning will go away if we did it this way.

Fully ageed on the readability.
I happen to trigger this as an error in the sparc code.
But I see the same warning also in generic code.

From kernel/module.c:
        /* Suck in entire file: we'll want most of it. */
        /* vmalloc barfs on "unusual" numbers.  Check here */
        if (len > 64 * 1024 * 1024 || (hdr = vmalloc(len)) = NULL)
                return ERR_PTR(-ENOMEM);


This gives following warning:
kernel/module.c: In function `load_module':
kernel/module.c:1842: warning: 'hdr' might be used uninitialized in this function

So this is not a pattern we seen only in sparc code and I wonder if this is
the first time it is brought up?

I can fix up the cases in sparc - no problem.
But it was a suprise to me _why_ these warnings started to creep
up and then it break my build.


	Sam
