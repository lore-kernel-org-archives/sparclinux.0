From: David Miller <davem@davemloft.net>
Date: Thu, 18 Oct 2018 23:33:23 +0000
Subject: [GIT] Sparc
Message-Id: <20181018.163323.331525365210775149.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


The main bit here is fixing how fallback system calls are handled in
the sparc vDSO.

Unfortunately, I fat fingered the commit and some perf debugging hacks
slipped into the vDSO fix, which I revert in the very next commit.

Please pull, thanks a lot!

The following changes since commit c343db455eb3105f11bb5ac290d77ab2006b0209:

  Merge branch 'parisc-4.19-3' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux (2018-10-17 14:01:00 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 27faeebd00813cd52a140e8944b6b32729b50e61:

  sparc: Revert unintended perf changes. (2018-10-18 11:32:29 -0700)

----------------------------------------------------------------
Dan Carpenter (1):
      sparc: vDSO: Silence an uninitialized variable warning

David S. Miller (2):
      sparc: Fix syscall fallback bugs in VDSO.
      sparc: Revert unintended perf changes.

 arch/sparc/vdso/vclock_gettime.c | 12 +++++++++++-
 arch/sparc/vdso/vma.c            |  4 +++-
 2 files changed, 14 insertions(+), 2 deletions(-)
