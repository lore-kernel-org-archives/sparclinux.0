From: David Miller <davem@davemloft.net>
Date: Mon, 25 Aug 2008 03:40:30 +0000
Subject: [GIT]: Sparc
Message-Id: <20080824.204030.193703137.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get these two sparc changes:

1) NUMA needs to depend upon SMP

2) 32-bit sparc needs a stripped kernel target so that
   the pkg-* targets work, from Martin Habets.

Thanks a lot!

The following changes since commit 83097aca8567a0bd593534853b71fe0fa9a75d69:
  Arjan van de Ven (1):
        Fix oops in acer_wmi driver (acer_wmi_init)

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (1):
      sparc64: Make NUMA depend upon SMP.

Martin Habets (1):
      sparc: Add target for a stripped kernel

 arch/sparc/Makefile      |    8 ++++++--
 arch/sparc/boot/Makefile |    6 ++++++
 arch/sparc64/Kconfig     |    1 +
 3 files changed, 13 insertions(+), 2 deletions(-)
