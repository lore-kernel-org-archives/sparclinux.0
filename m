From: Valentin Schneider <valentin.schneider@arm.com>
Date: Fri, 03 Jul 2020 15:56:43 +0000
Subject: [PATCH 0/2] genirq: Kill preflow handlers
Message-Id: <20200703155645.29703-1-valentin.schneider@arm.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>

Hi,

while strolling around the different flow handlers, I tried to make sense of
what preflow_handler() was about. Turns out no one uses those anymore, but the
genirq support has remained in place.

Unless we can see another user of those in the near future, this seems like as
good a time as any for a little housecleaning.

- Patch 1 simply deselects the (unexploited) preflow Kconfig for sparc64
- Patch 2 is the actual cleanup

Cheers,
Valentin

Valentin Schneider (2):
  sparc64: Deselect IRQ_PREFLOW_FASTEOI
  genirq: Remove preflow handler support

 arch/sparc/Kconfig         |  1 -
 include/linux/irqdesc.h    | 15 ---------------
 include/linux/irqhandler.h |  1 -
 kernel/irq/Kconfig         |  4 ----
 kernel/irq/chip.c          | 13 -------------
 5 files changed, 34 deletions(-)

--
2.27.0
