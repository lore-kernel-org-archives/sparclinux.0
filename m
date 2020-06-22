From: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Date: Mon, 22 Jun 2020 19:08:28 +0000
Subject: Re: sparc vs sparc64: O_NDELAY and O_NONBLOCK mismatch in kernel and in glibc
Message-Id: <a213fcf7-73e3-7727-dea2-f73e1032a307@linaro.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200529104019.72983ef9@sf>
In-Reply-To: <20200529104019.72983ef9@sf>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org



On 29/05/2020 06:40, Sergei Trofimovich via Libc-alpha wrote:
> On most targets glibc defines O_NDELAY as O_NONBLOCK.
>=20
> glibc's manual/llio.texi manual says they are supposed to be equal:
>=20
> """
> @deftypevr Macro int O_NDELAY
> @standards{BSD, fcntl.h}
> This is an obsolete name for @code{O_NONBLOCK}, provided for
> compatibility with BSD.  It is not defined by the POSIX.1 standard.
> @end deftypevr
> """
>=20
> A bunch of packages rely on it and find out that this assumption
> breaks on sparc in unusual ways. Recently it popped up as:
>     https://github.com/eventlet/eventlet/pull/615
> Older workarounds:
>     https://github.com/libuv/libuv/issues/1830
>=20
> What is more confusing for me:
>=20
> linux kernel's uapi definition of O_NDELAY is ABI-dependent:
>   arch/sparc/include/uapi/asm/fcntl.h
> """
> #if defined(__sparc__) && defined(__arch64__)
> #define O_NDELAY        0x0004
> #else
> #define O_NDELAY        (0x0004 | O_NONBLOCK)
> #endif
> """
>=20
> while glibc's is not:
>   sysdeps/unix/sysv/linux/sparc/bits/fcntl.h
> """
> #define O_NONBLOCK      0x4000
> #define O_NDELAY        (0x0004 | O_NONBLOCK)
> """

Doing some archeology it seems that sparc32 originally defined
O_NDELAY as 0x0004, but it has changed it to 0x0004 | O_NONBLOCK
on 2.1.29.

>=20
> Spot-checking preprocessor's output that seems to corroborate:
>=20
> """
> $ printf "#include <sys/fcntl.h>'\n int o_ndelay =3D O_NDELAY; int o_nonb=
lock =3D O_NONBLOCK;" | sparc-unknown-linux-gnu-gcc -E -x c - | fgrep -A3 o_
> int o_ndelay >                (0x0004 | 0x4000)
>                        ; int o_nonblock >                                =
           0x4000
>=20
> $ printf "#include <sys/fcntl.h>'\n int o_ndelay =3D O_NDELAY; int o_nonb=
lock =3D O_NONBLOCK;" | sparc64-unknown-linux-gnu-gcc -E -x c - | fgrep -A3=
 o_
>=20
> int o_ndelay >                (0x0004 | 0x4000)
>                        ; int o_nonblock >                                =
           0x4000
> """
>=20
> I think this skew causes strange effects when you run sparc32
> binary on sparc64 kernel (compared to sparc32 binary on sparc32
> kernel) as kernel disagrees with userspace on O_NDELAY definition.
>=20
> https://github.com/libuv/libuv/issues/1830 has more details.
>=20
> I tried to trace the O_NDELAY definition and stopped at linux-2.1.29:
>   https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/dif=
f/include/asm-sparc/fcntl.h?id=B7b4d2d2c1809575374269e14d86ee1953bd168c
> which brought O_NDELAY to O_NONBLOCK but did not make them
> match exactly.
>=20
> Question time:
>=20
> 1. Why is sparc32 special? Does it have something to do with
>    compatibility to other OSes of that time? (Solaris? BSD?)
>=20
>    fs/fcntl.c has kernel handling:
>         /* required for strict SunOS emulation */
>         if (O_NONBLOCK !=3D O_NDELAY)
>                if (arg & O_NDELAY)
>                    arg |=3D O_NONBLOCK;
>    but why does it leak to to userspace header definition?
>=20
>    I think it should not.

It seems to provide some compatibility with SunOS since on Solaris11
O_NDELAY is 0x4 on both 32 and 64 bits.=20

>=20
> 2. Should sparc64-glibc change it's definition? Say, from
>     #define O_NDELAY        (0x0004 | O_NONBLOCK)
>    to
>     #define O_NDELAY        O_NONBLOCK
>=20
>     I think it should.

This will make:

  fcntl(fd, F_SETFL, flags | O_NONBLOCK);
  flags =3D fcntl(fd, F_GETFL);
  fcntl(fd, F_SETFL, flags & ~O_NDELAY);

Not clearing the flag.

>=20
> 3. Should sparc32-linux (and glibc) change it's definition? Say, from
>    #if defined(__sparc__) && defined(__arch64__)
>    #define O_NDELAY        0x0004
>    #else
>    #define O_NDELAY        (0x0004 | O_NONBLOCK)
>    #endif
>   to
>    #define O_NDELAY        (0x0004 | O_NONBLOCK)
>   or even to=20
>   #define O_NDELAY        O_NONBLOCK
>   and make sure kernel maps old O_NDELAY to O_NONBLOCK?
>=20
>   I think '#define O_NDELAY O_NONBLOCK' would be most
>   consistent.
>=20
> What do you think?

I think the main issue here is in fact FIONBIO historical inconsistency
over different system that Linux originally tried to accommodate it:

fs/ioctl.c:

545 static int ioctl_fionbio(struct file *filp, int __user *argp)
546 {
547         unsigned int flag;
548         int on, error;
549=20
550         error =3D get_user(on, argp);
551         if (error)
552                 return error;
553         flag =3D O_NONBLOCK;
554 #ifdef __sparc__
555         /* SunOS compatibility item. */
556         if (O_NONBLOCK !=3D O_NDELAY)
557                 flag |=3D O_NDELAY;
558 #endif
559         spin_lock(&filp->f_lock);
560         if (on)
561                 filp->f_flags |=3D flag;
562         else
563                 filp->f_flags &=3D ~flag;
564         spin_unlock(&filp->f_lock);
565         return error;
566 }

The issue on sparc is FIONBIO will always try to set/reset *both*
flags at the same time. I think what would be better would be to
either define O_NDELAY and O_NONBLOCK to be the same value of
0x4004 on both sparc32 and sparc64 (since the kernel does treat
them semantically as the same) or try to avoid use FIONBIO set the
socket as non-blocking in favor or fcntl(fd, F_SETFL, ... O_NONBLOCK).
