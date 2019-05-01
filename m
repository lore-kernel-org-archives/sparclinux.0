From: Mike Rapoport <rppt@linux.ibm.com>
Date: Wed, 01 May 2019 19:56:14 +0000
Subject: [PATCH 0/3] remove ARCH_SELECT_MEMORY_MODEL where it has no effect
Message-Id: <1556740577-4140-1-git-send-email-rppt@linux.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@infradead.org>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>

Hi,

For several architectures the ARCH_SELECT_MEMORY_MODEL has no real effect
because the dependencies for the memory model are always evaluated to a
single value.

Remove the ARCH_SELECT_MEMORY_MODEL from the Kconfigs for these
architectures.

Mike Rapoport (3):
  arm: remove ARCH_SELECT_MEMORY_MODEL
  s390: remove ARCH_SELECT_MEMORY_MODEL
  sparc: remove ARCH_SELECT_MEMORY_MODEL

 arch/arm/Kconfig   | 3 ---
 arch/s390/Kconfig  | 3 ---
 arch/sparc/Kconfig | 3 ---
 3 files changed, 9 deletions(-)

-- 
2.7.4
