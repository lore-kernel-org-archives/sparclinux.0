From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Date: Wed, 03 Jan 2018 21:29:55 +0000
Subject: sending SIGFPE via kill() returns wrong values in si_pid and si_uid
Message-Id: <1942316.IfptgDaGPd@eto>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart4275078.2ygACElraf"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

--nextPart4275078.2ygACElraf
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

This originally came up as a failure in the testsuite of strace on Gent=
oo=20
(T5120, 64 bit kernel, 32 bit userspace) and was reported here:=20
https://bugs.gentoo.org/643060. This was then reported upstream here:=20=

https://github.com/strace/strace/issues/21 . I'll paste the relevant pa=
rts of
those bugs here.

The test program is as follows (done by Dmitry V. Levin):=20

#include <assert.h>
#include <signal.h>
#include <stdio.h>
#include <unistd.h>

static void
handler(int sig, siginfo_t *info, void *ucontext)
{

fprintf(stderr, "sig=3D%d, si_signo=3D%d, si_pid=3D%d, si_uid=3D%d\n",
=09sig, info->si_signo, info->si_pid, info->si_uid);
}

static void
setup(int sig, sigset_t *mask)
{

static const struct sigaction act =3D { .sa_sigaction =3D handler, .sa_=
flags =3D SA_SIGINFO };
assert(!sigaction(sig, &act, NULL));
assert(!sigaddset(mask, sig));
}

static void
test(int sig)
{

assert(!raise(sig));
assert(!kill(getpid(), sig));
}

int
main(void)
{

sigset_t mask;
assert(!sigemptyset(&mask));

setup(SIGFPE, &mask);
setup(SIGTERM, &mask);

assert(!sigprocmask(SIG_UNBLOCK, &mask, NULL));

test(SIGFPE);
test(SIGTERM);

return 0;
}

Running this on sparc64 userspace works fine:

sig=3D8, si_signo=3D8, si_pid=3D135186, si_uid=3D1008
sig=3D8, si_signo=3D8, si_pid=3D135186, si_uid=3D1008
sig=3D15, si_signo=3D15, si_pid=3D135186, si_uid=3D1008
sig=3D15, si_signo=3D15, si_pid=3D135186, si_uid=3D1008

However, on sparc32 things go wrong:

sig=3D8, si_signo=3D8, si_pid=3D135192, si_uid=3D1008
sig=3D8, si_signo=3D8, si_pid=3D1008, si_uid=3D0
sig=3D15, si_signo=3D15, si_pid=3D135192, si_uid=3D1008
sig=3D15, si_signo=3D15, si_pid=3D135192, si_uid=3D1008

When digging the code up and down I came up with this patch, which fixe=
s the=20
issue for me:

diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.=
c
index 54a6159b9cd8..a05e271e0924 100644
=2D-- a/arch/sparc/kernel/signal32.c
+++ b/arch/sparc/kernel/signal32.c
@@ -87,7 +87,7 @@ int copy_siginfo_to_user32(compat_siginfo_t __user *t=
o,=20
        err =3D __put_user(from->si_signo, &to->si_signo);
        err |=3D __put_user(from->si_errno, &to->si_errno);
        err |=3D __put_user(from->si_code, &to->si_code);
=2D       if (from->si_code < 0)
+       if (SI_FROMUSER(from))
                err |=3D __copy_to_user(&to->_sifields._pad, &from->_si=
fields._pad, SI_PAD_SIZE);
        else {
                switch (siginfo_layout(from->si_signo, from->si_code)) =
{

I suspect it was broken by cc731525f26af85a1c3537da41e0abd1d35e0bdb as =
it is=20
reported that it worked in 4.5.0. Looking at that commit other archs (a=
t least=20
arm64, mips, parisc, powerpc, s390, tile, x86) have the same code, but=20=

different default-cases. From a quick glance arm64, parisc, and x86 do =
not=20
have a default case anymore since that commit, while the others do not =
seem to=20
have changed their default case. However it could be that siginfo_layou=
t()=20
behaves slightly different than the mask code used before in the switch=
=20
statements. I'm currently building a 4.14.9 kernel for my HP C8000, wil=
l=20
report the test results once that is done.

Eike
--nextPart4275078.2ygACElraf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlpNS1kACgkQXKSJPmm5/E5DzgCeO9itP5aPtnrRJnTQuK1RFlLX
5qoAnAkgDoWBRU96yssRsG8/fbQb7I0A
=4S1r
-----END PGP SIGNATURE-----

--nextPart4275078.2ygACElraf--

