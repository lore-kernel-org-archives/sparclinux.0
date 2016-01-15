From: David Miller <davem@davemloft.net>
Date: Fri, 15 Jan 2016 21:04:27 +0000
Subject: [GIT] Sparc
Message-Id: <20160115.160427.1372234591098101622.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get these two sparc bug fixes, thanks!

The following changes since commit 7fdec82af6a9e190e53d07a1463d2a9ac49a8750:

  Merge tag 'xfs-for-linus-4.5' of git://git.kernel.org/pub/scm/linux/kernel/git/dgc/linux-xfs (2016-01-13 21:15:18 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 36beca6571c941b28b0798667608239731f9bc3a:

  sparc64: Fix numa node distance initialization (2016-01-14 16:58:59 -0500)

----------------------------------------------------------------
Dmitry V. Levin (1):
      sparc64: fix incorrect sign extension in sys_sparc64_personality

Nitin Gupta (1):
      sparc64: Fix numa node distance initialization

 arch/sparc/kernel/sys_sparc_64.c |  2 +-
 arch/sparc/mm/init_64.c          | 15 ++++++++-------
 2 files changed, 9 insertions(+), 8 deletions(-)
