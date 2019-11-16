From: Sasha Levin <sashal@kernel.org>
Date: Sat, 16 Nov 2019 15:39:22 +0000
Subject: [PATCH AUTOSEL 4.19 127/237] sparc64: Rework xchg() definition to avoid warnings.
Message-Id: <20191116154113.7417-127-sashal@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20191116154113.7417-1-sashal@kernel.org>
In-Reply-To: <20191116154113.7417-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Sasha Levin <sashal@kernel.org>, sparclinux@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org

From: "David S. Miller" <davem@davemloft.net>

[ Upstream commit 6c2fc9cddc1ffdef8ada1dc8404e5affae849953 ]

Such as:

fs/ocfs2/file.c: In function ‘ocfs2_file_write_iter’:
./arch/sparc/include/asm/cmpxchg_64.h:55:22: warning: value computed is not used [-Wunused-value]
 #define xchg(ptr,x) ((__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr))))

and

drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c: In function ‘ixgbevf_xdp_setup’:
./arch/sparc/include/asm/cmpxchg_64.h:55:22: warning: value computed is not used [-Wunused-value]
 #define xchg(ptr,x) ((__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr))))

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/include/asm/cmpxchg_64.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/cmpxchg_64.h b/arch/sparc/include/asm/cmpxchg_64.h
index f71ef3729888f..316faa0130bab 100644
--- a/arch/sparc/include/asm/cmpxchg_64.h
+++ b/arch/sparc/include/asm/cmpxchg_64.h
@@ -52,7 +52,12 @@ static inline unsigned long xchg64(__volatile__ unsigned long *m, unsigned long
 	return val;
 }
 
-#define xchg(ptr,x) ((__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr))))
+#define xchg(ptr,x)							\
+({	__typeof__(*(ptr)) __ret;					\
+	__ret = (__typeof__(*(ptr)))					\
+		__xchg((unsigned long)(x), (ptr), sizeof(*(ptr)));	\
+	__ret;								\
+})
 
 void __xchg_called_with_bad_pointer(void);
 
-- 
2.20.1
