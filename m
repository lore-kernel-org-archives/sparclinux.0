From: David Rientjes <rientjes@google.com>
Date: Wed, 21 Jul 2010 02:44:53 +0000
Subject: [patch 1/6] sparc: remove dependency on __GFP_NOFAIL
Message-Id: <alpine.DEB.2.00.1007201938100.8728@chino.kir.corp.google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.DEB.2.00.1007201936210.8728@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.00.1007201936210.8728@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, sparclinux@vger.kernel.org, linux-mm@kvack.org

The kmalloc() in mdesc_kmalloc() is failable, so remove __GFP_NOFAIL from
its mask.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: David Rientjes <rientjes@google.com>
---
 arch/sparc/kernel/mdesc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
--- a/arch/sparc/kernel/mdesc.c
+++ b/arch/sparc/kernel/mdesc.c
@@ -134,7 +134,7 @@ static struct mdesc_handle *mdesc_kmalloc(unsigned int mdesc_size)
 		       sizeof(struct mdesc_hdr) +
 		       mdesc_size);
 
-	base = kmalloc(handle_size + 15, GFP_KERNEL | __GFP_NOFAIL);
+	base = kmalloc(handle_size + 15, GFP_KERNEL);
 	if (base) {
 		struct mdesc_handle *hp;
 		unsigned long addr;
