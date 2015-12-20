From: Mike Frysinger <vapier@gentoo.org>
Date: Sun, 20 Dec 2015 05:47:54 +0000
Subject: using ptrace to cancel a syscall on sparc
Message-Id: <20151220054754.GZ11489@vapier.lan>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="gi3iJNaOIGm63TYM"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--gi3iJNaOIGm63TYM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

i've been playing with ptrace on sparc and trying to use it to watch and
cancel specific syscalls.  i have this working for other arches already.

the test is pretty simple:
 - call open("f", O_CREAT)
 - call unlink("f")
the tracer will watch for the unlink, and when it gets notified, stuffs
the syscall # with -1 (so it'll get skipped).  then when it gets called
a second time, it stuffs the exit with -1/EPERM.

i'm using PTRACE_GETREGS/PTRACE_SETREGS to read/write the regsets (and
i've swapped the addr/data args specifically for sparc).  i extract the
syscall # from g1 (u_regs[0]) and syscalls args from o0..o5 (u_regs[7]
through u_regs[12]).  this seems to be working fine.

when setting the return value, i set PSR_C in the psr register, and i
set o0 to EPERM.  seems to be working (the unlink function returns a
-1 and errno is EPERM).

i'm having trouble with canceling of the syscall itself.  seems like
no matter what i stuff into o0, the kernel executes the unlink.  i've
tried tracing arch/sparc/kernel/syscalls.S and kernel/head_64.S, the
the entry is linux_sparc_syscall32 which calls linux_syscall_trace32,
but it seems like the o0 stuff doesn't seem to work for me.  my sparc
asm foo isn't strong enough to figure out what's going wrong :/.
-mike

--gi3iJNaOIGm63TYM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWdkEKAAoJEEFjO5/oN/WBPYsQAIMaBSPrDU1XzClihMAGr1LR
SXZTCAWWi7EPJSRqAPawnu72EswDZChNRM/4EK+/wKZRyAbJGiLpFpFSkL+b06WD
zmvqJdyQhaLQz2tLS9oFNhJRtPczsC08ENLeuEpNu17xCvYHLguuTPxT1ESbz8vv
CaV7FBJYVpmwiqFKUKcie3YF5ZW9tsW3WmmBjBFsmv9y649R9Bqa9y6SOFQDN+44
UwU3X4YmvQwlyN6+OJmt25zlwe1rnKK9utN9o2+x/WC4uR3/aQe+4nmI+LYNXdks
HoUAaP+RhGbX9OeqwVpiKqmscvvW9zCzrFQ/h3AgPXhC+692InnlTvocDZKtZBab
udEzViKRSeJ/PAvW7KoXXMBULIwwoRg/hKfN2yCGlLh3ppiCXoFn2u6sgEIuFzma
KC2SZrp+FHu3FhlxUX52EnKeyhVQgSR04lY9hS0OMVDJaulvLUjvRsMQcKT2Q/mS
ZwZXMR4iVdHUOwm5AfVX2UEdGtao46EFxuz56uBjvpZgNrGJnOVJ4R/r4fYuUf3r
QPKnmivKpNckB9dmIhgDYk8XdmLTXU2IXSuVKluBdgpvLnjnN74OICVu4GPrJUYn
gHlyfgOd87XqZcJ4qlMt1D+itbGaKB/JNtbkecHYUqr1QH44WonPbeXW5Wj9cUM6
6Fa+sfG4VbKK1KIyghQD
=IwL+
-----END PGP SIGNATURE-----

--gi3iJNaOIGm63TYM--
