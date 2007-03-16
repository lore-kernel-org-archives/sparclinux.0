From: David Miller <davem@davemloft.net>
Date: Fri, 16 Mar 2007 21:42:21 +0000
Subject: Re: sparc32 esp connected CDROM failures
Message-Id: <20070316.144221.130235824.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1173976389.16911.13.camel@dhcp-32-109.ord.redhat.com>
In-Reply-To: <1173976389.16911.13.camel@dhcp-32-109.ord.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Fri, 16 Mar 2007 16:38:03 -0500

> On Fri, 2007-03-16 at 16:32 -0500, Tom 'spot' Callaway wrote:
> > On Fri, 2007-03-16 at 13:52 -0700, David Miller wrote:
> > > From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
> > > Date: Fri, 16 Mar 2007 14:47:00 -0500
> > > 
> > > > The ioctl error repeats once more in the sequence...but the CDROM seems
> > > > to work ok, as compared to sparc32, where it refuses to work.
> > > 
> > > Unfortunately that puts the ball in your or someone else's court,
> > > since I don't have any sparc32 systems and therefore any way to work
> > > on sparc32 bugs.
> > 
> > Well, it looks like I spoke too soon. CD1 worked, but CD2 gave me these
> > errors when I tried to read it:
> > 
> > attempt to access beyond end of device
> > sr0: rw=0, want05604, limit68440
> > attempt to access beyond end of device
> > sr0: rw=0, want05608, limit68440
> > attempt to access beyond end of device
> > sr0: rw=0, want05612, limit68440
> > attempt to access beyond end of device
> > sr0: rw=0, want05616, limit68440
> > 
> > Confirmed that the image and the CD is good (it reads fine in several
> > other machines).
> > 
> > CD1 was slightly smaller, perhaps thats why it slipped by?
> 
> CD1 has 619M of data on it.
> CD2 has 638M of data on it.

Nothing in my sparc changes should have any effect here.
It's something else.
