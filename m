From: Babu Moger <babu.moger@oracle.com>
Date: Wed, 26 Oct 2016 16:02:19 +0000
Subject: [RFC PATCH 0/4] Clean up watchdog handlers
Message-Id: <1477497743-15357-1-git-send-email-babu.moger@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mingo@kernel.org, akpm@linux-foundation.org, ak@linux.intel.com, jkosina@suse.cz, baiyaowei@cmss.chinamobile.com, dzickus@redhat.com, atomlin@redhat.com, uobergfe@redhat.com, tj@kernel.org, hidehiro.kawai.ez@hitachi.com, johunt@akamai.com, davem@davemloft.net, sparclinux@vger.kernel.org
Cc: bp@suse.de, bywxiaobai@163.com, cmetcalf@mellanox.com, keescook@chromium.org, ebiederm@xmission.com, huawei.libin@huawei.com, ralf@linux-mips.org, dvyukov@google.com, linux-kernel@vger.kernel.org, sam@ravnborg.org, babu.moger@oracle.com

This is an attempt to cleanup watchdog handlers. Right now,
kernel/watchdog.c implements both softlockup and hardlockup detectors.
Softlockup code is generic. Hardlockup code is arch specific. Some
architectures don't use hardlockup detectors. They use their own watchdog
detectors. To make both these combination work, we have numerous #ifdefs
in kernel/watchdog.c.

We are trying here to make these handlers independent of each other.
Also provide an interface for architectures to implement their own
handlers. watchdog_nmi_enable and watchdog_nmi_disable will be defined
as weak such that architectures can override its definitions.

Thanks to Don Zickus for his suggestions.
Here is the previous discussion
http://www.spinics.net/lists/sparclinux/msg16441.html

Babu Moger (4):
  watchdog: Remove hardlockup handler references
  watchdog: Move shared definitions to nmi.h
  watchdog: Move hardlockup detector in separate file
  sparc: Implement watchdog_nmi_enable and watchdog_nmi_disable

 arch/sparc/kernel/nmi.c |   44 ++++++++-
 include/linux/nmi.h     |   19 ++++
 kernel/Makefile         |    1 +
 kernel/watchdog.c       |  276 ++---------------------------------------------
 kernel/watchdog_hld.c   |  238 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 312 insertions(+), 266 deletions(-)
 create mode 100644 kernel/watchdog_hld.c

