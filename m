From: Roland McGrath <roland@redhat.com>
Date: Fri, 01 Aug 2008 01:21:35 +0000
Subject: sparc asm/ptrace.h use of bool
Message-Id: <20080801012135.5B76515427E@magilla.localdomain>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi, Dave.  Some of your recent changes to asm/ptrace.h made it require that
the 'bool' typedef be defined by linux/types.h or something else prior.
This broke userland, where linux/types.h does not define bool.

e.g.
http://buildd.debian.org/build.php?arch=sparc&pkg=strace&ver=4.5.17+cvs080723-1

It's easy to work around this in strace, and we have.

But you probably want to fix asm/ptrace.h before you start breaking other
things people try to recompile against the latest kernel headers.  Try:
	echo '#include <asm/ptrace.h>' | gcc -S -o - -xc - > /dev/null
to check it's usable.  (Possibly we could add something like that into
some version of make headers_check.)

You could either move those new functions inside #ifdef __KERNEL__, or if
you want them exported for userland, just make them use int instead of bool.


Thanks,
Roland
