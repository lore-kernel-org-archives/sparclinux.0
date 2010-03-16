From: David Miller <davem@davemloft.net>
Date: Tue, 16 Mar 2010 21:46:37 +0000
Subject: [GIT]: Sparc
Message-Id: <20100316.144637.223372881.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Fix sunxvr1000 depenencies.

Fix register bit macro used to set interrupt mask in sunsab driver,
from Julia Lawall.

Add MAINTAINERS entry for Sun serial drivers.

Please pull, thanks a lot!

The following changes since commit a3d3203e4bb40f253b1541e310dc0f9305be7c84:
  Linus Torvalds (1):
        Merge branch 'release' of git://git.kernel.org/.../lenb/linux-acpi-2.6

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (2):
      MAINTAINERS: Add entry for sparc serial drivers.
      sunxvr1000: Add missing FB=y depenency.

Julia Lawall (1):
      drivers/serial/sunsab.c: adjust the constant used to initialize the interrupt_mask0 fields

 MAINTAINERS             |   15 +++++++++++++++
 drivers/serial/sunsab.c |    2 +-
 drivers/video/Kconfig   |    2 +-
 3 files changed, 17 insertions(+), 2 deletions(-)
