From: James Bottomley <James.Bottomley@SteelEye.com>
Date: Fri, 20 Jul 2007 14:18:56 +0000
Subject: Re: ESP SCSI and QLGC,ISP SCSI drivers not finding attached devices
Message-Id: <1184941136.3455.8.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0707201404250.7470@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707201404250.7470@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Cc: davem@davemloft.net, sparclinux@vger.kernel.org, linux-scsi@vger.kernel.org

On Fri, 2007-07-20 at 14:26 +0100, Mark Fortescue wrote:
> I have been having intermittant issues with the QLGC,isp driver 
> (qlogicpti.c) not finding any attached devices on my sun4c. Having now 
> moved on to Linux-2.6.22 this problem is now also affecting the ESP SCSI 
> driver and is nolonger intermittant.
> 
> My test setup uses an NFS root so it is currently independent of the SCSI 
> drivers/subsystem. I am hoping to change this in the near future so that 
> my sun4c boots into linux by default.
> 
> What kernel options can I use to try to work out why the drivers are 
> ignoring disks (there are no other types of attached device at present). 
> Are any special options needed to force the scsi subsystem to spin the 
> disk up and wait untill they become ready (The disk [target 0:0:3] on the 
> ESP auto-spins down if it is idle for too long and now that booting takes 
> longer ...) ?

nothing in the driver ... that's a firmware issue.  What all SPI drivers
do is address the device and wait 250ms for a response (as per the
standard).  If nothing comes back, they assume there's nothing on the
bus.  You might be able to increase the no connect timeout, but it looks
to be a firmware property of both qlogicpti and esp (and if you do this,
scanning will take longer).  250ms is a huge amount of time in SPI, so
I'd suspect there was some type of bus or device problem.

> Is there a way to get a NON-moduler scsi driver to re-scan its SCSI bus 
> from shell prompt (writing to a sysfs/procfs file)?

/sys/class/scsi_host/host<n>/scan

> >From my point of view, it looks like the command timeout is very much too 
> short. Is there a simple way of testing this theory on the ESP driver?

See above, but really 250ms should be more than adequate.

James



