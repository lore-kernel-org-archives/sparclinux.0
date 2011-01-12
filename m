From: David Miller <davem@davemloft.net>
Date: Wed, 12 Jan 2011 00:22:53 +0000
Subject: Re: [PATCH 0/22] Make SVGA oriented FBs work on multi-domain PCI
Message-Id: <20110111.162253.121250783.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110111.154846.233419170.davem@davemloft.net>
In-Reply-To: <20110111.154846.233419170.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Alex Buell <alex.buell@munted.org.uk>
Date: Wed, 12 Jan 2011 00:20:50 +0000

> On Tue, 2011-01-11 at 15:48 -0800, David Miller wrote:
> 
>> This patch set makes sure that FB drivers for PCI devices utilizing
>> the svgalib interfaces work on multi-domain PCI architectures.
>> 
>> Basically this amounts to making sure that the vgastate->vgabase
>> __iomem pointer makes it way into every interfaces and gets used
>> by all of the I/O access calls.
> 
> jeez, that was fast work! I'd already done the changes in s3fb.c but
> didn't get as far as you did with this. 
> 
> I'm now testing your patches right now.

Thanks a lot in advance for testing Alex.
