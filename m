From: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Date: Fri, 04 Jan 2013 02:58:10 +0000
Subject: [PATCH 0/2] cpuhotplug/nohz: Fix issue of "negative" idle time
Message-Id: <1357268290-7956-1-git-send-email-vatsa@codeaurora.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On most architectures (arm, mips, s390, sh and x86) idle thread of a cpu does
not cleanly exit nohz state before dying upon hot-remove. As a result,
offline cpu is seen to be in nohz mode (ts->idle_active = 1) and its offline
time can potentially be included in total idle time reported via /proc/stat.
When the same cpu later comes online, its offline time however is not included
in its idle time statistics, thus causing a rollback in total idle time to be
observed by applications like top.

Example output from Android top command highlighting this issue is below:

User 232%, System 70%, IOW 46%, IRQ 1%
User 1322 + Nice 0 + Sys 399 + Idle -1423 + IOW 264 + IRQ 0 + SIRQ 7 = 569

top is reporting system to be idle for -1423 ticks over some sampling period.
This happens as total idle time reported in cpu line of /proc/stat *dropped*
from the last value observed (cached) by top command.

While this was originally seen on a ARM platform running 3.4 based kernel, I
could easily recreate it on my x86 desktop running latest tip/master kernel
(HEAD 3a7bfcad). Online/offline a cpu in a tight loop and in another loop read
/proc/stat and observe if total idle time drops from previously read value.

Although commit 7386cdbf (nohz: Fix idle ticks in cpu summary line of
/proc/stat) aims to avoid this bug, its not preemption proof. A
thread could get preempted after the cpu_online() check in get_idle_time(), thus
potentially leading to get_cpu_idle_time_us() being invoked on a offline cpu.

One potential fix is to serialize hotplug with /proc/stat read operation (via
use of get/put_online_cpus()), which I disliked in favor of the other
solution proposed in this series.

In this patch series:

- Patch 1/2 modifies idle loop on architectures arm, mips, s390, sh and x86 to
  exit nohz state before the associated idle thread dies upon hotremove. This
  fixes the idle time accounting bug.

  Patch 1/2 also modifies idle loop on all architectures supporting cpu hotplug
  to have idle thread of a dying cpu die immediately after schedule() returns
  control to it. I see no point in wasting time via calls to *_enter()/*_exit()
  before noticing the need to die and dying.

- Patch 2/2 reverts commit 7386cdbf (nohz: Fix idle ticks in cpu summary line of
  /proc/stat). The cpu_online() check introduced by it is no longer necessary
  with Patch 1/2 applied. Having fewer code sites worry about online status of
  cpus is a good thing!

---

 arch/arm/kernel/process.c      |    9 ++++-----
 arch/arm/kernel/smp.c          |    2 +-
 arch/blackfin/kernel/process.c |    8 ++++----
 arch/mips/kernel/process.c     |    6 +++---
 arch/powerpc/kernel/idle.c     |    2 +-
 arch/s390/kernel/process.c     |    4 ++--
 arch/sh/kernel/idle.c          |    5 ++---
 arch/sparc/kernel/process_64.c |    3 ++-
 arch/x86/kernel/process.c      |    5 ++---
 fs/proc/stat.c                 |   14 ++++----------
 10 files changed, 25 insertions(+), 33 deletions(-)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation

