From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 13 Feb 2010 16:03:15 +0000
Subject: [PATCH 9/9] of: remove undefined request_OF_resource &
Message-Id: <20100213160314.4767.93924.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20100213154838.4767.83881.stgit@angua>
In-Reply-To: <20100213154838.4767.83881.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: monstr@monstr.eu, sfr@canb.auug.org.au, benh@kernel.crashing.org, jeremy.kerr@canonical.com, davem@davemloft.net, microblaze-uclinux@itee.uq.edu.au, linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org

Neither request_OF_resource or release_OF_resource are defined
anywhere.  Remove the declarations.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/microblaze/include/asm/prom.h |    4 ----
 arch/powerpc/include/asm/prom.h    |    5 -----
 2 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/arch/microblaze/include/asm/prom.h b/arch/microblaze/include/asm/prom.h
index aa1a437..03f45a9 100644
--- a/arch/microblaze/include/asm/prom.h
+++ b/arch/microblaze/include/asm/prom.h
@@ -31,10 +31,6 @@
 /* Other Prototypes */
 extern int early_uartlite_console(void);
 
-extern struct resource *request_OF_resource(struct device_node *node,
-				int index, const char *name_postfix);
-extern int release_OF_resource(struct device_node *node, int index);
-
 /*
  * OF address retreival & translation
  */
diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index 7f9a50a..ddd408a 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -39,11 +39,6 @@ extern struct device_node* pci_device_to_OF_node(struct pci_dev *);
 extern void pci_create_OF_bus_map(void);
 #endif
 
-extern struct resource *request_OF_resource(struct device_node* node,
-				int index, const char* name_postfix);
-extern int release_OF_resource(struct device_node* node, int index);
-
-
 /*
  * OF address retreival & translation
  */

