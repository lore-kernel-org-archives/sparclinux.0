From: spender@grsecurity.net (Brad Spengler)
Date: Fri, 19 Feb 2010 22:57:24 +0000
Subject: Execution possible in non-executable mappings in recent 2.6 kernels
Message-Id: <20100219225724.GA29861@grsecurity.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave & list:

I'm writing to report a bug in recent vanilla kernels regarding the
ability to execute in non-executable pages on SPARC.  I'm no SPARC
expert, but I'll try to explain as best I can the problem and make
myself available for debugging/testing any fixes.

I have 4 sparc systems currently, a Netra T1, an Ultra 10, a Sunfire
V210, and a Blade 2500.  The first two systems run the latest 2.4
kernels and experience no problems.  The second two systems run recent
2.6 kernels (2.6.31 and 2.6.32) and both utilize the Cheetah+ MMU.  Both
of these systems running the recent 2.6 kernels exhibit the problem.

I've provided two simple testcases that illustrate the problem.  Either
run them in a loop or just multiple times -- eventually instead of
receiving a segfault (as it should every time for attempting to execute
on the stack, which is non-executable by default per ABI) the shellcode
I've set up on the stack will execute without problems.  In the first
testcase I haven't set up enough code to perform a return from the
function pointer, so you see the varied signals when an instruction
fetch is attempted on the 2nd instruction (made up of whatever
happened to be located on the stack).  In the second case I set up the
proper ret/restore and the program is able to exit cleanly.

I'm willing to do anything to help debug the problem, but I thought it=20
would
be wiser to report it first in case anyone had any immediate ideas on
what the problem could be.  I figured it would also help in being able
to debug the issue more effectively, given its seemingly somewhat-random
nature.

Please keep the PaX team and myself CC'd as we're not subscribed to the
list.

Thanks for your help,
-Brad

cat /proc/self/maps output (showing the stack non-executable):
00010000-00014000 r-xp 00000000 08:02 1769474   /bin/cat
00024000-00026000 rwxp 00004000 08:02 1769474   /bin/cat
00026000-00048000 rwxp 00000000 00:00 0         [heap]
f7cf0000-f7e2a000 r--p 00000000 08:02 295830    /usr/lib/locale/locale-arch=
ive
f7e2c000-f7fa4000 r-xp 00000000 08:02 1277958   /lib/ultra3/libc-2.7.so
f7fa4000-f7fb4000 ---p 00178000 08:02 1277958   /lib/ultra3/libc-2.7.so
f7fb4000-f7fba000 rwxp 00178000 08:02 1277958   /lib/ultra3/libc-2.7.so
f7fba000-f7fbc000 rwxp 00000000 00:00 0
f7fbc000-f7fde000 r-xp 00000000 08:02 1270085   /lib/ld-2.7.so
f7fec000-f7ff0000 rwxp 00020000 08:02 1270085   /lib/ld-2.7.so
f7ff0000-f7ff2000 rw-p 00000000 00:00 0
ffdb6000-ffde0000 rw-p 00000000 00:00 0         [stack]

First test case:
#include <stdio.h>

typedef int (* _wee)(void);

int main(void)
{
        char buf[4] =3D { '\x81', '\xc7', '\xe0', '\x08'};
        _wee wee;
        printf("%p\n", &buf);
        wee =3D (_wee)&buf;
        wee();

        return 0;
}

gdb output in 90-95% of the cases:
Program received signal SIGSEGV, Segmentation fault.
0xff9d9cb0 in ?? ()

gdb output in the other 5-10% of cases:
(gdb) run
The program being debugged has been started already.
Start it from the beginning? (y or n) y
Starting program: /root/test
0xff811cb0

Program received signal SIGBUS, Bus error.
0xff811cb4 in ?? ()
(gdb) x/x 0xff811cb0
0xff811cb0:     0x81c7e008
(gdb) x/i 0xff811cb0
0xff811cb0:     ret
0xff811cb4:     lda  [ %g4 + %l0 ] (229), %f31

(gdb) run
The program being debugged has been started already.
Start it from the beginning? (y or n) y
Starting program: /root/test
0xff97dcb0

Program received signal SIGILL, Illegal instruction.
0xff97dcb4 in ?? ()
(gdb) x/8x $pc-4
0xff97dcb0:     0x81c7e008      0xff97dcb0      0xf7f3af00
0x00000000
0xff97dcc0:     0x00000000      0x00000000      0xfffffffc
0x00000000
(gdb) x/i $pc-4
0xff97dcb0:     ret
0xff97dcb4:     ldqa  [ %i7 + %l0 ] (229), %f62

modified code so it executed a ret / restore:
#include <stdio.h>

typedef int (* _wee)(void);

int main(void)
{
        char buf[8] =3D { '\x81', '\xc7', '\xe0', '\x08', '\x81', '\xe8',
                        '\x00', '\x00' };
        _wee wee;
        printf("%p\n", &buf);
        wee =3D (_wee)&buf;
        wee();

        return 0;
}


gdb output in the 5-10% case:
Starting program: /root/test
0xffb4fca8

Program exited with code 01.


--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFLfxdTmHm2SUJF1GoRAvXIAJ9FVNpIIIaeNv2uGqMBaJBvg3H7nQCePHpi
SvfVbu6uKdUw8h7Q/FNCXEw=
=gSyK
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
