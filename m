From: Jim Watson <jim@amarooas.com.au>
Date: Wed, 12 May 2004 22:04:58 +0000
Subject: mystery backtrace
Message-Id: <20040512220458.GA4624@amarooas.com.au>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

this is from openoffice.org 680 on linux sparc

Any advice would be appreciated, is this valid output of the "list" command
[1], and what can i do next?

0x00000000 in ?? ()
(gdb) where
#0  0x00000000 in ?? ()
(gdb) list
1       /build/buildd/glibc-2.3.2.ds1/build-tree/sparc-libc/csu/crti.S: No
such file or directory.
        in /build/buildd/glibc-2.3.2.ds1/build-tree/sparc-libc/csu/crti.S
(gdb)


thanks

jim

[1] Full report follows:

jim@sun:~/680/cppu/unxlngs.pro/bin$ gdb ./testcppu
GNU gdb 2003-09-18-cvs
Copyright 2003 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "sparc-unknown-linux-gnu"...Using host
libthread_db library "/lib/libthread_db.so.1".

(gdb) run
Starting program: /home/jim/680/cppu/unxlngs.pro/bin/testcppu 
[Thread debugging using libthread_db enabled]
[New Thread 16384 (LWP 7542)]

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 16384 (LWP 7542)]
0x00000000 in ?? ()
(gdb) where
#0  0x00000000 in ?? ()
(gdb) list
1       /build/buildd/glibc-2.3.2.ds1/build-tree/sparc-libc/csu/crti.S: No
such file or directory.
        in /build/buildd/glibc-2.3.2.ds1/build-tree/sparc-libc/csu/crti.S
(gdb) 
