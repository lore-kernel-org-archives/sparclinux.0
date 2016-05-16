From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Mon, 16 May 2016 12:23:08 +0000
Subject: Definition of __sparc64__ in gcc
Message-Id: <5739BBAC.2030804@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hello!

While looking at the FTBFS of Firefox, I noticed that Firefox, more
precisely ipc/chromium was checking for the definition of __sparc64__
to configure the code for sparc64 [1].

However, when looking at the actual gcc configuration dump, it's
apparent that __sparc64__ is actually not used but __arch64__:

root@landau:~# echo | gcc -E -dM - |grep __arch64__
#define __arch64__ 1
root@landau:~# echo | gcc -E -dM - |grep __sparc64__
root@landau:~#

Changing the header in Firefox's code base actually fixed this
particular issue with the firefox package on Debian.

Thus, my suspicion is that there might be other packages which are
incorrectly configured on sparc64 and consequently either failing
to build from source, crashing their testsuite or crashing during
operation.

A list of the possibly affected packages can be found in [2].

Any comments?

Adrian

> [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=824449
> [2] https://codesearch.debian.net/results/__sparc64__/page_0

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
