From: David Miller <davem@davemloft.net>
Date: Tue, 11 Nov 2008 06:23:00 +0000
Subject: [GIT]: Sparc
Message-Id: <20081110.222300.37708978.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


A revert to fix a 32-bit sparc bootup regression, and a defconfig
update for sparc64.

Please pull, thanks a lot.

The following changes since commit 3ad4f597058301c97f362e500a32f63f5c950a45:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../tiwai/sound-2.6

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (2):
      Revert "sparc: correct section of current_pc()"
      sparc64: Update defconfig.

 arch/sparc/kernel/head.S |    1 -
 arch/sparc64/defconfig   |  232 ++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 195 insertions(+), 38 deletions(-)
