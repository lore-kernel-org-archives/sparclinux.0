From: Dennis Jenkins <dennis.jenkins@sbcglobal.net>
Date: Thu, 17 Feb 2005 01:06:55 +0000
Subject: gcc 3.3.5, Linux kernel 2.6.11, sched.h Sparc64 compile error (details)
Message-Id: <20050217010655.54594.qmail@web81309.mail.yahoo.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello Everyone,

     I posted to this mailing list this morning (well,
it was morning for me, about 12 hours ago?).  My post
has yet to show up.  Anyway, here are the details of
the compiler error that I get when trying to compile
an unpatched linux kernel (from ftp.kernel.org) on a
sparc64 box with a brand new install of Gentoo Linux.

Does anyone else have this problem?

If I were to regress gcc, what version should I fall
back to?  

Does anyone have a suggested fix?  I'm a good c/c++
programmer; I'm willing to take a whack at this.  I'm
just looking for some guidence or pointers if anyone
has any.

Thank you for your time.


wopr src # rm linux
wopr src # ln -s linux-2.6.11-rc3/ linux
wopr src # cd linux
wopr linux # make
  CHK     include/linux/version.h
  CC      init/main.o
In file included from include/linux/module.h:10,
                 from init/main.c:16:
include/linux/sched.h: In function
`lock_need_resched':
include/linux/sched.h:1127: error: request for member
`break_lock' in 
something not a structure or union
make[1]: *** [init/main.o] Error 1
make: *** [init] Error 2

wopr linux # gcc --version
gcc (GCC) 3.3.5  (Gentoo Linux 3.3.5-r1, ssp-3.3.2-3,
pie-8.7.7.1)
Copyright (C) 2003 Free Software Foundation, Inc.
This is free software; see the source for copying
conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR
A PARTICULAR PURPOSE.



==Dennis Jenkins
