From: David Miller <davem@davemloft.net>
Date: Sun, 02 Nov 2008 07:45:43 +0000
Subject: [GIT]: Sparc
Message-Id: <20081102.004543.74128246.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Couple of fixes:

1) Sparc32 build fix from Al Viro.

2) dbench over tmpfs OOPS fix on sparc64 from Hugh Dickins

3) PCI aperture MMAP fix on sparc64 from Max Dmitrichenko

4) Annoying build warning fix for sparc64 due to TASK_SIZE usage in
   compat ELF code

Please pull, thanks a lot!

The following changes since commit 770a424112cb2c3a3e39221299eaf5244b76479a:
  David S. Miller (1):
        sparc64: Add missing null terminating entry to bq4802_match[].

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

Al Viro (1):
      sparc32: kernel/trace/trace.c wants DIE_OOPS

David S. Miller (1):
      sparc64: Kill annoying warning when building compat_binfmt_elf.o

Hugh Dickins (1):
      sparc64: Fix __copy_{to,from}_user_inatomic defines.

Max Dmitrichenko (1):
      sparc64: Fix PCI resource mapping on sparc64

 arch/sparc/include/asm/kdebug_32.h    |    1 +
 arch/sparc/include/asm/processor_64.h |    4 ++--
 arch/sparc/include/asm/uaccess_64.h   |    4 ++--
 arch/sparc64/kernel/pci.c             |   10 +++++++++-
 4 files changed, 14 insertions(+), 5 deletions(-)
