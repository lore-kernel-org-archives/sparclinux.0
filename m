From: Brian Bartholomew <bb@stat.ufl.edu>
Date: Tue, 02 Mar 2004 04:56:39 +0000
Subject: Re: Fw: [Bugme-new] [Bug 2205] New: compile failure, gcc 3.2.3, gentoo SPARC, Sun Ultra 5
Message-Id: <200403020456.i224udAn024665@stat.ufl.edu>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> My guess is that you have:
> 
> gcc-3.2.3-r2
> egcs64-1.1.2_whatever
> 
> and think that because gcc --version says 3.2.3 you're ok.  That's no
> good on sparc64.  You need to update your 64-bit compiler to 3.2 or
> higher to build 2.6.  So emerge -C egcs64; emerge gcc-sparc64.

I have updated the compilers and am now compiling unmodified kernel
source.  If that works, which I fully expect it to, I'll describe the
mistake and the fix in the ticket, and mark it closed.  Thanks!

							Brian
