From: David Miller <davem@davemloft.net>
Date: Thu, 22 May 2014 21:53:56 +0000
Subject: [GIT] Sparc
Message-Id: <20140522.175356.544649352706511585.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


A small bunch of bug fixes, in particular:

1) On older cpus we need a different chunk of virtual address
   space to map the huge page TSB.

2) Missing memory barrier in Niagara2 memcpy.

3) trinity showed some places where fault validation was unnecessarily
   loud on sparc64

4) Some sysfs printf's need a type adjustment, from Toralf F=F6rster

Please pull, thanks a lot.

The following changes since commit 256cf4c438e60116785a83b060614c63c7477e84:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git=
/mszeredi/fuse (2014-05-06 09:09:35 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc master

for you to fetch changes up to 8ecc1bad4c9b485ceb47182d282980d0b0fe20ac:

  sparc64: fix format string mismatch in arch/sparc/kernel/sysfs.c (2014-05=
-21 12:54:42 -0700)

----------------------------------------------------------------
David S. Miller (3):
      sparc64: Don't bark so loudly about 32-bit tasks generating 64-bit fa=
ult addresses.
      sparc64: Fix huge TSB mapping on pre-UltraSPARC-III cpus.
      sparc64: Add membar to Niagara2 memcpy code.

Toralf F=F6rster (1):
      sparc64: fix format string mismatch in arch/sparc/kernel/sysfs.c

 arch/sparc/include/asm/pgtable_64.h |  6 ++++--
 arch/sparc/kernel/sysfs.c           |  2 +-
 arch/sparc/lib/NG2memcpy.S          |  1 +
 arch/sparc/mm/fault_64.c            | 16 +---------------
 arch/sparc/mm/tsb.c                 | 14 +++++++++++++-
 5 files changed, 20 insertions(+), 19 deletions(-)
