From: David Miller <davem@davemloft.net>
Date: Sun, 31 Dec 2017 04:17:30 +0000
Subject: [GIT] Sparc
Message-Id: <20171230.231730.743983402971397348.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get this sparc64 bug fix.

Thank you!

The following changes since commit 5f520fc318764df800789edd202b5e3b55130613:

  Merge tag 'trace-v4.15-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace (2017-12-27 13:06:57 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc 

for you to fetch changes up to 59585b4be9ae4dc6506551709bdcd6f5210b8a01:

  sparc64: repair calling incorrect hweight function from stubs (2017-12-27 20:29:48 -0500)

----------------------------------------------------------------
Jan Engelhardt (1):
      sparc64: repair calling incorrect hweight function from stubs

 arch/sparc/lib/hweight.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
