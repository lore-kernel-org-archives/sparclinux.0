From: Babu Moger <babu.moger@oracle.com>
Date: Mon, 26 Sep 2016 22:31:36 +0000
Subject: [PATCH v2 0/2] Ajust lockdep static allocations for sparc
Message-Id: <1474929098-68914-1-git-send-email-babu.moger@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: peterz@infradead.org, mingo@redhat.com, akpm@linux-foundation.org, keescook@chromium.org, dan.j.williams@intel.com, aryabinin@virtuozzo.com, tj@kernel.org
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, babu.moger@oracle.com

These patches limit the static allocations for lockdep
data structures used for debugging locking correctness. This is required
for sparc as it requires .text, .data and .bss to fit in required 32MB
limit for the kernel. Right now, with PROVE_LOCKING enabled we could
go over this limit and cause system boot-up problems. These patches
limit the static allocations so that everything fits in current required
space limit. This is only visible for sparc.

patch 1 : Adds new config parameter CONFIG_PROVE_LOCKING_SMALL
Patch 2 : Adjusts the sizes based on the new config parameter

v1-> v2:
   As suggested by Peter Zijlstra, keeping the default as is.
   Introduced new config variable CONFIG_PROVE_LOCKING_SMALL
   to handle sparc specific case.

v0:
   Initial revision.

Babu Moger (2):
  config: Add new CONFIG_PROVE_LOCKING_SMALL
  lockdep: Keep the static allocations small for PROVE_LOCKING_SMALL

 kernel/locking/lockdep_internals.h |   13 ++++++++++---
 lib/Kconfig.debug                  |   17 +++++++++++++++++
 2 files changed, 27 insertions(+), 3 deletions(-)

