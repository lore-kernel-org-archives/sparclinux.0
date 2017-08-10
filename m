From: David Miller <davem@davemloft.net>
Date: Thu, 10 Aug 2017 05:26:18 +0000
Subject: [GIT] Sparc
Message-Id: <20170809.222618.2480234611970585.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get these sparc changes:

1) Recognize M8 cpus, just basic chip ID matching, from Allen Pais.

2) Prevent crashes when bringing up sunvdc virtual block devices in
   some environments.  From Jim Quigley.

Thanks!

The following changes since commit 0a23ea65ce9f10ec2ea392571006b781b150327f:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc (2017-08-04 10:17:45 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 3ee70591d6c47ef4c4699b3395ba96ce287db937:

  sunvdc: prevent sunvdc panic when mpgroup disk added to guest domain (2017-08-09 22:22:32 -0700)

----------------------------------------------------------------
Allen Pais (2):
      sparc64: properly name the cpu constants
      sparc64: recognize and support sparc M8 cpu type

Jim Quigley (1):
      sunvdc: prevent sunvdc panic when mpgroup disk added to guest domain

Vijay Kumar (1):
      sparc64: Increase max_phys_bits to 51 and VA bits to 53 for M8.

 arch/sparc/include/asm/spitfire.h | 16 ++++++++++++++++
 arch/sparc/kernel/cpu.c           |  6 ++++++
 arch/sparc/kernel/cpumap.c        |  1 +
 arch/sparc/kernel/head_64.S       | 22 ++++++++++++++--------
 arch/sparc/kernel/setup_64.c      | 15 +++++++++++++--
 arch/sparc/mm/init_64.c           | 14 +++++++++++++-
 drivers/block/sunvdc.c            | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 124 insertions(+), 11 deletions(-)
