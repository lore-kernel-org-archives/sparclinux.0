From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Date: Sat, 15 Sep 2007 21:37:55 +0000
Subject: SPARC{,64}: kernel_termios_to_user_termios_1 missing
Message-Id: <200709152137.l8FLbtXP001446@laptop13.inf.utfsm.cl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

git-describe says this is v2.6.23-rc6-168-g53a3f30
I'm getting:

  drivers/char/tty_ioctl.c: In function 'n_tty_ioctl':
  drivers/char/tty_ioctl.c:799: error: implicit declaration of function 'kernel_termios_to_user_termios_1'

This is a macro at the very end of include/asm-<foo>/termios.h for i686, on
SPARC and SPARC64 it is missing. Sorry, I've got no clue on how to define
this correctly here.

It is also missing on alpha, blackfin, parisc, sh64, sh, xtensa
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513

