From: Babu Moger <babu.moger@oracle.com>
Date: Tue, 27 Sep 2016 19:33:26 +0000
Subject: [PATCH v3 0/2] Ajust lockdep static allocations for sparc
Message-Id: <1475004808-91920-1-git-send-email-babu.moger@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: peterz@infradead.org, mingo@redhat.com, akpm@linux-foundation.org, keescook@chromium.org, dan.j.williams@intel.com, aryabinin@virtuozzo.com, tj@kernel.org, sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, babu.moger@oracle.com

These patches limit the static allocations for lockdep data structures
used for debugging locking correctness. For sparc, all the kernel's code,
data, and bss, must have locked translations in the TLB so that we don't
get TLB misses on kernel code and data. Current sparc chips have 8 TLB
entries available that may be locked down, and with a 4mb page size,
this gives a maximum of 32MB. With PROVE_LOCKING we could go over this
limit and cause system boot-up problems. These patches limit the static
allocations so that everything fits in current required size limit.

patch 1 : Adds new config parameter CONFIG_PROVE_LOCKING_SMALL
Patch 2 : Adjusts the sizes based on the new config parameter

v2-> v3:
   Some more comments from Sam Ravnborg and Peter Zijlstra.
   Defined PROVE_LOCKING_SMALL as invisible and moved the selection to
   arch/sparc/Kconfig. 

v1-> v2:
   As suggested by Peter Zijlstra, keeping the default as is.
   Introduced new config variable CONFIG_PROVE_LOCKING_SMALL
   to handle sparc specific case.

v0:
   Initial revision.

Babu Moger (2):
  config: Adding the new config parameter CONFIG_PROVE_LOCKING_SMALL
    for sparc
  lockdep: Limit static allocations if PROVE_LOCKING_SMALL is defined

 arch/sparc/Kconfig                 |    1 +
 kernel/locking/lockdep_internals.h |   20 +++++++++++++++++---
 lib/Kconfig.debug                  |    3 +++
 3 files changed, 21 insertions(+), 3 deletions(-)

