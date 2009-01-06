From: Rusty Russell <rusty@rustcorp.com.au>
Date: Tue, 06 Jan 2009 01:34:50 +0000
Subject: Re: [PATCH] module: clean up initialization of variable
Message-Id: <200901061152.51782.rusty@rustcorp.com.au>
List-Id: <sparclinux.vger.kernel.org>
References: <20090105181922.GA25622@uranus.ravnborg.org> <20090105195415.GA6204@uranus.ravnborg.org> <alpine.DEB.1.10.0901051523370.25066@gandalf.stny.rr.com>
In-Reply-To: <alpine.DEB.1.10.0901051523370.25066@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <srostedt@redhat.com>, Ingo Molnar <mingo@elte.hu>, "David S. Miller" <davem@davemloft.net>, sparclinux <sparclinux@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Tuesday 06 January 2009 07:00:25 Steven Rostedt wrote:
> This is sloppy initialization because it initializes, not only in an
> if condition, but also as the second part of a complex conditional.
> 
> This patch makes the code a bit easier to read.
...
>  	/* Suck in entire file: we'll want most of it. */
>  	/* vmalloc barfs on "unusual" numbers.  Check here */
> -	if (len > 64 * 1024 * 1024 || (hdr = vmalloc(len)) = NULL)
> +	if (len > 64 * 1024 * 1024)
> +		return ERR_PTR(-ENOMEM);
> +	hdr = vmalloc(len);
> +	if (hdr = NULL)
>  		return ERR_PTR(-ENOMEM);
>  	if (copy_from_user(hdr, umod, len) != 0) {
>  		err = -EFAULT;

This line is not accidental nor casually written: the two statements are deliberately entwined.  It is a succint complaint against the vagaries of vmalloc.

So this patch is a messup, not a cleanup.

But it's really upset me because it is lazy and timid: and too much kernel code is becoming mired in such scars.  Instead of "how do I kill this warning and get it in the merge window" you should be thinking "how do I make the kernel better", and "I wonder if vmalloc still has this problem"...

And I so look forward to the warm fuzzies I get when applying a real cleanup patch.

Thanks,
Rusty.
