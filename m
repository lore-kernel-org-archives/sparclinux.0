From: Mike Rapoport <rppt@linux.ibm.com>
Date: Mon, 31 Dec 2018 09:29:22 +0000
Subject: [PATCH v4 2/6] microblaze: prefer memblock API returning virtual address
Message-Id: <1546248566-14910-3-git-send-email-rppt@linux.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1546248566-14910-1-git-send-email-rppt@linux.ibm.com>
In-Reply-To: <1546248566-14910-1-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>, linux-sh@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mm@kvack.org, Rich Felker <dalias@libc.org>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, Vincent Chen <deanbo422@gmail.com>, Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Ellerman <mpe@ellerman.id.au>, Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@linux.ibm.com>, Mark Salter <msalter@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>, Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

Rather than use the memblock_alloc_base that returns a physical address and
then convert this address to the virtual one, use appropriate memblock
function that returns a virtual address.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Tested-by: Michal Simek <michal.simek@xilinx.com>
---
 arch/microblaze/mm/init.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index b17fd8a..44f4b89 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -363,8 +363,9 @@ void __init *early_get_page(void)
 	 * Mem start + kernel_tlb -> here is limit
 	 * because of mem mapping from head.S
 	 */
-	return __va(memblock_alloc_base(PAGE_SIZE, PAGE_SIZE,
-				memory_start + kernel_tlb));
+	return memblock_alloc_try_nid_raw(PAGE_SIZE, PAGE_SIZE,
+				MEMBLOCK_LOW_LIMIT, memory_start + kernel_tlb,
+				NUMA_NO_NODE);
 }
 
 #endif /* CONFIG_MMU */
-- 
2.7.4
