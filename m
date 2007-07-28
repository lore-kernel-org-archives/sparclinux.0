From: "Julian Calaby" <julian.calaby@gmail.com>
Date: Sat, 28 Jul 2007 03:39:31 +0000
Subject: Build failures on a sparcstation10 with 2.6.23-rc1
Message-Id: <646765f40707272039u27113c20ie98cbd42b9742c0f@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi all,

I'm not sure exactly who this should be addressed to but I assume that
this list will get this to them.

Ok:

I have a Sun SparcServer 10, running Debian Testing. Recently Debian
has dropped kernel support for sparc32, (as in the kernels have
disappeared off their archive) and I am attempting to compile my own.

My first issue is the difficulty I am having in getting them small
enough: I am using Debian's make-kpkg build system, and am compiling
everything as modules in an attempt to get it to boot through SILO. I
have selected optimization by size, however this has had no effect.

I believe that my current incarnation of my .config will produce a
sufficiently small kernel, however I cannot get the modules to build
due to various build errors during the MODPOST stage of compilation.

These errors relate to iounmap and ioremap being unavailable. (and
another symbol which I cannot remember)

This makes no sense as these functions are definitely compiled into the kernel.

I will provide more detailed error messages later as this system is
currently attempting another kernel compilation.

My questions are:

Are there any pending patches I can try which might fix this? (I am
using the sparc-2.6 git tree, updated as of half an hour ago)

Are there any tricks, gotchas or general information I need to know
for compiling to for this architecture / system?

Thanks in advance,

--

Julian Calaby

Email: julian.calaby@gmail.com
