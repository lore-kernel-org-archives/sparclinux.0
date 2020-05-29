From: Sergei Trofimovich <slyfox@gentoo.org>
Date: Fri, 29 May 2020 09:40:19 +0000
Subject: sparc vs sparc64: O_NDELAY and O_NONBLOCK mismatch in kernel and in glibc
Message-Id: <20200529104019.72983ef9@sf>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On most targets glibc defines O_NDELAY as O_NONBLOCK.

glibc's manual/llio.texi manual says they are supposed to be equal:

"""
@deftypevr Macro int O_NDELAY
@standards{BSD, fcntl.h}
This is an obsolete name for @code{O_NONBLOCK}, provided for
compatibility with BSD.  It is not defined by the POSIX.1 standard.
@end deftypevr
"""

A bunch of packages rely on it and find out that this assumption
breaks on sparc in unusual ways. Recently it popped up as:
    https://github.com/eventlet/eventlet/pull/615
Older workarounds:
    https://github.com/libuv/libuv/issues/1830

What is more confusing for me:

linux kernel's uapi definition of O_NDELAY is ABI-dependent:
  arch/sparc/include/uapi/asm/fcntl.h
"""
#if defined(__sparc__) && defined(__arch64__)
#define O_NDELAY        0x0004
#else
#define O_NDELAY        (0x0004 | O_NONBLOCK)
#endif
"""

while glibc's is not:
  sysdeps/unix/sysv/linux/sparc/bits/fcntl.h
"""
#define O_NONBLOCK      0x4000
#define O_NDELAY        (0x0004 | O_NONBLOCK)
"""

Spot-checking preprocessor's output that seems to corroborate:

"""
$ printf "#include <sys/fcntl.h>'\n int o_ndelay =3D O_NDELAY; int o_nonblo=
ck =3D O_NONBLOCK;" | sparc-unknown-linux-gnu-gcc -E -x c - | fgrep -A3 o_
int o_ndelay                (0x0004 | 0x4000)
                       ; int o_nonblock                                    =
       0x4000

$ printf "#include <sys/fcntl.h>'\n int o_ndelay =3D O_NDELAY; int o_nonblo=
ck =3D O_NONBLOCK;" | sparc64-unknown-linux-gnu-gcc -E -x c - | fgrep -A3 o_

int o_ndelay                (0x0004 | 0x4000)
                       ; int o_nonblock                                    =
       0x4000
"""

I think this skew causes strange effects when you run sparc32
binary on sparc64 kernel (compared to sparc32 binary on sparc32
kernel) as kernel disagrees with userspace on O_NDELAY definition.

https://github.com/libuv/libuv/issues/1830 has more details.

I tried to trace the O_NDELAY definition and stopped at linux-2.1.29:
  https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/diff/=
include/asm-sparc/fcntl.h?id=B7b4d2d2c1809575374269e14d86ee1953bd168c
which brought O_NDELAY to O_NONBLOCK but did not make them
match exactly.

Question time:

1. Why is sparc32 special? Does it have something to do with
   compatibility to other OSes of that time? (Solaris? BSD?)

   fs/fcntl.c has kernel handling:
        /* required for strict SunOS emulation */
        if (O_NONBLOCK !=3D O_NDELAY)
               if (arg & O_NDELAY)
                   arg |=3D O_NONBLOCK;
   but why does it leak to to userspace header definition?

   I think it should not.

2. Should sparc64-glibc change it's definition? Say, from
    #define O_NDELAY        (0x0004 | O_NONBLOCK)
   to
    #define O_NDELAY        O_NONBLOCK

    I think it should.

3. Should sparc32-linux (and glibc) change it's definition? Say, from
   #if defined(__sparc__) && defined(__arch64__)
   #define O_NDELAY        0x0004
   #else
   #define O_NDELAY        (0x0004 | O_NONBLOCK)
   #endif
  to
   #define O_NDELAY        (0x0004 | O_NONBLOCK)
  or even to=20
  #define O_NDELAY        O_NONBLOCK
  and make sure kernel maps old O_NDELAY to O_NONBLOCK?

  I think '#define O_NDELAY O_NONBLOCK' would be most
  consistent.

What do you think?

Thanks!

--=20

  Sergei
