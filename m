From: David Miller <davem@davemloft.net>
Date: Fri, 20 Jul 2007 22:36:18 +0000
Subject: Re: ESP SCSI and QLGC,ISP SCSI drivers not finding attached devices
Message-Id: <20070720.153618.108742928.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1184950646.3455.45.camel@localhost.localdomain>
	<Pine.LNX.4.61.0707201822250.8013@mtfhpc.demon.co.uk>
	<Pine.LNX.4.61.0707202101270.8250@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707202101270.8250@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mark@mtfhpc.demon.co.uk
Cc: James.Bottomley@SteelEye.com, sparclinux@vger.kernel.org, linux-scsi@vger.kernel.org

From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Fri, 20 Jul 2007 21:27:42 +0100 (BST)

> I have found that on my sun4c, I need to increase the ESP_BUS_TIMEOUT from 
> 250ms to 275ms when I build the ESP driver into the kernel or the ESP 
> does not find the disk.
> 
> If I build the driver as a module, this extra 25ms is not required. Any 
> idears?
> 
> Given that the V1 EPS driver used 275ms and the 250ms is only recommended 
> (SCSI II Std. ISO-IEC-9316-1995), should the ESP_BUS_TIMEOUT be changed 
> back to 275ms?

Thanks for tracking this down, I'll bump up the timeout. :-)
