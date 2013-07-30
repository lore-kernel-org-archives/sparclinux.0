From: Kamal Mostafa <kamal@canonical.com>
Date: Tue, 30 Jul 2013 18:44:48 +0000
Subject: [PATCH 44/75] sparc64 address-congruence property
Message-Id: <1375209919-1768-11-git-send-email-kamal@canonical.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1375197464-27962-1-git-send-email-kamal@canonical.com>
In-Reply-To: <1375197464-27962-1-git-send-email-kamal@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org, kernel-team@lists.ubuntu.com
Cc: Bob Picco <bob.picco@oracle.com>, sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Kamal Mostafa <kamal@canonical.com>

3.8.13.6 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: bob picco <bpicco@meloft.net>

commit 771a37ff4d80b80db3b0df3e7696f14b298c67b7 upstream.

The Machine Description (MD) property "address-congruence-offset" is
optional. According to the MD specification the value is assumed 0UL when
not present. This caused early boot failure on T5.

Signed-off-by: Bob Picco <bob.picco@oracle.com>
CC: sparclinux@vger.kernel.org
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/sparc/mm/init_64.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 82bbf04..c57da7f 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1099,7 +1099,14 @@ static int __init grab_mblocks(struct mdesc_handle *md)
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
-- 
1.8.1.2

