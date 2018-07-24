From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Tue, 24 Jul 2018 14:44:07 +0000
Subject: Re: [PATCH 1/2] sparc: move MSI related definitions to where they are used
Message-Id: <20180724164407.4fa57d1f@windsurf>
List-Id: <sparclinux.vger.kernel.org>
References: <20180724115305.11289-1-thomas.petazzoni@bootlin.com>
        <20180724143736.GA22088@ravnborg.org>
In-Reply-To: <20180724143736.GA22088@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, Hanna Hawa <hannah@marvell.com>

Hello,

Thanks for the review.

On Tue, 24 Jul 2018 16:37:36 +0200, Sam Ravnborg wrote:

> One nitpick below.
> But other than that this is a nice cleanup:
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> > +/*
> > + * Locations of MSI Registers.
> > + */  
> 
> The SPARC way to format comments follows netdev style.
> So put it all in one line and everyone are happy:

Well, the code is being moved from arch/sparc to arch/sparc, so
apparently, it was already non-compliant to this specific coding style
rule. Should the comments be made compliant as part of the same commit,
or a separate one ?

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
