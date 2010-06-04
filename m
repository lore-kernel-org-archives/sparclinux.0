From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 04 Jun 2010 21:24:54 +0000
Subject: [PATCH 0/5] Consolidate OF IRQ handling code
Message-Id: <AANLkTil1-afn4-qCEAza53taNamu-agigv09VSdyB0sB@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Michal Simek <monstr@monstr.eu>, microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, sparclinux@vger.kernel.org, Jeremy Kerr <jeremy.kerr@canonical.com>, "David S. Miller" <davem@davemloft.net>

This series merges the common IRQ handling code between Microblaze and Powerpc.

I'll be adding these patches to linux-next next week unless there are
objections.

Cheers,
g.

Grant Likely (5):
      of/irq: Move irq_of_parse_and_map() to common code
      of/microblaze: strip out of_irq_workarounds code
      of/irq: merge of_irq_find_parent()
      of/irq: Merge of_irq_map_raw()
      of/irq: merge of_irq_map_one()

 arch/microblaze/include/asm/irq.h   |   13 --
 arch/microblaze/include/asm/prom.h  |   63 +-------
 arch/microblaze/kernel/irq.c        |   14 +--
 arch/microblaze/kernel/prom_parse.c |  321 +---------------------------------
 arch/powerpc/include/asm/irq.h      |   13 --
 arch/powerpc/include/asm/prom.h     |   51 +-----
 arch/powerpc/kernel/irq.c           |   14 +--
 arch/powerpc/kernel/prom_parse.c    |  254 +--------------------------
 arch/sparc/include/asm/prom.h       |    1 -
 drivers/of/Kconfig                  |    4 +
 drivers/of/Makefile                 |    1 +
 drivers/of/irq.c                    |  336 +++++++++++++++++++++++++++++++++++
 drivers/of/of_mdio.c                |    1 +
 include/linux/of_irq.h              |   49 +++++
 14 files changed, 405 insertions(+), 730 deletions(-)
 create mode 100644 drivers/of/irq.c
 create mode 100644 include/linux/of_irq.h
