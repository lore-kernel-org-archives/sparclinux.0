From: Rusty Russell <rusty@rustcorp.com.au>
Date: Tue, 30 Mar 2004 00:21:12 +0000
Subject: Re: Compiling modules question
Message-Id: <1080606072.24982.17.camel@bach>
List-Id: <sparclinux.vger.kernel.org>
References: <20040329201901.GD30251@artsapartment.org>
In-Reply-To: <20040329201901.GD30251@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 2004-03-30 at 08:42, Keith M Wesolowski wrote:
> On Mon, Mar 29, 2004 at 02:19:01PM -0600, Art Haas wrote:
> 
> > Here's another question for the list that I've not been able to
> > answer. When I compile a kernel with modules, the modules all have
> > problems with undefined symbols like 'udiv', 'urem', etc. As
> 
> The problem is with depmod, not with the kernel.  Your modules will
> build, load and work fine without any changes.
> 
> Rusty, this matches the change to modpost.c from a while back; does it
> look OK to you?

Ick, I missed that change to modpost.c.

I really dislike this approach: we already have the code everywhere to
ignore the first dot, and I'd prefer sparc use that same trick.

ie:

1) make rem, urem, mul, umul, div and udiv aliases to .rem, .urem etc:

   extern int rem(int, int) __attribute__((weak,alias(".rem")));

2) EXPORT_SYMBOL(rem) etc.

3) Check genksyms recognises that prototype (it should).

4) Copy "dedotify" from ppc64 to handle them on load.

The only real downside is the risk that someone else will export
those names, but I think that's pretty unlikely.

I don't have sparc here: if noone wants to do the work I can produce
a patch, but someone will need to test...

Cheers,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

