From: David Miller <davem@davemloft.net>
Date: Mon, 24 Mar 2014 19:18:02 +0000
Subject: [GIT] Sparc
Message-Id: <20140324.151802.793262482697812078.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get these sparc fixes:

1) Do serial locking in a way that makes things clear that
   these are IRQ spinlocks.

2) Conversion to generic idle loop broke first generation
   Niagara machines, need to have %pil interrupts enabled
   during cpu yield hypervisor call.

3) Do not use magic constants for iterations over tsb
   tables, from Doug Wilson.

4) Fix erroneous truncation of 64-bit system call return
   values to 32-bit.  From Dave Kleikamp.

Please pull, thanks a lot!

The following changes since commit c3bebc71c4bcdafa24b506adf0c1de3c1f77e2e0:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2014-03-04 08:44:32 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

for you to fetch changes up to cb3042d609e30e6144024801c89be3925106752b:

  sparc64: Make sure %pil interrupts are enabled during hypervisor yield. (2014-03-24 14:45:12 -0400)

----------------------------------------------------------------
Dave Kleikamp (1):
      sparc64: don't treat 64-bit syscall return codes as 32-bit

David Miller (1):
      sparc: serial: Clean up the locking for -rt

David S. Miller (1):
      sparc64: Make sure %pil interrupts are enabled during hypervisor yield.

Doug Wilson (1):
      sparc64:tsb.c:use array size macro rather than number

 arch/sparc/kernel/process_64.c |  4 +++-
 arch/sparc/kernel/syscalls.S   |  4 ++--
 arch/sparc/mm/tsb.c            |  2 +-
 drivers/tty/serial/sunhv.c     | 22 ++++++++++------------
 drivers/tty/serial/sunsab.c    | 14 +++++---------
 drivers/tty/serial/sunsu.c     | 14 +++++---------
 drivers/tty/serial/sunzilog.c  | 14 +++++---------
 7 files changed, 31 insertions(+), 43 deletions(-)
