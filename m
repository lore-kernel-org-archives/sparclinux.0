From: Atish Patra <atish.patra@oracle.com>
Date: Wed, 28 Sep 2016 20:01:18 +0000
Subject: [PATCH v2 0/2] Fixes nr_cpus bug along with irq stack bootmem allocation.
Message-Id: <1475092880-85252-1-git-send-email-atish.patra@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The first patch fixes a panic caused by nr_cpus boot parameter.
In addition to that, irq stack boot memory is allocated before 
cpu_possible_mask is modified. This can lead to wastage of boot
memory if nr_cpus is set to a lower value. The second patch
addresses this issue.

v1->v2:
    Fixed compilation error in the v2 1/2 when CONFIG_SMP is not set.

Atish Patra (2):
  sparc64: Fix cpu_possible_mask if nr_cpus is set
  sparc64: Fix irq stack bootmem allocation.

 arch/sparc/include/asm/smp_64.h |    2 ++
 arch/sparc/kernel/setup_64.c    |   26 ++++++++++++++++++++++++++
 arch/sparc/kernel/smp_64.c      |   14 ++++++++++++++
 arch/sparc/mm/init_64.c         |   16 ----------------
 4 files changed, 42 insertions(+), 16 deletions(-)

