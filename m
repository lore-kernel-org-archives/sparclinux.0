From: David Miller <davem@davemloft.net>
Date: Mon, 23 Mar 2015 16:55:37 +0000
Subject: [GIT] Sparc
Message-Id: <20150323.125537.767987027704780801.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Some perf bug fixes from David Ahern, and the fix for that nasty
memmove() bug.

Please pull, thanks a lot!

The following changes since commit b314acaccd7e0d55314d96be4a33b5f50d0b3344:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input (2015-03-19 16:43:10 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

for you to fetch changes up to 2077cef4d5c29cf886192ec32066f783d6a80db8:

  sparc64: Fix several bugs in memmove(). (2015-03-23 09:22:10 -0700)

----------------------------------------------------------------
David Ahern (4):
      sparc: perf: Remove redundant perf_pmu_{en|dis}able calls
      sparc: perf: Make counting mode actually work
      sparc: perf: Add support M7 processor
      sparc: Touch NMI watchdog when walking cpus and calling printk

David S. Miller (1):
      sparc64: Fix several bugs in memmove().

 arch/sparc/include/asm/hypervisor.h | 12 ++++++++++++
 arch/sparc/kernel/hvapi.c           |  1 +
 arch/sparc/kernel/hvcalls.S         | 16 ++++++++++++++++
 arch/sparc/kernel/pcr.c             | 33 +++++++++++++++++++++++++++++++++
 arch/sparc/kernel/perf_event.c      | 55 +++++++++++++++++++++++++++++++++++++++++++------------
 arch/sparc/kernel/process_64.c      |  4 ++++
 arch/sparc/lib/memmove.S            | 35 ++++++++++++++++++++++++++++++++---
 7 files changed, 141 insertions(+), 15 deletions(-)
