From: Dmitry Artamonow <mad_soft@inbox.ru>
Date: Sat, 09 Jun 2007 09:18:04 +0000
Subject: Re: [BUG sparc64] 2.6.22-rc broke X on Ultra5
Message-Id: <20070609091804.GA3793@sunflower.office.asoft.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <200705301933.l4UJXIE0023913@alkaid.it.uu.se> <20070530.130140.97293476.davem@davemloft.net> <20070606.162210.35662366.davem@davemloft.net>
In-Reply-To: <20070606.162210.35662366.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: mikpe@it.uu.se, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

Good day!

Sorry for intruding, but I'm seeing the same problem on my U10 with 
2.6.22-rc3 and Xorg-7.1+gentoo patches.

On Wed, Jun 06, 2007 at 04:22:10PM -0700, David Miller wrote:
> From: David Miller <davem@davemloft.net>
> Date: Wed, 30 May 2007 13:01:40 -0700 (PDT)
> 
> > From: Mikael Pettersson <mikpe@it.uu.se>
> > Date: Wed, 30 May 2007 21:33:18 +0200 (MEST)
> > 
> > > You were spot on. 2.6.21 + patches up to but not including
> > > the first one above works. Adding that one gave me a kernel
> > > that wouldn't boot (hung after "uncompressing kernel").
> > > Adding the second one above gave me a kernel that booted, but
> > > where X failed to mmap() the frame buffer as I described.
> > 
> > Thanks for all of your testing.
> > 
> > I'll try to figure this out on one of my Ultra5's here.
> 
> So I did some more digging, got my ultra5 running and I can't
> get it to work with both 2.6.20 and 2.6.22-rc4 :-)  This is
> with xorg-7.2, and they both fail with:
> 
> xf86MapPciMem: Could not mmap ...
> 
> which I assume is the error you're seeing.
> 
> Investigation reveals that X.org is erroneously trying to
> do PCI mmap ioctl()'s on /sys/bus/pci/devices/*/config
> files which is very very wrong.  Again this happens for me
> with both 2.6.20 and 2.6.22

Xorg-7.2 (to be more precise, xorg-server-1.2.0) never worked for me, you 
can see my bug on gentoo bugzilla for more info:
http://bugs.gentoo.org/show_bug.cgi?id7052
But Xorg-7.1 worked fine on kernels up and including 2.6.21

> 
> Can you just quickly strace "Xorg" startup in the working
> and non-working case?  Just a simple:
> 
> 	strace -o x.log Xorg
> 
> would for both cases be fine.
> 
> You can email it to me privately, and I'll post here my
> analysis with the relevant portions quoted so we don't
> flood the list with strace dumps :-)
> 
> Thanks a lot!

I sent David privately my .configs , Xorg.0.logs and strace logs for 2.6.21 
and 2.6.22-rc3. Hope it helps.

--
Best regards,
Dmitry 'MAD' Artamonow
