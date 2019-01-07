From: Anatoly Pugachev <matorola@gmail.com>
Date: Mon, 07 Jan 2019 13:46:27 +0000
Subject: [sparc64] build error with v5.0-rc1-1-g3bd6e94bec12
Message-Id: <CADxRZqx+_EAE3P3m8oYFfM3tM1KXtCCtieffoyjAa3P2kjdmtw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org

Hello!

I'm unable to build current git kernel with gcc 8 :

mator@ttip:~/linux-2.6$ git desc
v5.0-rc1-1-g3bd6e94bec12

mator@ttip:~/linux-2.6$ make
  CALL    scripts/checksyscalls.sh
<stdin>:1336:2: warning: #warning syscall rseq not implemented [-Wcpp]
  CHK     include/generated/compile.h
  CC      arch/sparc/kernel/ds.o
arch/sparc/kernel/ds.c: In function ‘ldom_set_var’:
arch/sparc/kernel/ds.c:799:3: error: ‘strcpy’ writing 1 or more bytes
into a region of size 0 overflows the destination
[-Werror=stringop-overflow=]
   strcpy(p, var);
   ^~~~~~~~~~~~~~
arch/sparc/kernel/ds.c:801:3: error: ‘strcpy’ writing 1 or more bytes
into a region of size 0 overflows the destination
[-Werror=stringop-overflow=]
   strcpy(p, value);
   ^~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[2]: *** [scripts/Makefile.build:277: arch/sparc/kernel/ds.o] Error 1
make[1]: *** [scripts/Makefile.build:492: arch/sparc/kernel] Error 2
make: *** [Makefile:1042: arch/sparc] Error 2

mator@ttip:~/linux-2.6$ gcc -v
Using built-in specs.
COLLECT_GCC=gcc
COLLECT_LTO_WRAPPER=/usr/lib/gcc/sparc64-linux-gnu/8/lto-wrapper
Target: sparc64-linux-gnu
Configured with: ../src/configure -v --with-pkgversion='Debian
8.2.0-13' --with-bugurl=file:///usr/share/doc/gcc-8/README.Bugs
--enable-languages=c,ada,c++,go,d,fortran,objc,obj-c++ --prefix=/usr
--with-gcc-major-version-only --program-suffix=-8
--program-prefix=sparc64-linux-gnu- --enable-shared
--enable-linker-build-id --libexecdir=/usr/lib
--without-included-gettext --enable-threads=posix --libdir=/usr/lib
--enable-nls --enable-clocale=gnu --enable-libstdcxx-debug
--enable-libstdcxx-time=yes --with-default-libstdcxx-abi=new
--enable-gnu-unique-object --disable-libquadmath
--disable-libquadmath-support --enable-plugin --enable-default-pie
--with-system-zlib --disable-libphobos --enable-objc-gc=auto
--enable-multiarch --disable-werror --with-cpu-32=ultrasparc
--enable-targets=all --with-long-double-128 --enable-multilib
--enable-checking=release --build=sparc64-linux-gnu
--host=sparc64-linux-gnu --target=sparc64-linux-gnu
Thread model: posix
gcc version 8.2.0 (Debian 8.2.0-13)
