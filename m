From: David Miller <davem@davemloft.net>
Date: Thu, 22 Dec 2011 22:01:34 +0000
Subject: [PATCH] sparc64: Fix MSIQ HV call ordering in
Message-Id: <20111222.170134.996905090615702639.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This silently was working for many years and stopped working on
Niagara-T3 machines.

We need to set the MSIQ to VALID before we can set it's state to IDLE.

On Niagara-T3, setting the state to IDLE first was causing HV_EINVAL
errors.  The hypervisor documentation says, rather ambiguously, that
the MSIQ must be "initialized" before one can set the state.

I previously understood this to mean merely that a successful setconf()
operation has been performed on the MSIQ, which we have done at this
point.  But it seems to also mean that it has been set VALID too.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/pci_sun4v.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index b272cda..af5755d 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -849,10 +849,10 @@ static int pci_sun4v_msiq_build_irq(struct pci_pbm_info *pbm,
 	if (!irq)
 		return -ENOMEM;
 
-	if (pci_sun4v_msiq_setstate(pbm->devhandle, msiqid, HV_MSIQSTATE_IDLE))
-		return -EINVAL;
 	if (pci_sun4v_msiq_setvalid(pbm->devhandle, msiqid, HV_MSIQ_VALID))
 		return -EINVAL;
+	if (pci_sun4v_msiq_setstate(pbm->devhandle, msiqid, HV_MSIQSTATE_IDLE))
+		return -EINVAL;
 
 	return irq;
 }
-- 
1.7.6.401.g6a319

