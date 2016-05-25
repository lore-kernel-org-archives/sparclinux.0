From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Wed, 25 May 2016 13:43:28 +0000
Subject: clone syscall interface on sparc64
Message-Id: <35ee1e4a-f48a-7a61-a827-415930ad66e7@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi!

I'm currently looking into fixing a testsuite failure in systemd on sparc64.

For that, I need to fix how the clone syscall is invoked on sparc64 since the
systemd code makes wrong assumptions about that.

From the clone manpage [1]:

   blackfin, m68k, and sparc
       The argument-passing conventions on blackfin, m68k, and sparc are
       different from the descriptions above.  For details, see the kernel
       (and glibc) source.

I have been browsing through the kernel sources and glibc, but I couldn't really
find a clue which would help me to understand how clone() is properly invoked
on sparc64.

Does anyone have a hint?

Thanks,
Adrian

> [1] http://man7.org/linux/man-pages/man2/clone.2.html

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
