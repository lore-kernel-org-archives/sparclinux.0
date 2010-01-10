From: Jan Engelhardt <jengelh@medozas.de>
Date: Sun, 10 Jan 2010 23:15:17 +0000
Subject: Re: fstat seems broken on sparc64
Message-Id: <alpine.LSU.2.01.1001102347280.23052@obet.zrqbmnf.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LSU.2.01.0912141511280.27692@obet.zrqbmnf.qr> <20091214.233840.236673621.davem@davemloft.net> <alpine.LSU.2.01.1001082355250.20848@obet.zrqbmnf.qr> <20100110.131158.242584083.davem@davemloft.net>
In-Reply-To: <20100110.131158.242584083.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sunday 2010-01-10 22:11, David Miller wrote:
>
>> libc6   2.10.2-4
>
>Perfect, now you just have to audit what changed between the -2 and
>the -4 package to find the bug :-)

I really do not believe you when you say your glibc is not affected.
Maybe some things did not became clear as part of the discussion,
so let me quickly restate:

 - talking about -m64 / libc6-sparc64_2.10.2-*_sparc.deb only

 - syscall is screwed up. strace outputs:

C func  | i386      | x86_64     | sparc32   | sparc64
--------+-----------+------------+-----------+---------------
stat    | stat64    | stat       | stat64    | stat64
lstat   | lstat64   | lstat      | lstat64   | lstat64
fstatat | fstatat64 | newfstatat | fstatat64 | fstatat64
fstat   | fstat64   | fstat      | fstat64   | fstat (*)


 - I now found and fixed the problem, here is the patch for
   you to study (as code speaks louder)

Index: glibc-2.10.1/sysdeps/unix/sysv/linux/sparc/sparc64/fxstat.c
=================================--- glibc-2.10.1.orig/sysdeps/unix/sysv/linux/sparc/sparc64/fxstat.c
+++ glibc-2.10.1/sysdeps/unix/sysv/linux/sparc/sparc64/fxstat.c
@@ -1 +1 @@
-#include "../../fxstat.c"
+#include "../../i386/fxstat.c"

(Hint: Compare with sparc64/lxstat.c)
