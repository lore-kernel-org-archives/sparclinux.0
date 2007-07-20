From: David Miller <davem@davemloft.net>
Date: Fri, 20 Jul 2007 22:35:18 +0000
Subject: Re: ESP SCSI and QLGC,ISP SCSI drivers not finding attached devices
Message-Id: <20070720.153518.59469498.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0707201404250.7470@mtfhpc.demon.co.uk>
	<1184941136.3455.8.camel@localhost.localdomain>
	<Pine.LNX.4.61.0707201602080.7721@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707201602080.7721@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mark@mtfhpc.demon.co.uk
Cc: James.Bottomley@SteelEye.com, sparclinux@vger.kernel.org, linux-scsi@vger.kernel.org


I think these reports all point to a problem with the sparc32
kernel far outside of the drivers in question.

We have no reports like this on sparc64.

My running theory is that things like msleep() are returning
immediately on sparc32, or at least too fast, instead of delaying
the minimum necessary amount.

This will screw up the scsi reset settle delay, and the devices will
return scsi command status's that the SCSI bus probe will consider not
good enough to recognize the device.

This is exactly what tracing from Tom Callaway has shown in the past.

So this is a sparc32 kernel bug of some sort, most likely, not a
driver bug.

