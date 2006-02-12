From: Al Viro <viro@ftp.linux.org.uk>
Date: Sun, 12 Feb 2006 03:14:43 +0000
Subject: Re: [PATCH] sparc32: Fix div, udiv, mul, umul, rem, urem breakage
Message-Id: <20060212031443.GT27946@ftp.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20060211113817.GA25564@palantir8>
In-Reply-To: <20060211113817.GA25564@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Feb 12, 2006 at 12:07:44PM +1100, Rusty Russell wrote:
> > You do realize that your "remove the dot" is ppc-only?  I.e. just as much
> > of a special case as sparc-only mapping.
> 
> No Al.  Since day 1 we've had this in module-init-tools.  It was used by
> both PPC and Sparc.

... by PPC to deal with odd mangling of everything, in sparc - as a kludge
for several libgcc symbols.
 
> Sparc stopped using it to work around sparc-specific binutils bugs.  I'm
> naturally resistent to (more) arch-specific hacks in depmod.  In the
> kernel, arch-specifics get testing, in module-init-tools they don't.

It's not about sparc-specific binutils bug.  At all.  The thing responsible
for that is gcc, not binutils.

> > Seriously, fix in depmod is considerably smaller that what you've just
> > posted, not to mention being conceptually simpler.
> 
> You're exactly right.  By this logic, I look forward to you fixing
> binutils.

What the hell does it have to do with binutils?  There are two unrelated
things:
	* on ppc, gcc -S prepends . to public symbols - i.e. if foo.c
defines bar(), you'll get .bar in foo.s.
	* on sparc, names used for primitives implemented in libgcc (and
emitted by gcc when generating a call of such primitive) start with .

Both sit in gcc; the only place where binutils had ever entered the picture
was stricter handling of weak aliases.  That broke original kludges in
sparc_ksyms, but it's completely unrelated to problem with mangling on
sparc.

If you are suggesting to rename symbols in sparc libgcc - sorry, can't do.
They are part of ABI, for all practical purposes.

What I really don't get is why do we want to bother with mangling at all.
I.e. why not define MODULE_SYMBOL_PREFIX to "." on ppc and be done with
that?  And do an equivalent of EXPORT_SYMBOL() for use in .s, which would
be very useful thing in its own right...
