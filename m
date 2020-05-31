From: Al Viro <viro@zeniv.linux.org.uk>
Date: Sun, 31 May 2020 01:04:14 +0000
Subject: [git pull] a couple of sparc ptrace fixes
Message-Id: <20200531010414.GW23230@ZenIV.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git for-davem

for you to fetch changes up to cf51e129b96847f969bfb8af1ee1516a01a70b39:

  sparc32: fix register window handling in genregs32_[gs]et() (2020-05-20 13:29:37 -0400)

----------------------------------------------------------------
Al Viro (2):
      sparc64: fix misuses of access_process_vm() in genregs32_[sg]et()
      sparc32: fix register window handling in genregs32_[gs]et()

 arch/sparc/kernel/ptrace_32.c | 228 ++++++++++++++++++------------------------
 arch/sparc/kernel/ptrace_64.c |  17 +---
 2 files changed, 101 insertions(+), 144 deletions(-)
