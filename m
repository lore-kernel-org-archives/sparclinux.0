From: David Miller <davem@davemloft.net>
Date: Wed, 22 Apr 2009 10:48:05 +0000
Subject: [GIT]: Sparc
Message-Id: <20090422.034805.63377383.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get this device probing bug fix and defconfig
updates for Sparc.

Thanks!

The following changes since commit 091069740304c979f957ceacec39c461d0192158:
  Linus Torvalds (1):
        Linux 2.6.30-rc3

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (3):
      sparc64: Update defconfig.
      sparc32: Update defconfig.
      sparc: Fix bus type probing for ESP and LE devices.

 arch/sparc/configs/sparc32_defconfig |   98 +++++++++++++------
 arch/sparc/configs/sparc64_defconfig |  182 ++++++++++++++++++++++------------
 arch/sparc/kernel/of_device_32.c     |   21 ++++-
 arch/sparc/kernel/of_device_64.c     |   21 ++++-
 4 files changed, 225 insertions(+), 97 deletions(-)
