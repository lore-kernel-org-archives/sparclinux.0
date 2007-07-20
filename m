From: James Bottomley <James.Bottomley@SteelEye.com>
Date: Fri, 20 Jul 2007 16:57:26 +0000
Subject: Re: ESP SCSI and QLGC,ISP SCSI drivers not finding attached devices
Message-Id: <1184950646.3455.45.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0707201404250.7470@mtfhpc.demon.co.uk>
	 <1184941136.3455.8.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0707201602080.7721@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707201602080.7721@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Cc: davem@davemloft.net, sparclinux@vger.kernel.org, linux-scsi@vger.kernel.org

On Fri, 2007-07-20 at 16:22 +0100, Mark Fortescue wrote:
> Thansk for the info. I will try some experiments and see if I can work 
> out where the scsi commands/responses are getting lost.

Actually, for ESP it looks like you can alter the timeout ... it's the
parameter ESP_BUS_TIMEOUT in drivers/scsi/esp_scsi.h

It could be that the register calculation is off here ... but someone
who knows the device would have to look at it (or you could time it, I
suppose).

> I do not beleave the issue with the ESP is a hardware problem. The PROM 
> and SunOS-4.1.1 have no problem finding/accessing the disk on the ESP and 
> I did not observe any issues prior to testing Linux v2.6.22. The V1 ESP 
> SCSI driver never failed to find the ESP disk (on kernels that got that 
> far) but I have not done as much testing with the V2 ESP driver as memory 
> problems post v2.6.21 needed to be fixed to get things up and running.

James


