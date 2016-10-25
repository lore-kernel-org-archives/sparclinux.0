From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 25 Oct 2016 09:03:13 +0000
Subject: [GIT PULL v2 3/5] s390: make cpu_relax a barrier again
Message-Id: <1477386195-32736-4-git-send-email-borntraeger@de.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1477386195-32736-1-git-send-email-borntraeger@de.ibm.com>
In-Reply-To: <1477386195-32736-1-git-send-email-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, kvm@vger.kernel.org, Will Deacon <will.deacon@arm.com>, x86@kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, Russell King <linux@armlinux.org.uk>, sparclinux@vger.kernel.org, Noam Camus <noamc@ezchip.com>, Catalin Marinas <catalin.marinas@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, xen-devel@lists.xenproject.org, virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>

stop_machine seemed to be the only important place for yielding during
cpu_relax. This was fixed by using cpu_relax_yield. Therefore, we can
now redefine cpu_relax to be a barrier instead on s390, making s390
identical to all other architectures.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/processor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index d05965b..5d262cf 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -236,7 +236,7 @@ static inline unsigned short stap(void)
  */
 void cpu_relax_yield(void);
 
-#define cpu_relax() cpu_relax_yield()
+#define cpu_relax() barrier()
 #define cpu_relax_lowlatency()  barrier()
 
 #define ECAG_CACHE_ATTRIBUTE	0
-- 
2.5.5

