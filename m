From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Mon, 03 May 2004 14:48:21 +0000
Subject: Re: __builtin_trap() broken?
Message-Id: <20040503144820.GA20865@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040430151028.GA10534@osinvestor.com>
In-Reply-To: <20040430151028.GA10534@osinvestor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Apr 30, 2004 at 11:10:28AM -0400, Rob Radez wrote:

> Trying to compile fs/reiserfs/journal.c in 2.6.6-rc1 (UP, sparc32, gcc
> 3.3.3) ICE'd with an 'unrecognizable insn'.  It looks like there's a bad
> interaction with __builtin_trap() again, for at least gcc 3.3.3 from

>  * Configured with: ../src/configure -v --enable-languages=c,c++,java,f77,pascal,objc,ada,treelang --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --with-gxx-include-dir=/usr/include/c++/3.3 --enable-shared --with-system-zlib --enable-nls --without-included-gettext --enable-__cxa_atexit --enable-clocale=gnu --enable-debug --enable-java-gc=boehm --enable-java-awt=xlib --with-cpu=v7 --enable-objc-gc sparc-linux
>  * Thread model: posix
>  * gcc version 3.3.3 (Debian 20040401) */

I can't reproduce this.  Bogus Debian patches?  gcc build options?
Your test case looks good; please try with stock gcc 3.3.3 built with
those same options that Debian uses (ie --with-kitchen-sink).  If it
still fails then I guess we'll have to change this again.

This is my compiler, which works:

Reading specs from /crossdev/sparc-linux/lib/gcc-lib/sparc-linux/3.3.3/specs
Configured with: /crossdev/build/src/gcc/configure --prefix=/crossdev/sparc-linux --with-newlib --disable-shared --enable-languages=c --disable-threads --disable-multilib --target=sparc-linux --srcdir=/crossdev/build/src/gcc
Thread model: single
gcc version 3.3.3

-- 
Keith M Wesolowski
