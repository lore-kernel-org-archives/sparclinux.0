From: David Miller <davem@davemloft.net>
Date: Fri, 07 Aug 2015 02:19:24 +0000
Subject: [GIT] Sparc
Message-Id: <20150806.191924.2152593066743108226.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get this FPU register corruption bug fix.

Thanks!

The following changes since commit 4469942bbbe5ebf845e04971d8c74e9b6178f9fa:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2015-08-05 18:50:38 +0300)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc 

for you to fetch changes up to 44922150d87cef616fd183220d43d8fde4d41390:

  sparc64: Fix userspace FPU register corruptions. (2015-08-06 19:13:25 -0700)

----------------------------------------------------------------
David S. Miller (1):
      sparc64: Fix userspace FPU register corruptions.

 arch/sparc/include/asm/visasm.h | 16 +++++-----------
 arch/sparc/lib/NG4memcpy.S      |  5 ++++-
 arch/sparc/lib/VISsave.S        | 67 ++-----------------------------------------------------------------
 arch/sparc/lib/ksyms.c          |  4 ----
 4 files changed, 11 insertions(+), 81 deletions(-)
