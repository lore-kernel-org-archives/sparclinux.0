From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Tue, 24 Jul 2018 11:53:05 +0000
Subject: [PATCH 2/2] sparc: use asm-generic version of msi.h
Message-Id: <20180724115305.11289-2-thomas.petazzoni@bootlin.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180724115305.11289-1-thomas.petazzoni@bootlin.com>
In-Reply-To: <20180724115305.11289-1-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S . Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, Hanna Hawa <hannah@marvell.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>

This is necessary to be able to include <linux/msi.h> when
CONFIG_GENERIC_MSI_IRQ_DOMAIN is enabled. Without this, a build with
CONFIG_GENERIC_MSI_IRQ_DOMAIN fails with:

   In file included from drivers//ata/ahci.c:45:0:
>> include/linux/msi.h:226:10: error: unknown type name 'msi_alloc_info_t'; did you mean 'sg_alloc_fn'?
             msi_alloc_info_t *arg);
             ^~~~~~~~~~~~~~~~
             sg_alloc_fn
   include/linux/msi.h:230:9: error: unknown type name 'msi_alloc_info_t'; did you mean 'sg_alloc_fn'?
            msi_alloc_info_t *arg);
            ^~~~~~~~~~~~~~~~
            sg_alloc_fn
   include/linux/msi.h:239:12: error: unknown type name 'msi_alloc_info_t'; did you mean 'sg_alloc_fn'?
               msi_alloc_info_t *arg);
               ^~~~~~~~~~~~~~~~
               sg_alloc_fn
   include/linux/msi.h:240:22: error: unknown type name 'msi_alloc_info_t'; did you mean 'sg_alloc_fn'?
     void  (*msi_finish)(msi_alloc_info_t *arg, int retval);
                         ^~~~~~~~~~~~~~~~
                         sg_alloc_fn
   include/linux/msi.h:241:20: error: unknown type name 'msi_alloc_info_t'; did you mean 'sg_alloc_fn'?
     void  (*set_desc)(msi_alloc_info_t *arg,
                       ^~~~~~~~~~~~~~~~
                       sg_alloc_fn
   include/linux/msi.h:316:18: error: unknown type name 'msi_alloc_info_t'; did you mean 'sg_alloc_fn'?
           int nvec, msi_alloc_info_t *args);
                     ^~~~~~~~~~~~~~~~
                     sg_alloc_fn
   include/linux/msi.h:318:29: error: unknown type name 'msi_alloc_info_t'; did you mean 'sg_alloc_fn'?
            int virq, int nvec, msi_alloc_info_t *args);
                                ^~~~~~~~~~~~~~~~
                                sg_alloc_fn

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 arch/sparc/include/asm/Kbuild | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index ac67828da201..410b263ef5c8 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -13,6 +13,7 @@ generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
 generic-y += module.h
+generic-y += msi.h
 generic-y += preempt.h
 generic-y += rwsem.h
 generic-y += serial.h
-- 
2.14.4

