From: Meelis Roos <mroos@linux.ee>
Date: Fri, 16 Feb 2007 10:30:56 +0000
Subject: virt_irq_{alloc,free} inconsistency with no MSI
Message-Id: <Pine.SOC.4.64.0702161227260.3144@math>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

While investigating this (with current -git for sun4u and no 
CONFIG_PCI_MSI)

  CC      arch/sparc64/kernel/irq.o
cc1: warnings being treated as errors
arch/sparc64/kernel/irq.c:113: warning: 'virt_irq_free' defined but not used

I found that virt_irq_free() is used only if CONFIG_PCI_MSI is defined 
(for sun4v - simple to cure with a define), but virt_irq_alloc() is used 
even without MSI enabled. Is this really correct? Do we alloc and not 
free it in this case?

-- 
Meelis Roos (mroos@linux.ee)
