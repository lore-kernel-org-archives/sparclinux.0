From: David Miller <davem@davemloft.net>
Date: Fri, 21 Sep 2012 19:48:45 +0000
Subject: [GIT] Sparc
Message-Id: <20120921.154845.354229641603611101.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


1) Debugging builds on 32-bit sparc need to handle the R_SPARC_DISP32
   relocation, not just 64-bit sparc.  From Andreas Larsson.

2) Wei Yongjun noticed that module_alloc() on sparc can return an
   error pointer, but that's not allowed.  module_alloc() should
   return only a valid pointer, or NULL.

Please pull, thanks a lot!

The following changes since commit c46de2263f42fb4bbde411b9126f471e9343cb22:

  Merge branch 'for-linus' of git://git.kernel.dk/linux-block (2012-09-19 11:04:34 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

for you to fetch changes up to a9e8d1a6b87167116e5779378f1d25ffed2e833b:

  sparc: fix the return value of module_alloc() (2012-09-21 12:14:20 -0700)

----------------------------------------------------------------
Andreas Larsson (1):
      sparc32: Enable the relocation target R_SPARC_DISP32 for sparc32

Wei Yongjun (1):
      sparc: fix the return value of module_alloc()

 arch/sparc/kernel/module.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)
