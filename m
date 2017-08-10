From: Kaz Kylheku <kaz@kylheku.com>
Date: Thu, 10 Aug 2017 14:45:16 +0000
Subject: WTD: Hacker for SPARC port of TXR Language
Message-Id: <2d4e9e2b1ff614a190d57d528ee9c7fc@mail.kylheku.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I'm looking for a SPARC wizard to help port the TXR language to SPARC 
V9.

TXR is BSD-licensed freeware.

   Home page: http://www.nongnu.org
   Git repo: http://kylheku.com/cgit/txr

Basically, the architecture dependency is in the "jmp.S" file which 
defines
some assembly code, and a definition of "struct jmp" in in "signal.h".

jmp.S defines jmp_save and jmp_restore functions, which closely resemble
setjmp and longjmp.

They are currently defined for x86, x86-64, ARM and PPC64.

These are used as the basis for implementing two major requirements:

- non-local, dynamic control transfers (for things like returns from
   named blocks and exception handling).

- delimited continuations.

The first requirement can be met with setjmp/longjmp. TXR discontinued 
the
use of setjmp/longjmp when delimited continuations were introduced.
(The reason was: glibc's security mangling of pointers in jmp_buf
interfered with pointer fixup of changed stack addresses.)

In the implementation of delimited continuations, a continuation is 
captured
by creating an object on the heap which contains a copy of a section of
the stack.

A continuation is invoked by copying the stack section into to a new 
area
at the top of the stack (carved out with alloca), performing various 
fix-ups,
and then performing a jmp_restore into that section.

This requirement for a jmp_restore to work with a relocated section of
the stack seems to be challenging and requires consideration from 
someone
who really understands SPARC and its register windows.

If you're interested, and have any questions, please contact me.

Thanks!

