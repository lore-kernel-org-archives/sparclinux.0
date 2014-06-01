From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Sun, 01 Jun 2014 21:48:18 +0000
Subject: [PATCH] arch: sparc: kernel: smp_64.c:  Optimization of the Code
Message-Id: <1401659298-18067-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>, Kirill Tkhai <tkhai@yandex.ru>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Paul Gortmaker <paul.gortmaker@windriver.com>, Peter Zijlstra <peterz@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From what I know, AND is faster then modulo.
Not sure if this is worth changing though.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 arch/sparc/kernel/smp_64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index 745a363..921d924 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -179,7 +179,7 @@ static inline long get_delta (long *rt, long *master)
 
 	/* average best_t0 and best_t1 without overflow: */
 	tcenter = (best_t0/2 + best_t1/2);
-	if (best_t0 % 2 + best_t1 % 2 = 2)
+	if ((best_t0 & 1) + (best_t1 & 1) = 2)
 		tcenter++;
 	return tcenter - best_tm;
 }
-- 
1.7.10.4

