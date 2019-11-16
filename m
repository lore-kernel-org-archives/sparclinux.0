From: Sasha Levin <sashal@kernel.org>
Date: Sat, 16 Nov 2019 15:50:01 +0000
Subject: [PATCH AUTOSEL 4.9 38/99] sparc: Fix parport build warnings.
Message-Id: <20191116155103.10971-38-sashal@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20191116155103.10971-1-sashal@kernel.org>
In-Reply-To: <20191116155103.10971-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Sasha Levin <sashal@kernel.org>, sparclinux@vger.kernel.org

From: "David S. Miller" <davem@davemloft.net>

[ Upstream commit 46b8306480fb424abd525acc1763da1c63a27d8a ]

If PARPORT_PC_FIFO is not enabled, do not provide the dma lock
macros and lock definition.  Otherwise:

./arch/sparc/include/asm/parport.h:24:24: warning: ‘dma_spin_lock’ defined but not used [-Wunused-variable]
 static DEFINE_SPINLOCK(dma_spin_lock);
                        ^~~~~~~~~~~~~
./include/linux/spinlock_types.h:81:39: note: in definition of macro ‘DEFINE_SPINLOCK’
 #define DEFINE_SPINLOCK(x) spinlock_t x = __SPIN_LOCK_UNLOCKED(x)

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/include/asm/parport.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sparc/include/asm/parport.h b/arch/sparc/include/asm/parport.h
index f005ccac91cc9..e87c0f81b700e 100644
--- a/arch/sparc/include/asm/parport.h
+++ b/arch/sparc/include/asm/parport.h
@@ -20,6 +20,7 @@
  */
 #define HAS_DMA
 
+#ifdef CONFIG_PARPORT_PC_FIFO
 static DEFINE_SPINLOCK(dma_spin_lock);
 
 #define claim_dma_lock() \
@@ -30,6 +31,7 @@ static DEFINE_SPINLOCK(dma_spin_lock);
 
 #define release_dma_lock(__flags) \
 	spin_unlock_irqrestore(&dma_spin_lock, __flags);
+#endif
 
 static struct sparc_ebus_info {
 	struct ebus_dma_info info;
-- 
2.20.1
