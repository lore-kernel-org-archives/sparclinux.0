From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 24 Jul 2018 14:37:36 +0000
Subject: Re: [PATCH 1/2] sparc: move MSI related definitions to where they are used
Message-Id: <20180724143736.GA22088@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20180724115305.11289-1-thomas.petazzoni@bootlin.com>
In-Reply-To: <20180724115305.11289-1-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, Hanna Hawa <hannah@marvell.com>

Hi Thomas.

One nitpick below.
But other than that this is a nice cleanup:
Acked-by: Sam Ravnborg <sam@ravnborg.org>
> +/*
> + * Locations of MSI Registers.
> + */

The SPARC way to format comments follows netdev style.
So put it all in one line and everyone are happy:

    /* Locations of MSI Registers. */

> +#define MSI_MBUS_ARBEN	0xe0001008	/* MBus Arbiter Enable register */
> +
> +/*
> + * Useful bits in the MSI Registers.
> + */
Likewise

	Sam
