From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 05 Jan 2012 20:06:00 +0000
Subject: Re: [PATCH] i2c-ali1535: enable SPARC support
Message-Id: <20120105210600.7c099f75@endymion.delvare>
List-Id: <sparclinux.vger.kernel.org>
References: <4ECE2410.7040608@geomatys.fr>
	<20111227.141759.1836372889946924661.davem@davemloft.net>
	<20120105205105.6a2d03b3@endymion.delvare>
	<20120105.145510.2259110209867964309.davem@davemloft.net>
In-Reply-To: <20120105.145510.2259110209867964309.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: corentin.labbe@geomatys.fr, sparclinux@vger.kernel.org, linux-i2c@vger.kernel.org

On Thu, 05 Jan 2012 14:55:10 -0500 (EST), David Miller wrote:
> From: Jean Delvare <khali@linux-fr.org>
> Date: Thu, 5 Jan 2012 20:51:05 +0100
> > Actually I ended up doing the changes myself, and the patch is queued
> > for 3.3 already:
> > http://khali.linux-fr.org/devel/linux-3/jdelvare-i2c/i2c-ali1535-enable-sparc-support.patch
> > 
> > Please let me know quickly if you see anything wrong there.
> 
> Using the raw PCI config register value in the non-IO case is always
> wrong and non-portable.  You need to ioremap the thing using the PCI
> resource if it's not IO and therefore MEM.
> 
> More easier, if non-IO is really not expected, would be to fail the
> probe if we don't find IORESOURCE_IO set.

It's indeed not expected, and failing is what Corentin's original patch
was doing. I had him change (actually did the change myself with his
approval) to limit the risk of regression. I don't expect MEM but maybe
no resource type at all (i.e. BAR 0 unused.)

The rationale is that old PC boards use the same PCI chipset and we
were not able to find any tester. I have no idea what the PCI resources
look like on these machines, but I know the driver used to work OK, so
the strategy is to make the new code behave the same as the original
code if things don't look as expected.

We can revisit if/when we find a tester with ALI1535 on x86.

-- 
Jean Delvare
