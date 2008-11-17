From: David Miller <davem@davemloft.net>
Date: Mon, 17 Nov 2008 07:51:53 +0000
Subject: [GIT]: Sparc
Message-Id: <20081116.235153.246607423.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Highlights include a fix for a long standing sparc build warning
and dev_name() usage in sparc specific device layers (hopefully
this one doesn't introduce the kinds of bugs the ACPI case seems
to have :-)

Please pull, thanks a lot!

The following changes since commit 12de512ae1d6d150f95b7157cb3293ef7545676d:
  David S. Miller (1):
        sparc64: Update defconfig.

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

Alessandro Zummo (1):
      rtc: rtc-sun4v fixes, revised

Kay Sievers (1):
      sparc: struct device - replace bus_id with dev_name(), dev_set_name()

Robert Reif (1):
      sparc: Fix tty compile warnings.

 arch/sparc/include/asm/termbits.h |   11 +++---
 arch/sparc/kernel/of_device.c     |    4 +-
 drivers/rtc/rtc-sun4v.c           |   69 ++++++++++--------------------------
 3 files changed, 26 insertions(+), 58 deletions(-)
