From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Mon, 09 Sep 2013 07:05:45 +0000
Subject: Re: sparc32 defconfig build broken due to commit ebd97be63 (PCI: remove ARCH_SUPPORTS_MSI kconfig op
Message-Id: <20130909090545.7c90880b@skate>
List-Id: <sparclinux.vger.kernel.org>
References: <522D1DAE.5010100@roeck-us.net>
In-Reply-To: <522D1DAE.5010100@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

Dear Guenter Roeck,

On Sun, 08 Sep 2013 18:00:30 -0700, Guenter Roeck wrote:

> "make ARCH=sparc32 defconfig; make ARCH=sparc32" on the current upstream kernel results in:
> 
> In file included from arch/sparc/kernel/pci_msi.c:10:0:
> arch/sparc/kernel/pci_impl.h:142:18: error: field 'stc' has incomplete type
> arch/sparc/kernel/pci_msi.c: In function 'sparc64_setup_msi_irq':
> arch/sparc/kernel/pci_msi.c:131:2: error: implicit declaration of function 'irq_alloc' [-Werror=implicit-function-declaration]
> arch/sparc/kernel/pci_msi.c:173:2: error: implicit declaration of function 'irq_free' [-Werror=implicit-function-declaration]
> cc1: all warnings being treated as errors
> make[2]: *** [arch/sparc/kernel/pci_msi.o] Error 1
> 
> Bisect points to commit ebd97be635 (PCI: remove ARCH_SUPPORTS_MSI kconfig option).
> After reverting this commit, sparc32:defconfig builds fine.
> 
> sparc64 defconfig is unaffected.

Thanks for the report, I'll have a look very soon.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
