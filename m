From: David Miller <davem@davemloft.net>
Date: Sat, 14 Apr 2007 16:57:44 +0000
Subject: Re: [ANNOUNCE] Aurora SPARC Linux Build 2.98 (Beta 1 for 3.0)
Message-Id: <20070414.095744.82708237.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1175577171.3531.131.camel@localhost.localdomain>
In-Reply-To: <1175577171.3531.131.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Blue Swirl" <blauwirbel@gmail.com>
Date: Sat, 14 Apr 2007 10:59:19 +0300

> I'm testing the Aurora CDROM on Qemu (current CVS version). The
> install seems to run fine, but at start Qemu gives the following error
> messages a few times:
> scsi-disk: Inquiry buffer too small (4)
> 
> Maybe this message is related to esp errors?

I don't think so, my Ultra60 installed perfectly fine and that
uses scsi too.

What kind of scsi device does qemu emulate?
