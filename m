From: richm@oldelvet.org.uk
Date: Sat, 23 Dec 2006 23:07:25 +0000
Subject: [PATCH] sparc64: isa.c should cope with OBP nodes with no "reg" property
Message-Id: <1166915246238-git-send-email-richm@oldelvet.org.uk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Richard Mortimer <richm@oldelvet.org.uk>

The todm5819 Openboot device node on Netra X1 does not have a "reg"
property. In this case of_get_property returns NULL resulting in an
Oops. Avoid this by returning from isa_dev_get_resource() without
attempting to request_resource().

Signed-off-by: Richard Mortimer <richm@oldelvet.org.uk>
---
 arch/sparc64/kernel/isa.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/sparc64/kernel/isa.c b/arch/sparc64/kernel/isa.c
index ad1c4f5..cb556f0 100644
--- a/arch/sparc64/kernel/isa.c
+++ b/arch/sparc64/kernel/isa.c
@@ -31,6 +31,10 @@ isa_dev_get_resource(struct sparc_isa_device *isa_dev)
 
 	pregs = of_get_property(isa_dev->prom_node, "reg", &prop_len);
 
+	if (!pregs) {
+		return NULL;
+	}
+
 	/* Only the first one is interesting. */
 	len = pregs[0].reg_size;
 	base = (((unsigned long)pregs[0].which_io << 32) |
-- 
1.4.4.2

