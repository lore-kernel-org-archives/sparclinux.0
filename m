From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Mon, 22 Feb 2016 03:13:09 +0000
Subject: [PATCH 0/3] video/fbdev: avoid module usage in non-modular sparc code
Message-Id: <1456110792-21771-1-git-send-email-paul.gortmaker@windriver.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, "David S. Miller" <davem@davemloft.net>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, sparclinux@vger.kernel.org

This series of commits is a part of a larger project to ensure
people don't reference modular support functions in non-modular
code.  Overall there was roughly 5k lines of dead code in the
kernel due to this.  So far we've fixed several areas, like tty,
x86, net, ... and we continue to work on other areas.

There are several reasons to not use module support for code that
can never be built as a module, but the big ones are:

 (1) it is easy to accidentally write unused module_exit and remove code
 (2) it can be misleading when reading the source, thinking it can be
     modular when the Makefile and/or Kconfig prohibit it
 (3) it requires the include of the module.h header file which in turn
     includes nearly everything else, thus adding to CPP overhead.
 (4) it gets copied/replicated into other code and spreads like weeds.

For the video fb subsystem, I have about 40 commits in my personal
testing queue, but rather than overwhelm maintainers with a large
patch series, I'm looking for subsets within that to keep the Cc on
the series and the 00/N boiler-plate to a sane amount.

To that end, the sparc specific fb drivers is a nice small subset
that can be used to test the waters in the video subsystem, to ensure
the overall goals here are OK with everyone maintaining fb code.

The disallow of unbind might seem like overkill, but for drivers that
had a ".remove" function, it is the only way we can block people from
abusing existing infrastructure in order to continue getting at that
otherwise dead function call that we want to remove.

We toss out a net amount of about 80 lines of dead code here in just
three commits; not groundbreaking, but a step in the right direction.

Build tested for sparc64, allmodconfig; but with CONFIG_FB=y as the
drivers here all depend on this specific value to get enabled.

Paul.
---

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org
Cc: sparclinux@vger.kernel.org

Paul Gortmaker (3):
  drivers/video: make fbdev/sunxvr500.c explicitly non-modular
  drivers/video: make fbdev/sunxvr1000.c explicitly non-modular
  drivers/video: make fbdev/sunxvr2500.c explicitly non-modular

 drivers/video/fbdev/sunxvr1000.c | 42 +++++++---------------------------------
 drivers/video/fbdev/sunxvr2500.c | 39 +++++++------------------------------
 drivers/video/fbdev/sunxvr500.c  | 42 +++++++---------------------------------
 3 files changed, 21 insertions(+), 102 deletions(-)

-- 
2.6.1
