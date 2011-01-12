From: Ondrej Zary <linux@rainbow-software.org>
Date: Wed, 12 Jan 2011 07:17:34 +0000
Subject: Re: [PATCH 0/22] Make SVGA oriented FBs work on multi-domain PCI
Message-Id: <201101120817.35494.linux@rainbow-software.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110111.154846.233419170.davem@davemloft.net>
In-Reply-To: <20110111.154846.233419170.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wednesday 12 January 2011, David Miller wrote:
> This patch set makes sure that FB drivers for PCI devices utilizing
> the svgalib interfaces work on multi-domain PCI architectures.
>
> Basically this amounts to making sure that the vgastate->vgabase
> __iomem pointer makes it way into every interfaces and gets used
> by all of the I/O access calls.
>
> All of arkfb, s3fb, and vt8623fb have been converted.

Great, I was thinking about something like this when looking at s3fb code and 
wondering how it can be extended to work with secondary cards (not 
initialized by BIOS). I'll test this with arkfb and s3fb.

-- 
Ondrej Zary
