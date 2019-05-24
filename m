From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 24 May 2019 10:24:53 +0000
Subject: Making MAX_PHYS_ADDRESS_BITS configurable
Message-Id: <2be3335c-1870-9867-0f25-01cf798ca84b@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hello!

A lot of JITs are using tagged pointers for performance reasons which
means that the pointer bits beyond the 47th or 48th should be kept
untouched by the kernel.

On sparc64, MAX_PHYS_ADDRESS_BITS is currently defined as 53 meaning that
a lot of JITs crash on a sparc64 userspace [1].

Since other architectures like x86_64 and arm64 are catching up with their
address space extension with x86_64 bumping it to 56 and arm64 to 52 bits,
I assume this problem will hit these architectures in the future as well.

On the other hand, arm64 currently allows the virtual address size to be
configurable, currently defaulting to 48 bits [2, 3]. I was therefore
wondering whether we could make MAX_PHYS_ADDRESS_BITS [4] configurable
as well to be able to support these JITs on Debian/sparc64 for the foreseea=
ble
future by limiting the virtual address space to 47 or 48 bits.

Thanks,
Adrian

> [1] https://bugreports.qt.io/browse/QTBUG-56264
> [2] https://patchwork.kernel.org/patch/10130743/
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/arch/arm64/include/asm/sparsemem.h?id=982aa7c5f0861bf56b2412ca341a13f4=
4c238ba4
> [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/arch/sparc/include/asm/page_64.h#n140

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
