From: Babu Moger <babu.moger@oracle.com>
Date: Tue, 01 Nov 2016 21:13:43 +0000
Subject: [PATCH v2 0/3] Clean up watchdog handlers
Message-Id: <1478034826-43888-1-git-send-email-babu.moger@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mingo@kernel.org, akpm@linux-foundation.org, ak@linux.intel.com, jkosina@suse.cz, baiyaowei@cmss.chinamobile.com, dzickus@redhat.com, atomlin@redhat.com, uobergfe@redhat.com, tj@kernel.org, hidehiro.kawai.ez@hitachi.com, johunt@akamai.com, davem@davemloft.net, sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org, babu.moger@oracle.com

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
Here are our previous discussions
http://www.spinics.net/lists/sparclinux/msg16543.html
http://www.spinics.net/lists/sparclinux/msg16441.html

v2:
  Addressed few comments from Don Zickus.
  1. Took care of bisectability issue. Previous patch2 is patch1 now.
     Combined patch 1 and 3. Patch 4 is now patch 3.
  2. Added pr_fmt back in watchdog_hld.c
  3. Tweaked the file headers for watchdog.c and watchdog_hld.c.

  4. Took care of couple of config compile issues.

   drivers/edac/edac_device.o:(.discard+0x0): multiple definition of `__pcpu_unique_hrtimer_interrupts'
   drivers/edac/edac_mc.o:(.discard+0x0): first defined here
   This was a problem with uni processor config. Moved the definition of hrtimer_interrupts and
   is_hardlockup into watchdog.c as softlockup code does most of the work here.
   is_hardlockup kind of generic most part.

   kernel/built-in.o: In function `watchdog_overflow_callback':
   watchdog_hld.c:(.text+0x56940): undefined reference to `sysctl_hardlockup_all_cpu_backtrace'
   Moved this definition to nmi.h.

v1:
  Initial version
Babu Moger (3):
  watchdog: Move shared definitions to nmi.h
  watchdog: Move hardlockup detector to separate file
  sparc: Implement watchdog_nmi_enable and watchdog_nmi_disable

 arch/sparc/kernel/nmi.c |   44 ++++++++-
 include/linux/nmi.h     |   24 ++++
 kernel/Makefile         |    1 +
 kernel/watchdog.c       |  270 +++--------------------------------------------
 kernel/watchdog_hld.c   |  227 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 310 insertions(+), 256 deletions(-)
 create mode 100644 kernel/watchdog_hld.c

