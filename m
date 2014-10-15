From: David Miller <davem@davemloft.net>
Date: Wed, 15 Oct 2014 18:45:49 +0000
Subject: [GIT] Sparc
Message-Id: <20141015.144549.2109697499585289654.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get this sparc64 AES ctr mode bug fix.

Thanks!

The following changes since commit 2d65a9f48fcdf7866aab6457bc707ca233e0c791:

  Merge branch 'drm-next' of git://people.freedesktop.org/~airlied/linux (2014-10-14 09:39:08 +0200)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

for you to fetch changes up to f4da3628dc7c32a59d1fb7116bb042e6f436d611:

  sparc64: Fix FPU register corruption with AES crypto offload. (2014-10-14 19:37:58 -0700)

----------------------------------------------------------------
David S. Miller (1):
      sparc64: Fix FPU register corruption with AES crypto offload.

 arch/sparc/include/asm/visasm.h |  8 ++++++++
 arch/sparc/lib/NG4memcpy.S      | 14 +++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)
