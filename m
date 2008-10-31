From: David Miller <davem@davemloft.net>
Date: Fri, 31 Oct 2008 06:02:56 +0000
Subject: [GIT]: Sparc
Message-Id: <20081030.230256.167447008.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Some fixes and tidies:

1) RTC m48t59 century bit handling fix from Krzysztof Helt

2) Byte ordering tidies from Harvey Harrison
   a) PIO string ops don't need to use explicit byte shifting
   b) sparc can easily use the new byteorder headers

3) dbri sound driver doesn't check for dma_alloc_coherent() error
   returns, from FUJITA Tomonori

4) Device ID table for bq4802 RTC chip lacks a terminating NULL entry.

Please pull, thanks a lot!

The following changes since commit 60b8267338aafde5315fc65ff385f3d4d75eccfe:
  David S. Miller (1):
        math-emu: Fix thinko in _FP_DIV

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (1):
      sparc64: Add missing null terminating entry to bq4802_match[].

FUJITA Tomonori (1):
      dbri: check dma_alloc_coherent errors

Harvey Harrison (2):
      sparc64: remove byteshifting from out* helpers
      sparc: use the new byteorder headers

Krzysztof Helt (1):
      rtc-m48t59: shift zero year to 1968 on sparc (rev 2)

 arch/sparc/include/asm/byteorder.h |   22 ++----
 arch/sparc/kernel/time.c           |   27 +------
 arch/sparc64/kernel/time.c         |   34 ++-------
 arch/sparc64/lib/PeeCeeI.c         |  139 ++++++++++++------------------------
 drivers/rtc/rtc-m48t59.c           |   34 ++++++++-
 sound/sparc/dbri.c                 |    2 +
 6 files changed, 97 insertions(+), 161 deletions(-)

