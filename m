From: David Miller <davem@davemloft.net>
Date: Fri, 21 Feb 2014 17:42:21 +0000
Subject: [GIT] Sparc
Message-Id: <20140221.124221.1462375836908737857.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get these three minor fixes from David Howells
and Paul Gortmaker.

Thanks!

The following changes since commit e95003c3f9ccbfa7ab9d265e6eb703ee2fa4cfe7:

  Merge tag 'nfs-for-3.14-4' of git://git.linux-nfs.org/projects/trondmy/linux-nfs (2014-02-19 12:13:02 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

for you to fetch changes up to 967f038e491bc0aa469c4187aab7715ee9069ae1:

  Sparc: sparc_cpu_model isn't in asm/system.h any more [ver #2] (2014-02-20 13:34:11 -0500)

----------------------------------------------------------------
David Howells (1):
      Sparc: sparc_cpu_model isn't in asm/system.h any more [ver #2]

Paul Gortmaker (2):
      sparc32: fix build failure for arch_jump_label_transform
      sparc32: make copy_to/from_user_page() usable from modular code

 arch/sparc/Kconfig          | 2 +-
 arch/sparc/mm/srmmu.c       | 2 ++
 drivers/sbus/char/jsflash.c | 1 -
 3 files changed, 3 insertions(+), 2 deletions(-)
