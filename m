From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 13 Jun 2008 18:46:55 +0000
Subject: Re: [RFC] unify exported sparc header files?
Message-Id: <20080613184655.GA8780@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20080601072044.GA16220@uranus.ravnborg.org>
In-Reply-To: <20080601072044.GA16220@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Jun 13, 2008 at 01:10:21AM +0300, Adrian Bunk wrote:
> >...
> > This was not something easy shareable anyway.
> > And you are in no hurry - I do not expect David to look at
> > this until mid/late of the week (I gues hes has a bit
> > queued up to finish first when he gets home).
> >...
> 
> Finally got around to start working on this.
> 
> A first batch of unification patches based on your patches is coming, 
> any comments on them are appreciated.
I decided to join asi.h together in my patchset - so these are dropped.

And then I cannot find my way around "make headers_check" when I split up
the files in _32 and _64 because we do so for a limited set of files
and not all of them.

So if I do not come up with anything clever I will most
likely just join them together too but with proper ifdef guards
around them.

The problem is that I need to do:

#ifndef _ASM_SPARC_OPENPROM_H
#define _ASM_SPARC_OPENPROM_H
#if defined(__sparc__) && defined(__arch64__)
#include <asm-sparc/openprom_64.h>
#else
#include <asm/openprom_32.h>
#endif
#endif


This works well for the build case.
But headers_check complain that it cannot find <asm-sparc/openprom_64.h>
becuase we copy all files to asm/ and not asm-sparc/ when we export for
sparc.

And it needs to be "<asm-sparc/" because "<asm/" points to the wrong
directory when we build sparc64.

One way around it would be to drop asm-sparc64/ entirely and do the
_32, _64 trick for all files that differ.
But I do not have time to do so and I'm not sure David approves it.

	Sam
