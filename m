From: David Miller <davem@davemloft.net>
Date: Mon, 30 Jul 2018 20:01:19 +0000
Subject: Re: [PATCH 2/2] sparc: use asm-generic version of msi.h
Message-Id: <20180730.130119.1162984202708995473.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20180724115305.11289-1-thomas.petazzoni@bootlin.com>
        <20180724115305.11289-2-thomas.petazzoni@bootlin.com>
In-Reply-To: <20180724115305.11289-2-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: thomas.petazzoni@bootlin.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, marc.zyngier@arm.com, hannah@marvell.com

From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Tue, 24 Jul 2018 13:53:05 +0200

> This is necessary to be able to include <linux/msi.h> when
> CONFIG_GENERIC_MSI_IRQ_DOMAIN is enabled. Without this, a build with
> CONFIG_GENERIC_MSI_IRQ_DOMAIN fails with:
 ...
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Applied.
