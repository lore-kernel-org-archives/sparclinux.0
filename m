From: David Miller <davem@davemloft.net>
Date: Tue, 06 Dec 2016 17:19:26 +0000
Subject: [GIT] Sparc
Message-Id: <20161206.121926.1082253307431835601.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get this quick use-before-NULL-check from Dan
Carpenter.

Thanks!

The following changes since commit 88abd8249ee8bcebb98c90e890ea5e342db832af:

  Merge branch 'for-4.9-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata (2016-11-28 14:17:10 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 163117e8d4fd7a235ec48479e31bbda0c74eff56:

  dbri: move dereference after check for NULL (2016-12-06 12:18:22 -0500)

----------------------------------------------------------------
Dan Carpenter (1):
      dbri: move dereference after check for NULL

 sound/sparc/dbri.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
