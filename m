From: David Miller <davem@davemloft.net>
Date: Fri, 23 Nov 2012 19:48:31 +0000
Subject: [GIT] Sparc
Message-Id: <20121123.144831.453731602280182518.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull in this bug fix from Al Viro.

Thanks!

The following changes since commit 3587b1b097d70c2eb9fee95ea7995d13c05f66e5:

  fanotify: fix FAN_Q_OVERFLOW case of fanotify_read() (2012-11-18 09:30:00 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc master

for you to fetch changes up to fae2ae2a900a5c7bb385fe4075f343e7e2d5daa2:

  sparc64: not any error from do_sigaltstack() should fail rt_sigreturn() (2012-11-18 22:27:03 -0500)

----------------------------------------------------------------
Al Viro (1):
      sparc64: not any error from do_sigaltstack() should fail rt_sigreturn()

 arch/sparc/kernel/signal_64.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)
