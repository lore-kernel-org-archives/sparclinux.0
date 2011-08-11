From: "Roland Vossen" <rvossen@broadcom.com>
Date: Thu, 11 Aug 2011 12:29:03 +0000
Subject: Simple piece of code with unexpected behavior
Message-Id: <4E43CB0F.7050700@broadcom.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

after compiling and insmodding a module on a Sparc64 machine, the 
following piece of code:

	u8 index;
         for (index = 0; index < 128U; index++) {
                 if (index=129) {
                         printk("fishy...\n");
                         break;
                 }
         }

produces the log message: 'fishy...'.

The same piece of code does not produce this message on x86.

Is this a compiler bug, or am I overlooking something ?

Thanks, Roland.


--- info on my machine

developer@LB-BUN-44:~/code/brcm80211-next-2.6$ uname -a
Linux LB-BUN-44.bun.broadcom.com 3.0.0-rc6+ #2 Fri Jul 22 17:00:50 CEST 
2011 sparc64 GNU/Linux

--- info on my GCC version

developer@LB-BUN-44:~/code/brcm80211-next-2.6$ gcc -v
Using built-in specs.
Target: sparc-linux-gnu
Configured with: ../src/configure -v 
--enable-languages=c,c++,fortran,objc,obj-c++,treelang --prefix=/usr 
--enable-shared --with-system-zlib --libexecdir=/usr/lib 
--without-included-gettext --enable-threads=posix --enable-nls 
--with-gxx-include-dir=/usr/include/c++/4.2 --program-suffix=-4.2 
--enable-clocale=gnu --enable-libstdcxx-debug --enable-objc-gc 
--enable-mpfr --with-cpu=v8 --with-long-double-128 
--enable-checking=release --build=sparc-linux-gnu --host=sparc-linux-gnu 
--target=sparc-linux-gnu
Thread model: posix
gcc version 4.2.4 (Ubuntu 4.2.4-1ubuntu4)

