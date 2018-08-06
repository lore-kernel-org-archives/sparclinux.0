From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Date: Mon, 06 Aug 2018 10:52:32 +0000
Subject: [PATCH v2 0/3] sparc32: switch to NO_BOOTMEM
Message-Id: <1533552755-16679-1-git-send-email-rppt@linux.vnet.ibm.com>
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

v2 changes:
* split whitespace changes to a separate patch
* address Sam's comments [1]

[1] https://lkml.org/lkml/2018/8/2/403

Mike Rapoport (3):
  sparc: mm/init_32: kill trailing whitespace
  sparc32: switch to NO_BOOTMEM
  sparc32: split ramdisk detection and reservation to a helper function

 arch/sparc/Kconfig      |   4 +-
 arch/sparc/mm/init_32.c | 127 ++++++++++++++++++------------------------------
 2 files changed, 50 insertions(+), 81 deletions(-)

-- 
2.7.4

