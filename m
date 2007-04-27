From: Arkadi Shishlov <arkadi@mebius.lv>
Date: Fri, 27 Apr 2007 11:13:47 +0000
Subject: glibc ucontext on sparc
Message-Id: <4631DAEB.3090307@mebius.lv>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Does ucontext functions (getcontext, setcontext, etc.) are implemented in glibc for 32-bit userland? 
I see the ucontext files in sysdeps/unix/sysv/linux/sparc64/ but it is for 64-bit?

Glibc 2.5 on Gentoo gives me not implemented warning at link time and functions just fall through 
doing nothing while executing. I'm not sure is it expected or bug should be filled upstream or with 
Gentoo.
