From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Wed, 15 Feb 2006 11:56:59 +0000
Subject: Re: [PATCH] sparc32: Fix div, udiv, mul, umul, rem, urem breakage
Message-Id: <20060215115659.GC6465@palantir8>
List-Id: <sparclinux.vger.kernel.org>
References: <20060211113817.GA25564@palantir8>
In-Reply-To: <20060211113817.GA25564@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

So is anyone coming up with other patches regarding this?
I like the idea of having an asm equivalent of EXPORT_SYMBOL().

If no other fixes are forthcoming, please apply either Rusty's
patch or mine. I'd still prefer mine because it's simpler, which
for me outweighs the namespace pollution issue.

Martin

On Sun, Feb 12, 2006 at 09:39:59PM +1100, Rusty Russell wrote:
> On Sun, 2006-02-12 at 03:14 +0000, Al Viro wrote:
> [snip condescending rant]
> 
> > And do an equivalent of EXPORT_SYMBOL() for use in .s, which would
> > be very useful thing in its own right...
> 
> So you're going to do this and fix binutils?  Great!  Send me the patch
> when you're done.
