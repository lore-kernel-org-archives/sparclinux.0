From: "David S. Miller" <davem@davemloft.net>
Date: Sun, 06 Nov 2005 20:58:48 +0000
Subject: Re: div, udiv, mul, umul, rem, urem broken again?!?
Message-Id: <20051106.125848.29593875.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1128550254.2140.103.camel@localhost.localdomain>
In-Reply-To: <1128550254.2140.103.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Rusty Russell <rusty@rustcorp.com.au>
Date: Sun, 06 Nov 2005 17:27:20 +1100

> Argh, it would need to use the alias trick, yes.  As I said, untested.
> But, looking in 2.6.12, sparc already did this aliasing?

And that aliasing trick is what we were trying to get rid
of.  It's nearly impossible to get it to work on all versions
of the compiler at once.

I thought you had proposed a way to do it without aliases :-)

> So my question is (I missed the beginning of this thread), why do you
> want to avoid the simple "omit the . at the front" name mangling scheme
> which modpost, kernel/module.c and module-init-tools already understand,
> and use a different mangling scheme?  Name clash with something else?
> Why is "_Udiv" a better name than "udiv"?

Good question, I'll think about this some more.
