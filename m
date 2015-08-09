From: Kjetil Oftedal <oftedal@gmail.com>
Date: Sun, 09 Aug 2015 21:57:33 +0000
Subject: Re: sparc64 function alignmnet (4 or 32)?
Message-Id: <CALMQjD-p3vCno3KhCws8JAzTBV=nz9FjH0UST-timxLH+XvzyA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20150809194524.GA23425@ravnborg.org>
In-Reply-To: <20150809194524.GA23425@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 09/08/2015, Sam Ravnborg <sam@ravnborg.org> wrote:
> When browsing sparc64 assembler I can see most
> handwritten assembler routines are aligned with ".align 32".
>
> But there is also a bunch of routines that uses "ENTRY(foo) - ENDPROC(foo).
> They are all aligned with ".align 4,0x90" (see include/linux/linkage.h).
>
> I have tried to find something that mandates the 32 byte alignment - so far
> no luck.
> Are there any good reasosn for the use of the 32 bytes alignment?
>
> I also tried to decode 0x90 in the SPARC world - it is NOP in x86.
> I did not manage to decode it - but then I did not try very hard either.
>
> I would expect that .align 4,0x40 would be a better choice for
> sparc because 0x40 is sethi 0, %g0 aka nop.
> See https://en.wikipedia.org/wiki/NOP
> And 4 seems to be the necessary aligmnet for both sparc32 and sparc64.
>
> But I am left with an impression that I am missing something since
> so many routines uses 32 bytes.
>
> 	Sam

Hi,

I tried to decode 0x90909090 in the V8/V9 manual, and it came back as
ORcc %g2, %l0, %o0 (0x90908010). Doesn't make much sense?

I guess aligning with 0x00 would be better as it would generate a
illegal instruction trap if executed. If the alignment is executed something
is already wrong and the first instructions from the next function might be
executed depending alignment of functions in a given compile.

Regards,
Kjetil Oftedal
