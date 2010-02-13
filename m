From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 13 Feb 2010 16:02:58 +0000
Subject: [PATCH 6/9] of: remove unused extern reference to devtree_lock
Message-Id: <20100213160258.4767.22371.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20100213154838.4767.83881.stgit@angua>
In-Reply-To: <20100213154838.4767.83881.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: monstr@monstr.eu, sfr@canb.auug.org.au, benh@kernel.crashing.org, jeremy.kerr@canonical.com, davem@davemloft.net, microblaze-uclinux@itee.uq.edu.au, linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org

Neither the powerpc nor the microblaze code use devtree_lock anymore.
Remove the extern reference.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/microblaze/include/asm/prom.h |    2 --
 arch/powerpc/kernel/prom.c         |    2 --
 2 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/microblaze/include/asm/prom.h b/arch/microblaze/include/asm/prom.h
index ddc5c57..8b1ebd3 100644
--- a/arch/microblaze/include/asm/prom.h
+++ b/arch/microblaze/include/asm/prom.h
@@ -30,8 +30,6 @@ extern struct device_node *of_chosen;
 
 #define HAVE_ARCH_DEVTREE_FIXUPS
 
-extern rwlock_t devtree_lock;	/* temporary while merging */
-
 /* Other Prototypes */
 extern int early_uartlite_console(void);
 
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 5bbbdb2..4869c93 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -67,8 +67,6 @@ int __initdata iommu_force_on;
 unsigned long tce_alloc_start, tce_alloc_end;
 #endif
 
-extern rwlock_t devtree_lock;	/* temporary while merging */
-
 /* export that to outside world */
 struct device_node *of_chosen;
 

