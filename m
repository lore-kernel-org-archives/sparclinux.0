From: David Miller <davem@davemloft.net>
Date: Fri, 19 Sep 2008 02:28:27 +0000
Subject: [GIT]: Sparc
Message-Id: <20080918.192827.202370570.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Two bug fixes:

1) psycho_pcierr_intr_other() dereferences a NULL pointer.  Root
   PCI controller config space accesses need to be done by hand.
   Reported and tested by Meelis Roos on Sun Enterprise 3500.

2) We have several methods of booting up cpus, depending upon what
   features the firmware and/or hypervisor support.  On some of
   those paths we have to call C code before the current_thread_info()
   register can be setup properly.

   By calling C code invokes _mcount when the kernel is built with
   "-pg" (due to CONFIG_STACK_DEBUG or ftrace being enabled), and
   _mcount does stack depth checking using the current thread register
   because that defines the base of the current non-interrupt kernel
   stack.

   Fix this by marking these super-early-init routines as "notrace".

   Also reported and tested by Meelis Roos.

Please pull, thanks a lot!

The following changes since commit 6bfb09a1005193be5c81ebac9f3ef85210142650:
  Linus Torvalds (1):
        Merge master.kernel.org:/home/rmk/linux-2.6-arm

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (2):
      sparc64: Fix OOPS in psycho_pcierr_intr_other().
      sparc64: Fix SMP bootup with CONFIG_STACK_DEBUG or ftrace.

 arch/sparc64/kernel/irq.c        |    5 +++--
 arch/sparc64/kernel/pci_psycho.c |    8 +++++---
 arch/sparc64/kernel/traps.c      |    3 ++-
 3 files changed, 10 insertions(+), 6 deletions(-)
