From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Sat, 21 May 2016 22:19:32 +0000
Subject: Trying to allocate with mmap in specific region twice
Message-Id: <90aba233-f4c6-e30f-07b3-51a217564658@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi!

I'm currently trying to fix Firefox 46 on sparc64 which is segfaulting due =
to issues
with memory allocation in JavaScript. The issue is a bit odd and involves s=
ome of the
magic involved in Firefox' JavaScript engine which packs additional type in=
formation
into pointers.

The resulting problem is that the pointer of the memory allocated with mmap=
 must have
its upper 17 bits clear as otherwise the JavaScript engine will crash. This=
 has been
previously fixed on ia64/Linux [1] and NetBSD/sparc64 [2].

I have been playing with the code and tried to implement the fix used in [1=
] and [2]
but since mmap on sparc64 on Linux behaves differently as compared to NetBS=
D [3],
the fix is not directly usable.

As demonstrated in [3], the hint used for mmap will only work once and on c=
onsecutive
calls, it's completely ignored which means a pointer is again return which =
won't have
the upper bits cleared. This is the case for Linux at least on amd64 and sp=
arc64 and
it seems to have been introduced in 2003 around Linux 2.4.10 [4].

Thus, does anybody know if there is a clever way to get mmap to allocate me=
mory near
the region suggested by the hint so we can be sure that the 17 upper bits a=
re always
clear on sparc64?

Thanks,
Adrian

> [1] https://bugzilla.mozilla.org/show_bug.cgi?idX9735
> [2] https://bugzilla.mozilla.org/show_bug.cgi?id=994133
> [3] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=824449#22
> [4] https://lkml.org/lkml/2003/5/20/64

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
