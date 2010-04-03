From: David Miller <davem@davemloft.net>
Date: Sat, 03 Apr 2010 02:01:55 +0000
Subject: Re: Kernel panic - not syncing: Irrecoverable deferred error trap
Message-Id: <20100402.190155.150160807.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1270240845.1783.52.camel@deblnxsrv254.localdomain>
In-Reply-To: <1270240845.1783.52.camel@deblnxsrv254.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Frans van Berckel <fberckel@xs4all.nl>
Date: Fri, 02 Apr 2010 22:40:45 +0200

> [    0.000000] OF stdout device is: /pci@8,700000/ebus@5/serial@1,400000:a

Ok, this indicates actually what causes the problem.

If the OF console device is not one of these graphics cards we can't
touch the graphics card at all, not even the framebuffer, because it
hasn't been fully initialized yet.

The same thing would happen if you used the XVR-1200 as your OF
console devices.

I'll come up with something, thanks for the report.
