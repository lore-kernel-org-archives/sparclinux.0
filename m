From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Date: Thu, 02 Aug 2018 11:53:51 +0000
Subject: [PATCH 0/2] sparc32: switch to NO_BOOTMEM
Message-Id: <1533210833-14748-1-git-send-email-rppt@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Sam Ravnborg <sam@ravnborg.org>, Michal Hocko <mhocko@kernel.org>, sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.vnet.ibm.com>

Hi,

These patches convert sparc32 to use memblock + nobootmem.
I've made the conversion as simple as possible, just enough to allow moving
HAVE_MEMBLOCK and NO_BOOTMEM to the common SPARC configuration.

Mike Rapoport (2):
  sparc32: switch to NO_BOOTMEM
  sparc32: tidy up ramdisk memory reservation

 arch/sparc/Kconfig      |  4 +--
 arch/sparc/mm/init_32.c | 90 +++++++++++++++----------------------------------
 2 files changed, 29 insertions(+), 65 deletions(-)

-- 
2.7.4

