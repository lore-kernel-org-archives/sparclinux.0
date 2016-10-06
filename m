From: Babu Moger <babu.moger@oracle.com>
Date: Thu, 06 Oct 2016 22:16:41 +0000
Subject: [PATCH 0/2] Introduce update_arch_nmi_watchdog for arch specific handlers
Message-Id: <1475792203-230942-1-git-send-email-babu.moger@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mingo@kernel.org, akpm@linux-foundation.org, ak@linux.intel.com, jkosina@suse.cz, baiyaowei@cmss.chinamobile.com, dzickus@redhat.com, atomlin@redhat.com, uobergfe@redhat.com, tj@kernel.org, hidehiro.kawai.ez@hitachi.com, johunt@akamai.com, davem@davemloft.net, sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, babu.moger@oracle.com

During our testing we noticed that nmi watchdogs in sparc could not be disabled or
enabled dynamically using sysctl/proc interface. Sparc uses its own arch specific
nmi watchdogs. There is a sysctl and proc interface(proc/sys/kernel/nmi_watchdog)
to enable/disable nmi watchdogs. However, that is not working for sparc. There
is no interface to feed this parameter to arch specific nmi watchdogs.

These patches extend the same sysctl/proc interface to enable or disable
these arch specific nmi watchdogs dynamically. Introduced new function
update_arch_nmi_watchdog which can be implemented in arch specific handlers.
If you think there is a better way to do this. Please advice.

Tested on sparc. Compile tested on x86.

Babu Moger (2):
  watchdog: Introduce update_arch_nmi_watchdog
  sparc: Implement update_arch_nmi_watchdog

 arch/sparc/kernel/nmi.c |   26 ++++++++++++++++++++++++++
 include/linux/nmi.h     |    1 +
 kernel/watchdog.c       |   16 +++++++++++++---
 3 files changed, 40 insertions(+), 3 deletions(-)

