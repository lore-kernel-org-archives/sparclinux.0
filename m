From: David Miller <davem@davemloft.net>
Date: Tue, 17 Apr 2007 21:12:34 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <20070417.141234.71089380.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Tue, 17 Apr 2007 15:46:55 -0500

> On Mon, 2007-04-16 at 01:29 -0700, David Miller wrote:
> 
> > The sense looks good, the device is just saying that it has
> > been reset too recently.
> > 
> > The extended sense codes are 0x29 and 0x02, but the scsi scan only
> > retries the INQUIRY if the extended sense codes are 0x29 and 0x00 for
> > whatever reason.
> > 
> > Let's let the bus settle properly after a scsi reset in order to avoid
> > this altogether.
> > 
> > Please give this patch a spin.
> 
> This does the trick.

Thanks for testing.

> Only issue of concern: Mounting CDROMs seems to throw:
> 
> Buffer I/O error on device sr0, logical block 2096896
> Buffer I/O error on device sr0, logical block 2096897
> Buffer I/O error on device sr0, logical block 2096898
> Buffer I/O error on device sr0, logical block 2096899
> Buffer I/O error on device sr0, logical block 2096900
> Buffer I/O error on device sr0, logical block 2096901
> Buffer I/O error on device sr0, logical block 2096902
> Buffer I/O error on device sr0, logical block 2096903
> Buffer I/O error on device sr0, logical block 2096896
> Buffer I/O error on device sr0, logical block 2096897
> 
> None of these errors seems fatal, the CDROM mounts fine, and is usable.

I wonder what is trying to access the CDROM past the end like that.

Assuming that the block size is 512 bytes, block 2096896 would be just
under 1GB into the CDROM which is much larger than a CDROM can be. :-)

