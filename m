From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Mon, 23 Jul 2007 22:41:34 +0000
Subject: QLGC,ISP SCSI driver not finding attached devices
Message-Id: <Pine.LNX.4.61.0707232315510.16213@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0707201404250.7470@mtfhpc.demon.co.uk>
 <1184941136.3455.8.camel@localhost.localdomain>
 <Pine.LNX.4.61.0707201602080.7721@mtfhpc.demon.co.uk>
 <1184950646.3455.45.camel@localhost.localdomain>
 <Pine.LNX.4.61.0707201822250.8013@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707201822250.8013@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: davem@davemloft.net, sparclinux@vger.kernel.org, linux-scsi@vger.kernel.org

Hi James,

Can you point me in the direction of any documentation to aid me in 
identifing what debugging I need to work out what is going on?

For targets without any connected disk, I get scan responses of:
     scsi scan: INQUIRY failed with code 0x40000
after app 417ms.

For targets with a disk connected, I get scan responses of:
     scsi scan: INQUIRY failed with code 0x8000002
after app 170ms.

Can you tell me how to decode the error codes?
(The times are from the sun4c 1us counter14)

I did get the driver to work on one occasion but I have not been able to 
repeat the achivement.

I can also get the ESP driver to fail to find disks with the same error 
codes if I build it as a module driver however if I build the ESP driver 
into the kernel, it does not fail (ESP BUS_TIMEOUT'5).

Regards
 	Mark Fortescue.


