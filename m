From: Rusty Russell <rusty@rustcorp.com.au>
Date: Sun, 12 Feb 2006 10:39:59 +0000
Subject: Re: [PATCH] sparc32: Fix div, udiv, mul, umul, rem, urem breakage
Message-Id: <1139740799.21456.4.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <20060211113817.GA25564@palantir8>
In-Reply-To: <20060211113817.GA25564@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, 2006-02-12 at 03:14 +0000, Al Viro wrote:
[snip condescending rant]

> And do an equivalent of EXPORT_SYMBOL() for use in .s, which would
> be very useful thing in its own right...

So you're going to do this and fix binutils?  Great!  Send me the patch
when you're done.

Rusty.
-- 
 ccontrol: http://ozlabs.org/~rusty/ccontrol

