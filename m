From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 09 Aug 2015 19:45:24 +0000
Subject: sparc64 function alignmnet (4 or 32)?
Message-Id: <20150809194524.GA23425@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

When browsing sparc64 assembler I can see most
handwritten assembler routines are aligned with ".align 32".

But there is also a bunch of routines that uses "ENTRY(foo) - ENDPROC(foo).
They are all aligned with ".align 4,0x90" (see include/linux/linkage.h).

I have tried to find something that mandates the 32 byte alignment - so far no luck.
Are there any good reasosn for the use of the 32 bytes alignment?

I also tried to decode 0x90 in the SPARC world - it is NOP in x86.
I did not manage to decode it - but then I did not try very hard either.

I would expect that .align 4,0x40 would be a better choice for
sparc because 0x40 is sethi 0, %g0 aka nop.
See https://en.wikipedia.org/wiki/NOP
And 4 seems to be the necessary aligmnet for both sparc32 and sparc64.

But I am left with an impression that I am missing something since
so many routines uses 32 bytes.

	Sam
