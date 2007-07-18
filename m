From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 18 Jul 2007 07:30:24 +0000
Subject: Start the consolidation of the OpenFrimware support routines
Message-Id: <20070718173024.50204a1a.sfr@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Wed__18_Jul_2007_17_30_24_+1000_I.RLRHJNv4_kbQB5"
List-Id: <sparclinux.vger.kernel.org>
To: ppc-dev <linuxppc-dev@ozlabs.org>, sparclinux@vger.kernel.org
Cc: paulus@samba.org, "David S. Miller" <davem@davemloft.net>, wli@holomorphy.com

--Signature=_Wed__18_Jul_2007_17_30_24_+1000_I.RLRHJNv4_kbQB5
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave, Paul,

The latest version of the changes is available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sfr/ofcons.git master

I will send patches to the lists if people want them.  The only changes
from the previous version is to merge with Linus' current tree (there
were various conflicts with PowerPC changes).  This has been built for
Sparc and Sparc64 defconfigs but I have no Sparc hardware to boot on.  It
has also been built for PowerPC allmodconfig and ppc64_defconfig - the
latter has been booted on an iSeries box.

The intention here is that there should be no behavioural changes and
minimal code changes (apart from movement of the code to common places).
There are, however a couple of unavoidable changes:
	- some of the accessor functions now take a read lock on Sparc[64]
where they didn't before.
	- the bus structures are initialised at runtime.

If people are happy with this, I will submit it directly to Linus.

Stephen Rothwell (12):
      Split out common parts of prom.h
      Start split out of common open firmware code
      Consolidate of_device_is_compatible
      Consolidate of_find_property
      Consolidate of_get_parent
      Consolidate of_get_next_child
      Consolidate of_find_node_by routines
      Begin to consolidate of_device.c
      Begin consolidation of of_device.h
      [SPARC/64] Rename some functions like PowerPC
      Create linux/of_platorm.h
      Create drivers/of/platform.c

 arch/powerpc/Kconfig              |    3 +
 arch/powerpc/kernel/of_device.c   |  122 +----------------
 arch/powerpc/kernel/of_platform.c |   82 +-----------
 arch/powerpc/kernel/prom.c        |  250 +---------------------------------
 arch/sparc/Kconfig                |    3 +
 arch/sparc/kernel/of_device.c     |  222 ++----------------------------
 arch/sparc/kernel/prom.c          |  173 +-----------------------
 arch/sparc/kernel/time.c          |    2 +-
 arch/sparc64/Kconfig              |    3 +
 arch/sparc64/kernel/auxio.c       |    2 +-
 arch/sparc64/kernel/of_device.c   |  238 +++-----------------------------
 arch/sparc64/kernel/power.c       |    2 +-
 arch/sparc64/kernel/prom.c        |  173 +-----------------------
 arch/sparc64/kernel/time.c        |    2 +-
 drivers/Kconfig                   |    2 +
 drivers/Makefile                  |    1 +
 drivers/of/Kconfig                |    3 +
 drivers/of/Makefile               |    2 +
 drivers/of/base.c                 |  275 +++++++++++++++++++++++++++++++++=
++++
 drivers/of/device.c               |  131 ++++++++++++++++++
 drivers/of/platform.c             |   96 +++++++++++++
 include/asm-powerpc/of_device.h   |   22 +---
 include/asm-powerpc/of_platform.h |   38 +-----
 include/asm-powerpc/prom.h        |   50 ++-----
 include/asm-sparc/of_device.h     |   49 +------
 include/asm-sparc/of_platform.h   |   32 +++++
 include/asm-sparc/prom.h          |   62 +++------
 include/asm-sparc64/of_device.h   |   50 +------
 include/asm-sparc64/of_platform.h |   33 +++++
 include/asm-sparc64/prom.h        |   62 +++------
 include/linux/of.h                |   61 ++++++++
 include/linux/of_device.h         |   26 ++++
 include/linux/of_platform.h       |   57 ++++++++
 33 files changed, 846 insertions(+), 1483 deletions(-)
 create mode 100644 drivers/of/Kconfig
 create mode 100644 drivers/of/Makefile
 create mode 100644 drivers/of/base.c
 create mode 100644 drivers/of/device.c
 create mode 100644 drivers/of/platform.c
 create mode 100644 include/asm-sparc/of_platform.h
 create mode 100644 include/asm-sparc64/of_platform.h
 create mode 100644 include/linux/of.h
 create mode 100644 include/linux/of_device.h
 create mode 100644 include/linux/of_platform.h

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__18_Jul_2007_17_30_24_+1000_I.RLRHJNv4_kbQB5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGncGUTgG2atn1QN8RAgJlAKCSz0kWfYdiiUzmK8Pb3yCxBHTiggCfVbB1
Q+ETID2iU+ybFA0JnH0nu8w=
=ZxdA
-----END PGP SIGNATURE-----

--Signature=_Wed__18_Jul_2007_17_30_24_+1000_I.RLRHJNv4_kbQB5--
