From: David Miller <davem@davemloft.net>
Date: Tue, 10 Jun 2008 19:53:07 +0000
Subject: Re: [panic] "Cheetah error trap taken" with Debian 2.6.24 kernel
Message-Id: <20080610.125307.219971839.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200806100003.54269.elendil@planet.nl>
In-Reply-To: <200806100003.54269.elendil@planet.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Tue, 10 Jun 2008 11:59:01 -0700 (PDT)

> From: "Alexander Vlasov" <alexander.vlasov@gmail.com>
> Date: Tue, 10 Jun 2008 14:02:50 +0200
> 
> > I have to confirm that problem is somehow related to radeonfb.
> > This problem happens only with TWO Sun XVR-300 videocards installed; when
> > I'm pulling one card out, kernel boots fine.
> 
> Now that's a good clue.
> 
> I wonder if the firmware mis-sizes one of the ROM resource
> properties in cases like this.

As an aside, I have one of these XVR-300 cards in my Ultra45
and I'm planing to fix up several other problems I've
seen.

For example, with acceleration enabled, the card locks up
shortly after starting to bootup with current kernels.
After talking with the radeon fb driver maintainers, the
thinking is that the card initialization code in the kernel
fb driver is simply out of date and needs to be made more
in sync with what the XORG driver uses.

That's a lot of work, so don't expect any progress in this
area for several weeks.

So, for now, put only one card into the machine and disable
console output acceleration on the kernel command line.
