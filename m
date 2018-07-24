From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 24 Jul 2018 14:55:25 +0000
Subject: Re: [PATCH 1/2] sparc: move MSI related definitions to where they are used
Message-Id: <20180724145525.GA14300@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20180724115305.11289-1-thomas.petazzoni@bootlin.com>
 <20180724143736.GA22088@ravnborg.org>
 <20180724164407.4fa57d1f@windsurf>
In-Reply-To: <20180724164407.4fa57d1f@windsurf>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, Hanna Hawa <hannah@marvell.com>

Hi Thomas.

> > 
> > The SPARC way to format comments follows netdev style.
> > So put it all in one line and everyone are happy:
> 
> Well, the code is being moved from arch/sparc to arch/sparc, so
> apparently, it was already non-compliant to this specific coding style
> rule. Should the comments be made compliant as part of the same commit,
> or a separate one ?
Same commit, no reason to slit this in two.
So post a v2, then everyone should be happy.

I also looked at the second patch which looked obviously correct.
Feel free to add my Ack on both.

	Sam
