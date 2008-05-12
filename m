From: David Miller <davem@davemloft.net>
Date: Mon, 12 May 2008 07:58:09 +0000
Subject: [GIT]: Sparc
Message-Id: <20080512.005809.226545939.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


We have a 64-bit memory probing fix, and two 32-bit build fixes
from Robert Reif.

I'm still working on Mikael P's memory probing problem, which is
on the regression list.

Please pull, thanks a lot!

The following changes since commit 28e6103665301ce60634e8a77f0b657c6cc099de:
  David S. Miller (1):
        sparc: Fix debugger syscall restart interactions.

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (1):
      sparc64: Work around memory probing bug in openfirmware.

Robert Reif (2):
      sparc32: Fix build.
      sparc32: fix rtrap.S typo

 arch/sparc/kernel/rtrap.S  |    2 +-
 arch/sparc64/mm/init.c     |   16 +++++++++++-----
 include/asm-sparc/ptrace.h |    2 ++
 3 files changed, 14 insertions(+), 6 deletions(-)
