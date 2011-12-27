From: David Miller <davem@davemloft.net>
Date: Tue, 27 Dec 2011 19:17:59 +0000
Subject: Re: [PATCH] i2c-ali1535: enable SPARC support
Message-Id: <20111227.141759.1836372889946924661.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4ECE2410.7040608@geomatys.fr>
In-Reply-To: <4ECE2410.7040608-Um+J1D3rkBVWj0EZb7rXcA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: corentin.labbe-Um+J1D3rkBVWj0EZb7rXcA@public.gmane.org
Cc: sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

From: "corentin.labbe" <corentin.labbe@geomatys.fr>
Date: Thu, 24 Nov 2011 12:01:36 +0100

> The i2c-ali1535 driver don't work on SPARC, this is because it assumes that ioport address are 16bits wide (address stored with an unsigned short).
> But on SPARC arch, ioports are mapped in memory and so are stored with an unsigned long.
> 
> This patch corrects this by using pci_resource_start for getting IOMEM base address, then reading the SMBBA of the i2c busse and using together for I/O access.
> 
> I like to thanks Jean DELVARE for reviewing of my patch.
> 
> Thanks
> 
> Signed-off-by: LABBE Corentin <corentin.labbe@geomatys.fr>

Jean has asked for some more changes, please follow his suggestions and
resubmit, thanks.
