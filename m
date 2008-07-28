From: Daniel Smolik <marvin@mydatex.cz>
Date: Mon, 28 Jul 2008 16:15:28 +0000
Subject: Re: [BUG] 2.6.26-rc1 broke X on SPARC Ultra5
Message-Id: <488DF0A0.1060909@mydatex.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <18500.62552.958244.633204@harpo.it.uu.se>
In-Reply-To: <18500.62552.958244.633204@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Mikael Pettersson napsal(a):
> David Miller writes:
>  > From: "Dave Airlie" <airlied@gmail.com>
>  > Date: Wed, 4 Jun 2008 06:45:57 +1000
>  > 
>  > > Wow thats a major userspace regression to ship, we'd never get away
>  > > with doing that on x86 platforms.
>  > 
>  > x86 has how many maintainers and contributors last time you checked?
>  > 
>  > Meanwhile X itself shipped mostly-non-working for PCI devices on sparc
>  > for years.  And would you also not argue that it's broken to begin
>  > with that the older X servers cannot work properly without a root PCI
>  > controller being there?
>  > 
>  > The only way I can work around this issue is to provide a virtual host
>  > bridge driver in the kernel, and I tried to do that, but it doesn't
>  > work which is why the change got installed that did.
>  > 
>  > We'd need this because on many sparc64 machines the PCI host bridge
>  > (and some sub-bridges) aren't even accessible via PCI config space.
>  > 
>  > If you provide a virtual host bridge, you have to emulate all of
>  > the PCI config space accesses, you have to provide the expected
>  > linkage and hierarchy with the rest of the PCI devices, and you
>  > also have to do all of the I/O and MEM space range bits correctly
>  > too.
>  > 
>  > For PCI-E and sub-bridges this becomes even more complicated, and
>  > frankly a waste of time.
>  > 
>  > In short you have to implement an entire non-trivial emulation layer
>  > for this stuff.
>  > 
>  > I'm the only sparc64 platform developer, so my time is better spent
>  > moving forward and making sure that libpciaccess based X servers
>  > aren't so broken and do the right thing in a way which works in a
>  > maintainable long term manner.
> 
> Indeed. You need to prioritize, and FWIW I support your decision.
> 
Have anybody now working X on some multidomain PCI machine like E250 or 
E450 ? I have upgraded to 2.6.26 and latest SID and now is my Permedia2 
card detected but X crashes with :


(++) Using config file: "/root/xorg.conf.new"
(WW) ****INVALID MEM ALLOCATION**** b: 0x20000 e: 0x3ffff correcting
(WW) ****INVALID MEM ALLOCATION**** b: 0x800000 e: 0xffffff correcting
(WW) ****INVALID MEM ALLOCATION**** b: 0x1000000 e: 0x17fffff correcting
mmap failure: Invalid argument

Fatal server error:
xf86MapDomainMem():  mmap() failure

This is much better then before but still not perfect :-(

	Dan







