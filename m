From: David Miller <davem@davemloft.net>
Date: Mon, 08 Sep 2008 20:59:01 +0000
Subject: [GIT]: Sparc
Message-Id: <20080908.135901.206413625.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Two SMP fixes for sparc64:

1) Conversion to generic SMP call function helpers didn't update the
   locking.  The sparc64 code was still using it's local "call lock"
   in it's cpu hotplug code, yet that isn't used for smp_call_function()
   et al. any longer.  Fix to use the locking interface exposed by
   the generic code.

2) Bug fix from Paul McKenney so that the online cpu map is cleared
   at the correct moment during cpu hotplug.  Otherwise an offline
   CPU can receive an interrupt and lots of code does not like that.

Please pull, thanks a lot.

The following changes since commit dbb8c35d9063fe233626865cc836fbc102fa083b:
  David S. Miller (1):
        sparc64: setup_valid_addr_bitmap_from_pavail() should be __init

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (1):
      sparc64: Fix IPI call locking.

Paul E. McKenney (1):
      sparc64: Prevent sparc64 from invoking irq handlers on offline CPUs

 arch/sparc64/kernel/smp.c |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)
