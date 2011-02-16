From: Ondrej Zary <linux@rainbow-software.org>
Date: Wed, 16 Feb 2011 23:01:24 +0000
Subject: Re: [PATCH 0/22] Make SVGA oriented FBs work on multi-domain PCI
Message-Id: <201102170001.28232.linux@rainbow-software.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110111.154846.233419170.davem@davemloft.net>
In-Reply-To: <20110111.154846.233419170.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wednesday 12 January 2011 00:48:46 David Miller wrote:
> This patch set makes sure that FB drivers for PCI devices utilizing
> the svgalib interfaces work on multi-domain PCI architectures.
>
> Basically this amounts to making sure that the vgastate->vgabase
> __iomem pointer makes it way into every interfaces and gets used
> by all of the I/O access calls.
>
> All of arkfb, s3fb, and vt8623fb have been converted.
>
> Signed-off-by: David S. Miller <davem@davemloft.net>

Just tested arkfb and s3fb and they seem to still work fine (on x86) with 
these changes.

-- 
Ondrej Zary
