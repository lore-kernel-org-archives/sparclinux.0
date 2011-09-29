From: David Miller <davem@davemloft.net>
Date: Thu, 29 Sep 2011 19:31:02 +0000
Subject: [GIT] Sparc
Message-Id: <20110929.153102.2109075340222189134.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


The firmware exec bit problem took nearly 2 weeks to find, not
fun.

Please pull, thanks a lot!

The following changes since commit d5767c53535ac79758084773418e0ad186aba4a2:

  bootup: move 'usermodehelper_enable()' to the end of do_basic_setup() (2011-09-28 10:23:44 -0700)

are available in the git repository at:
  git://github.com/davem330/sparc.git master

David S. Miller (3):
      sparc64: Future proof Niagara cpu detection.
      sparc: Make '-p' boot option meaningful again.
      sparc64: Force the execute bit in OpenFirmware's translation entries.

Mathias Krause (1):
      sparc, exec: remove redundant addr_limit assignment

 arch/sparc/include/asm/spitfire.h |    2 ++
 arch/sparc/include/asm/xor_64.h   |    4 +++-
 arch/sparc/kernel/cpu.c           |   12 ++++++++++++
 arch/sparc/kernel/cpumap.c        |    2 ++
 arch/sparc/kernel/head_64.S       |   25 ++++++++++++++++++++++---
 arch/sparc/kernel/process_32.c    |    3 +--
 arch/sparc/kernel/process_64.c    |    3 ---
 arch/sparc/kernel/setup_32.c      |    2 +-
 arch/sparc/kernel/setup_64.c      |   18 +++++++++++++-----
 arch/sparc/mm/init_64.c           |    5 +++++
 10 files changed, 61 insertions(+), 15 deletions(-)
