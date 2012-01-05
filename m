From: David Miller <davem@davemloft.net>
Date: Thu, 05 Jan 2012 19:55:10 +0000
Subject: Re: [PATCH] i2c-ali1535: enable SPARC support
Message-Id: <20120105.145510.2259110209867964309.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4ECE2410.7040608@geomatys.fr>
	<20111227.141759.1836372889946924661.davem@davemloft.net>
	<20120105205105.6a2d03b3@endymion.delvare>
In-Reply-To: <20120105205105.6a2d03b3-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
Cc: corentin.labbe-Um+J1D3rkBVWj0EZb7rXcA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 5 Jan 2012 20:51:05 +0100

> Hi David,
> 
> On Tue, 27 Dec 2011 14:17:59 -0500 (EST), David Miller wrote:
>> From: "corentin.labbe" <corentin.labbe@geomatys.fr>
>> Date: Thu, 24 Nov 2011 12:01:36 +0100
>> 
>> > The i2c-ali1535 driver don't work on SPARC, this is because it assumes that ioport address are 16bits wide (address stored with an unsigned short).
>> > But on SPARC arch, ioports are mapped in memory and so are stored with an unsigned long.
>> > 
>> > This patch corrects this by using pci_resource_start for getting IOMEM base address, then reading the SMBBA of the i2c busse and using together for I/O access.
>> > 
>> > I like to thanks Jean DELVARE for reviewing of my patch.
>> > 
>> > Thanks
>> > 
>> > Signed-off-by: LABBE Corentin <corentin.labbe@geomatys.fr>
>> 
>> Jean has asked for some more changes, please follow his suggestions and
>> resubmit, thanks.
> 
> Actually I ended up doing the changes myself, and the patch is queued
> for 3.3 already:
> http://khali.linux-fr.org/devel/linux-3/jdelvare-i2c/i2c-ali1535-enable-sparc-support.patch
> 
> Please let me know quickly if you see anything wrong there.

Using the raw PCI config register value in the non-IO case is always
wrong and non-portable.  You need to ioremap the thing using the PCI
resource if it's not IO and therefore MEM.

More easier, if non-IO is really not expected, would be to fail the
probe if we don't find IORESOURCE_IO set.
