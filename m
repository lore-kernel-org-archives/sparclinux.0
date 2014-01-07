From: Ethan Zhao <ethan.kernel@gmail.com>
Date: Tue, 07 Jan 2014 09:31:17 +0000
Subject: [PATCH] sparc: replace __GFP_NOFAIL with GFP_ATOMIC in mdesc_kmalloc()
Message-Id: <1389087077-311-1-git-send-email-ethan.kernel@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CABawtvPt9V_2=KxOGetUCVeatJVcD-uJqs9c6cUzOc2uZCqpYg@mail.gmail.com>
In-Reply-To: <CABawtvPt9V_2=KxOGetUCVeatJVcD-uJqs9c6cUzOc2uZCqpYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Ethan Zhao <ethan.kernel@gmail.com>

Has kmalloc() failure checking there, so it is unnecessary to allocate with
__GFP_NOFAIL flag that might block forever.

Signed-off-by: Ethan Zhao <ethan.kernel@gmail.com>
---
 arch/sparc/kernel/mdesc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
index b90bf23..e8d678c 100644
--- a/arch/sparc/kernel/mdesc.c
+++ b/arch/sparc/kernel/mdesc.c
@@ -136,7 +136,7 @@ static struct mdesc_handle *mdesc_kmalloc(unsigned int mdesc_size)
 		       sizeof(struct mdesc_hdr) +
 		       mdesc_size);
 
-	base = kmalloc(handle_size + 15, GFP_KERNEL | __GFP_NOFAIL);
+	base = kmalloc(handle_size + 15, GFP_KERNEL | GFP_ATOMIC);
 	if (base) {
 		struct mdesc_handle *hp;
 		unsigned long addr;
-- 
1.8.3.4 (Apple Git-47)

