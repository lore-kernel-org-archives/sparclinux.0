From: Ben Hutchings <ben@decadent.org.uk>
Date: Wed, 31 Jul 2013 13:23:09 +0000
Subject: [24/84] sparc64 address-congruence property
Message-Id: <lsq.1375276989.298370057@decadent.org.uk>
List-Id: <sparclinux.vger.kernel.org>
In-Reply-To: <lsq.1375276989.251749228@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, Bob Picco <bob.picco@oracle.com>, bob picco <bpicco@meloft.net>, "David S. Miller" <davem@davemloft.net>

3.2.50-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: bob picco <bpicco@meloft.net>

commit 771a37ff4d80b80db3b0df3e7696f14b298c67b7 upstream.

The Machine Description (MD) property "address-congruence-offset" is
optional. According to the MD specification the value is assumed 0UL when
not present. This caused early boot failure on T5.

Signed-off-by: Bob Picco <bob.picco@oracle.com>
CC: sparclinux@vger.kernel.org
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/sparc/mm/init_64.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 6ff4d78..b4989f9 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1071,7 +1071,14 @@ static int __init grab_mblocks(struct mdesc_handle *md)
 		m->size = *val;
 		val = mdesc_get_property(md, node,
 					 "address-congruence-offset", NULL);
-		m->offset = *val;
+
+		/* The address-congruence-offset property is optional.
+		 * Explicity zero it be identifty this.
+		 */
+		if (val)
+			m->offset = *val;
+		else
+			m->offset = 0UL;
 
 		numadbg("MBLOCK[%d]: base[%llx] size[%llx] offset[%llx]\n",
 			count - 1, m->base, m->size, m->offset);

