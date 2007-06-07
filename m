From: Mikael Pettersson <mikpe@it.uu.se>
Date: Thu, 07 Jun 2007 06:24:57 +0000
Subject: Re: [BUG sparc64] 2.6.22-rc broke X on Ultra5
Message-Id: <200706070624.l576Ovbd008665@harpo.it.uu.se>
List-Id: <sparclinux.vger.kernel.org>
References: <18002.44181.639121.720839@alkaid.it.uu.se>
In-Reply-To: <18002.44181.639121.720839@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, mikpe@it.uu.se
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Wed, 06 Jun 2007 16:22:10 -0700 (PDT), David Miller <davem@davemloft.net> wrote:
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

With 2.6.21 + the broken patches, yes. With 2.6.22-rc I got
a slightly different message which still said something about
a PCI mmap failure.

BTW, I have xorg-6.8.1 (Aurora 2.0 user-space), which might
explain why we see different behaviour.

> Investigation reveals that X.org is erroneously trying to
> do PCI mmap ioctl()'s on /sys/bus/pci/devices/*/config
> files which is very very wrong.  Again this happens for me
> with both 2.6.20 and 2.6.22
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

I'm away from my ultra5 right now, but I should be able to do
this test on Monday next week. 

/Mikael
