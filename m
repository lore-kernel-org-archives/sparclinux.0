From: "C.Newport" <crn@netunix.com>
Date: Sun, 14 Nov 2004 21:29:02 +0000
Subject: Problems building SILO
Message-Id: <200411142129.02151.crn@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Am I alone in being unable to build silo-1.4.8 ?
Running kernel 2.4.27, gcc 3.2.3
I have also tried using kernel-headers from 2.2.20, 2.4.4 and 2.4.22
and get the same results.

gcc -m32 -Os -Wall -I. -I../include -fomit-frame-pointer -fno-strict-aliasing 
-DSMALL_RELOC=0x280000 -DLARGE_RELOC=0x380000 -c ls.c -o ls.o
In file included from ls.c:25:
/usr/include/linux/types.h:32: conflicting types for `size_t'
../include/stringops.h:11: previous declaration of `size_t'
make[1]: *** [ls.o] Error 1
make[1]: Leaving directory `/work/current/source/a/silo/tmp/silo-1.4.8/second'
make: *** [all] Error 1

This leads me into a twisty maze of include files, I cannot figure out what 
is going wrong.

Has anyone seen this before or have some clues ?

