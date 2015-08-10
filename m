From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 10 Aug 2015 08:22:20 +0000
Subject: Re: sparc64 function alignmnet (4 or 32)?
Message-Id: <20150810082220.GA31123@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20150809194524.GA23425@ravnborg.org>
In-Reply-To: <20150809194524.GA23425@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Aug 09, 2015 at 03:19:18PM -0700, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Sun, 9 Aug 2015 21:45:24 +0200
> 
> > When browsing sparc64 assembler I can see most
> > handwritten assembler routines are aligned with ".align 32".
> 
> The required alignment is 4 bytes.
> 
> Some routines are aligned to 32 bytes in order to have them begin at
> exactly an I-cache line boundary to increase I-cache utilization.
> This is done especially for "hot" routines like memcpy, memset, etc.

Makes perfect sense - thanks.
I may try to dive into this a little to make this a bit more explicit.
Something like:

ENTRY(foo) - 4 byte aligned. Use 0x0 as filler.
ENTRY_CACHE_ALIGNED - 32 bytes aligned, use 0x0 as filler.

Today ENTRY() uses 0x90 as fille but as Kjetill writes in another
mail this is a weird instruction.

Before I can change the filler to 0x0 then I need to audit all uses of ENTRY(),
because if anyone uses fallthrough then this would not work.

Let me come up with a patch later then we can judgde if this
is worthwhile then.

	Sam

