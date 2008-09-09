From: David Miller <davem@davemloft.net>
Date: Tue, 09 Sep 2008 23:13:05 +0000
Subject: [GIT]: Sparc
Message-Id: <20080909.161305.140912606.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


I had always gotten strange wedges when hot plugging cpus on
Niagara boxes via the hypervisor, and I think the following
bug spotted by Paul McKenney finally nails it.

Please pull, thanks a lot.

The following changes since commit 4d084617fb0d025c42c242362d1f27d337e2d407:
  Paul E. McKenney (1):
        sparc64: Prevent sparc64 from invoking irq handlers on offline CPUs

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (1):
      sparc64: Disable timer interrupts in fixup_irqs().

 arch/sparc64/kernel/irq.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)
