From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Wed, 31 May 2017 15:25:19 +0000
Subject: [v1 0/6] sparc64: context wrap fixes
Message-Id: <1496244325-180257-1-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This patch series contains fixes for context wrap: when we are out of
context ids, and need to get a new version.

It fixes memory corruption issues which happen when more than number of
context ids (currently set to 8K) number of processes are started
simultaneously, and processes can get a wrong context.

sparc64: new context wrap:
- contains explanation of new wrap method, and also explanation of races
  that it solves
sparc64: reset mm cpumask after wrap
- explains issue of not reseting cpu mask on a wrap

Pavel Tatashin (6):
  sparc64: reset mm cpumask after wrap
  sparc64: combine activate_mm and switch_mm
  sparc64: redefine first version
  sparc64: add per-cpu mm of secondary contexts
  sparc64: new context wrap
  sparc64: delete old wrap code

 arch/sparc/include/asm/mmu_64.h         |    2 +-
 arch/sparc/include/asm/mmu_context_64.h |   32 ++----------
 arch/sparc/include/asm/pil.h            |    1 -
 arch/sparc/kernel/kernel.h              |    1 -
 arch/sparc/kernel/smp_64.c              |   31 -----------
 arch/sparc/kernel/ttable_64.S           |    2 +-
 arch/sparc/mm/init_64.c                 |   86 +++++++++++++++++++++----------
 arch/sparc/mm/ultra.S                   |    5 --
 8 files changed, 64 insertions(+), 96 deletions(-)

