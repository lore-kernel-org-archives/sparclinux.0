From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 07 Oct 2009 04:30:47 +0000
Subject: [RFC PATCH 04/12] of: Move OF_IS_DYNAMIC and OF_MARK_DYNAMIC macros
Message-Id: <20091007043039.16890.182.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20091007041007.16890.62194.stgit@angua>
In-Reply-To: <20091007041007.16890.62194.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, Stephen Rothwell <sfr@canb.auug.org.au>, davem@davemloft.net, sparclinux@vger.kernel.org, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org

Merge of common code duplicated between Sparc, PowerPC and Microblaze

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/sparc/include/asm/prom.h |    3 ---
 include/linux/of.h            |    3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/include/asm/prom.h b/arch/sparc/include/asm/prom.h
index e5f4a1d..ddbd870 100644
--- a/arch/sparc/include/asm/prom.h
+++ b/arch/sparc/include/asm/prom.h
@@ -34,9 +34,6 @@ struct of_irq_controller {
 	void		*data;
 };
 
-#define OF_IS_DYNAMIC(x) test_bit(OF_DYNAMIC, &x->_flags)
-#define OF_MARK_DYNAMIC(x) set_bit(OF_DYNAMIC, &x->_flags)
-
 extern struct device_node *of_find_node_by_cpuid(int cpuid);
 extern int of_set_property(struct device_node *node, const char *name, void *val, int len);
 extern struct mutex of_set_property_mutex;
diff --git a/include/linux/of.h b/include/linux/of.h
index 65a158d..a66c1eb 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -69,6 +69,9 @@ struct device_node {
 #define OF_DYNAMIC	1 /* node and properties were allocated via kmalloc */
 #define OF_DETACHED	2 /* node has been detached from the device tree */
 
+#define OF_IS_DYNAMIC(x) test_bit(OF_DYNAMIC, &x->_flags)
+#define OF_MARK_DYNAMIC(x) set_bit(OF_DYNAMIC, &x->_flags)
+
 #define OF_BAD_ADDR	((u64)-1)
 
 extern struct device_node *of_find_node_by_name(struct device_node *from,

