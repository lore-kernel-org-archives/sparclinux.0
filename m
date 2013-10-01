From: David Miller <davem@davemloft.net>
Date: Tue, 01 Oct 2013 17:57:15 +0000
Subject: [GIT] Sparc
Message-Id: <20131001.135715.281466689271748264.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Just a single bug fix to a regression added during some strlcpy()
conversions.

Please pull, thanks a lot!

The following changes since commit 6cac446bd37d9381815fe4c2b0e7b1fd1085000c:

  Merge tag 'hwmon-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging (2013-09-27 10:07:47 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc master

for you to fetch changes up to 2bd161a605f1f84a5fc8a4fe8410113a94f79355:

  sparc64: Fix buggy strlcpy() conversion in ldom_reboot(). (2013-09-27 13:46:04 -0700)

----------------------------------------------------------------
David S. Miller (1):
      sparc64: Fix buggy strlcpy() conversion in ldom_reboot().

 arch/sparc/kernel/ds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
