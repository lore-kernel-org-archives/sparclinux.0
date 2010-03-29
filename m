From: David Miller <davem@davemloft.net>
Date: Mon, 29 Mar 2010 20:11:41 +0000
Subject: [GIT] Sparc
Message-Id: <20100329.131141.80866523.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get these Sparc fixes, thanks!

The following changes since commit b72c40949b0f04728f2993a1434598d3bad094ea:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../jbarnes/pci-2.6

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (1):
      sparc64: Properly truncate pt_regs framepointer in perf callback.

Julia Lawall (1):
      arch/sparc/kernel: Use set_cpus_allowed_ptr

Rob Landley (1):
      sparc: Fix use of uid16_t and gid16_t in asm/stat.h

 arch/sparc/include/asm/stat.h    |    4 ++--
 arch/sparc/kernel/perf_event.c   |    2 +-
 arch/sparc/kernel/sysfs.c        |    4 ++--
 arch/sparc/kernel/us2e_cpufreq.c |    8 ++++----
 arch/sparc/kernel/us3_cpufreq.c  |    8 ++++----
 5 files changed, 13 insertions(+), 13 deletions(-)

