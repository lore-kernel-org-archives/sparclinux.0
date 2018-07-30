From: David Miller <davem@davemloft.net>
Date: Mon, 30 Jul 2018 20:01:10 +0000
Subject: Re: [PATCH 1/2] sparc: move MSI related definitions to where they are used
Message-Id: <20180730.130110.34198079056845850.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20180724115305.11289-1-thomas.petazzoni@bootlin.com>
In-Reply-To: <20180724115305.11289-1-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: thomas.petazzoni@bootlin.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, marc.zyngier@arm.com, hannah@marvell.com

From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Tue, 24 Jul 2018 13:53:04 +0200

> The definitions in arch/sparc/include/asm/msi.h are only used in
> arch/sparc/mm/srmmu.c, so it makes sense to have them in the C file
> directly.
> 
> In addition, having a custom arch/sparc/include/asm/msi.h prevents
> from using the asm-generic version of this header, which is necessary
> to be able to include <linux/msi.h> when CONFIG_GENERIC_MSI_IRQ_DOMAIN
> is enabled.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Applied.
