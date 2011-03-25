From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 25 Mar 2011 14:10:44 +0000
Subject: [patch 0/4] sparc: Final irq bits for .39
Message-Id: <20110325140808.738196492@linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David,

the following series 

    - makes use of the new core functions
    - cleans up open coded irq_desc access
    - converts to new function names
    - switches to the generic show_interrupts()

Thanks,

	tglx
---
 Kconfig          |    2 
 kernel/irq_64.c  |  123 ++++++++++++++-----------------------------------------
 kernel/pci.c     |    2 
 kernel/pci_msi.c |   15 ++----
 4 files changed, 41 insertions(+), 101 deletions(-)

