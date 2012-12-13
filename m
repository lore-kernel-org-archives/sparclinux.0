From: David Miller <davem@davemloft.net>
Date: Thu, 13 Dec 2012 20:11:33 +0000
Subject: [GIT] Sparc
Message-Id: <20121213.151133.2012383937905504753.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Not much going on this release cycle in sparc land, just a Kconfig
tweak.

Please pull, thanks a lot!

The following changes since commit 1afa471706963643ceeda7cbbe9c605a1e883d53:

  Merge tag 'mmc-fixes-for-3.7' of git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc (2012-12-07 09:15:20 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc-next.git master

for you to fetch changes up to 476ab8fb78105f525cc56babb3980ffdd916aa24:

  of_i2c: sparc: Allow OF_I2C for sparc (2012-12-07 09:17:55 -0800)

----------------------------------------------------------------
Andreas Larsson (1):
      of_i2c: sparc: Allow OF_I2C for sparc

 drivers/of/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
