From: Ben Collins <bcollins@debian.org>
Date: Mon, 26 Apr 2004 03:27:13 +0000
Subject: Re: cross-toolchain build script; problem with gas for sparc64
Message-Id: <20040426032713.GI3647@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Apr 25, 2004 at 08:49:07PM -0700, Dan Kegel wrote:
> Hey folks,
> I spent some time trying to get crosstool (my gcc/glibc cross toolchain
> build script) to support the sparc64-linux target.  It might be of
> interest for anyone who needs to build gcc and glibc but doesn't
> have the target handy (or who wants to do a clean build from fully
> pristine sources).  Its home page is http://kegel.com/crosstool
> 
> To build a gcc-3.4.0/glibc-2.3.2 toolchain targeting sparc64-linux
> with the current version of my script, you'd do
>   wget http://kegel.com/crosstool/crosstool-0.28-rc7.tar.gz
>   tar -xzvf crosstool-0.28-rc7.tar.gz
>   cd crosstool-0.28-rc7
>   sh demo-sparc64.sh
> 
> Sadly, this fails at the moment with
>   qp_qtoi.s:261: Error: Illegal operands: There are only 32 single 
>   precision f registers; [0-31]
> while building glibc.
> (See also http://sources.redhat.com/ml/binutils/2004-04/msg00686.html)
> Anyone seen that kind of error before?  It's odd, since the assembler is
> being passed the -Av9a -64 options, which really ought to tell it
> there are 64 fp registers, I thought.

Well, I know for a fact that glibc-2.3.2 builds on sparc64-linux with
native toolchain, so it must be something in. It's using binutils
2.14.90.0.7.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
