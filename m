From: David Miller <davem@davemloft.net>
Date: Wed, 17 Mar 2010 04:34:42 +0000
Subject: Re: Debian Sparc 5.4 on Sun blade 2500
Message-Id: <20100316.213442.69988179.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1268768091.1768.29.camel@deblnxsrv254.localdomain>
In-Reply-To: <1268768091.1768.29.camel@deblnxsrv254.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Paul Cao <pcao@ashland.edu>
Date: Tue, 16 Mar 2010 19:21:53 -0400

> I have download the iso image. I will install it tomorrow and post the
> results here.

Meanwhile I tried the DVD myself and it worked with my
XVR-500.

I looked at the kernel image on the DVD and it has all the
necessary PCI device IDs to match your card.

So something isn't working right.

I've built a test kernel for you to netboot that should
provide some more bootup messages than you're getting
now.  Please find it at:

	http://vger.kernel.org/~davem/xvr600_test.img

When netbooted it should print something like:

e3d: Found device at /pci.....

when it detects your graphics card.

And then it should say something like:

fbcon: e3d (fb0) is primary device
Console: switching to colour frame buffer device 210x65

If it prints all of that and you still don't get a console
then the framebuffer is mapped on XVR-600/XVR-1200 chips
different than it is on XVR-500 chips and I'll have to
figure that out.  It could take a week or so to fix this
in that case.

Thanks.
