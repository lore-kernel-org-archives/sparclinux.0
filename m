From: Chris Newport <crn@netunix.com>
Date: Wed, 18 Aug 2004 23:01:06 +0000
Subject: Sun4d - assembler errors
Message-Id: <Pine.LNX.4.53.0408182355050.908@mailgate.netunix.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Could this be the smoking gun ?
Looks like the compiler does not like this inline assembly code.
Sorry, this is outside of my skills to fix.

gcc -D__KERNEL__ -I/usr/src/linux-2.4.27/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -m32 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7   -nostdinc -iwithprefix include -DKBUILD_BASENAME=sun4d_smp  -c -o sun4d_smp.o sun4d_smp.c
sun4d_smp.c: In function `smp4d_cross_call':
sun4d_smp.c:347: warning: ignoring asm-specifier for non-static local variable `f'
sun4d_smp.c:348: warning: ignoring asm-specifier for non-static local variable `a1'
sun4d_smp.c:349: warning: ignoring asm-specifier for non-static local variable `a2'
sun4d_smp.c:350: warning: ignoring asm-specifier for non-static local variable `a3'
sun4d_smp.c:351: warning: ignoring asm-specifier for non-static local variable `a4'
sun4d_smp.c:352: warning: ignoring asm-specifier for non-static local variable `a5'

Thanks,
Chris Newport
