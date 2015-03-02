From: Michal Hocko <mhocko@suse.cz>
Date: Mon, 02 Mar 2015 13:54:42 +0000
Subject: [RFC 3/4] sparc: remove __GFP_NOFAIL reuquirement
Message-Id: <1425304483-7987-4-git-send-email-mhocko@suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1425304483-7987-1-git-send-email-mhocko@suse.cz>
In-Reply-To: <1425304483-7987-1-git-send-email-mhocko@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, David Rientjes <rientjes@google.com>, Dave Chinner <david@fromorbit.com>, Theodore Ts'o <tytso@mit.edu>, Mel Gorman <mgorman@suse.de>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Vipul Pandya <vipul@chelsio.com>, netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

mdesc_kmalloc is currently requiring __GFP_NOFAIL allocation although it
seems that the allocation failure is handled by all callers (via
mdesc_alloc). __GFP_NOFAIL is a strong liability for the memory
allocator and so the users are discouraged to use the flag unless the
allocation failure is really a nogo. Drop the flag here as this doesn't
seem to be the case.

Signed-off-by: Michal Hocko <mhocko@suse.cz>
---
 arch/sparc/kernel/mdesc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
index 99632a87e697..6801bd778af2 100644
--- a/arch/sparc/kernel/mdesc.c
+++ b/arch/sparc/kernel/mdesc.c
@@ -136,7 +136,7 @@ static struct mdesc_handle *mdesc_kmalloc(unsigned int mdesc_size)
 		       sizeof(struct mdesc_hdr) +
 		       mdesc_size);
 
-	base = kmalloc(handle_size + 15, GFP_KERNEL | __GFP_NOFAIL);
+	base = kmalloc(handle_size + 15, GFP_KERNEL);
 	if (base) {
 		struct mdesc_handle *hp;
 		unsigned long addr;
-- 
2.1.4

