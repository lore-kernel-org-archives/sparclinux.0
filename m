From: Levent Serinol <lserinol@yahoo.com>
Date: Tue, 02 Mar 2004 07:38:38 +0000
Subject: Re: Fw: [Bugme-new] [Bug 2205] New: compile failure, gcc 3.2.3, gentoo SPARC, Sun Ultra 5
Message-Id: <20040302073838.31426.qmail@web41506.mail.yahoo.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200403020456.i224udAn024665@stat.ufl.edu>
In-Reply-To: <200403020456.i224udAn024665@stat.ufl.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


gcc -v
Reading specs from
/usr/lib/gcc-lib/sparc-unknown-linux-gnu/3.2.3/specs
Configured with:
/var/tmp/portage/gcc-3.2.3-r2/work/gcc-3.2.3/configure
--prefix=/usr
--bindir=/usr/sparc-unknown-linux-gnu/gcc-bin/3.2
--includedir=/usr/lib/gcc-lib/sparc-unknown-linux-gnu/3.2.3/include
--datadir=/usr/share/gcc-data/sparc-unknown-linux-gnu/3.2
--mandir=/usr/share/gcc-data/sparc-unknown-linux-gnu/3.2/man
--infodir=/usr/share/gcc-data/sparc-unknown-linux-gnu/3.2/info
--enable-shared --host=sparc-unknown-linux-gnu
--target=sparc-unknown-linux-gnu --with-system-zlib
--enable-languages=c,c++,f77,objc
--enable-threads=posix --enable-long-long
--disable-checking --enable-cstdio=stdio
--enable-clocale=generic --enable-__cxa_atexit
--enable-version-specific-runtime-libs
--with-gxx-include-dir=/usr/lib/gcc-lib/sparc-unknown-linux-gnu/3.2.3/include/g++-v3
--with-local-prefix=/usr/local --enable-shared
--enable-nls --without-included-gettext
Thread model: posix
gcc version 3.2.3 20030422 (Gentoo Linux 1.4 3.2.3-r2,
propolice)



sparc64-linux-gcc  -v
Reading specs from
/usr/lib/gcc-lib/sparc64-unknown-linux-gnu/3.2.3/specs
Configured with:
/var/tmp/portage/gcc-sparc64-3.2.3/work/gcc-sparc64-3.2.3/configure
--prefix=/usr --disable-shared --disable-multilib
--target=sparc64-unknown-linux-gnu
--enable-languages=c --enable-threads=single
--host=sparc-unknown-linux-gnu
Thread model: single
gcc version 3.2.3 20030422 (Gentoo Linux 1.4 @PV@)

ld -v
GNU ld version 2.14.90.0.7 20031029

as -v
GNU assembler version 2.14.90.0.7
(sparc-unknown-linux-gnu) using BFD version
2.14.90.0.7 20031029

and I can compile every vanilla kernel and run them
without a problem.





--- Brian Bartholomew <bb@stat.ufl.edu> wrote:
> > My guess is that you have:
> > 
> > gcc-3.2.3-r2
> > egcs64-1.1.2_whatever
> > 
> > and think that because gcc --version says 3.2.3
> you're ok.  That's no
> > good on sparc64.  You need to update your 64-bit
> compiler to 3.2 or
> > higher to build 2.6.  So emerge -C egcs64; emerge
> gcc-sparc64.
> 
> I have updated the compilers and am now compiling
> unmodified kernel
> source.  If that works, which I fully expect it to,
> I'll describe the
> mistake and the fix in the ticket, and mark it
> closed.  Thanks!
> 
> 							Brian


=="Stay out of the road, if you want to grow old." - Pink Floyd
