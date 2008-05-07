From: David Miller <davem@davemloft.net>
Date: Wed, 07 May 2008 01:14:06 +0000
Subject: [GIT]: Sparc
Message-Id: <20080506.181406.60757850.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Sparc updates and fixes:

1) initrd hosed unintentionally by my NUMA support changes
   on sparc64

2) SMP IPIs don't need to actually be surrounded by
   irq_{enter,exit}(), revert

3) online_page() is superfluous, delete, from Adrian Bunk

4) Christoph Hellwig noticed that we had a local copy of
   compat_sys_times(), just use it directly.

5) USB_ISP1760_OF should not be built on sparc, ACK'd by
   Ben H.

6) Sparc video driver tidies by Robert Reif.

Please pull, thanks a lot!

The following changes since commit afa26be86b65a7183ceac29bdf1f51d6fc6932f0:
  Linus Torvalds (1):
        Merge git://git.kernel.org/.../tglx/linux-2.6-hrt

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

Adrian Bunk (1):
      sparc64: remove online_page()

David S. Miller (5):
      Revert "[SPARC64]: Wrap SMP IPIs with irq_enter()/irq_exit()."
      sbus: Fix bpp driver build.
      sparc64: use compat_sys_utimes instead of home-grown local copy.
      usb: Sparc build fix, make USB_ISP1760_OF depend on PPC_OF
      sparc64: Fix initrd regression.

Robert Reif (2):
      sparc: tcx.c remove unnecessary function
      sparc video: make blank use proper constant

 arch/sparc64/kernel/smp.c         |   27 +++++----------------------
 arch/sparc64/kernel/sys_sparc32.c |   31 -------------------------------
 arch/sparc64/kernel/systbls.S     |    2 +-
 arch/sparc64/mm/init.c            |   16 +++-------------
 drivers/sbus/char/bpp.c           |    2 +-
 drivers/usb/host/Kconfig          |    2 +-
 drivers/video/bw2.c               |    2 +-
 drivers/video/cg3.c               |    2 +-
 drivers/video/cg6.c               |    2 +-
 drivers/video/ffb.c               |    2 +-
 drivers/video/leo.c               |    2 +-
 drivers/video/p9100.c             |    2 +-
 drivers/video/tcx.c               |   20 +++++++-------------
 13 files changed, 24 insertions(+), 88 deletions(-)
