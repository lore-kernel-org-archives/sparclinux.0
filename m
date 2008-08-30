From: David Miller <davem@davemloft.net>
Date: Sat, 30 Aug 2008 20:01:01 +0000
Subject: [GIT]: Sparc
Message-Id: <20080830.130101.155904510.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Three Sparc bug fixes:

1) CONFIG_RELAY recently started using smp_call_function_single()
   even though that was not previously referenced from generic
   code.

   Anyways, add an implementation to 32-bit sparc to fix the
   build with RELAY enabled.

2) Resource flag setting fix for PCI sub-devices.

3) Section mismatch fix in sparc64 MM initialization code.

Please pull, thanks a lot!

The following changes since commit 349101da8e1f8e5eb1476b02823da80495224485:
  Martin Habets (1):
        sparc: Add target for a stripped kernel

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (3):
      sparc32: Implement smp_call_function_single().
      sparc: Fix resource flags for PCI children in OF device tree.
      sparc64: setup_valid_addr_bitmap_from_pavail() should be __init

 arch/sparc/include/asm/smp_32.h |   25 +++++++++++++++----------
 arch/sparc/kernel/of_device.c   |   19 ++++++++++++++-----
 arch/sparc/kernel/sun4d_smp.c   |   16 ++++++++++------
 arch/sparc/kernel/sun4m_smp.c   |   12 ++++++++----
 arch/sparc64/kernel/of_device.c |   20 ++++++++++++++------
 arch/sparc64/mm/init.c          |    2 +-
 6 files changed, 62 insertions(+), 32 deletions(-)
