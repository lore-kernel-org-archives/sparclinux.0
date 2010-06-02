From: Alex Chiang <achiang@canonical.com>
Date: Wed, 02 Jun 2010 03:53:09 +0000
Subject: Re: [2.6.35-rc1 regression] sysfs: cannot create duplicate
Message-Id: <20100602035309.GA2849@canonical.com>
List-Id: <sparclinux.vger.kernel.org>
References: <19461.26166.427857.612983@pilspetsen.it.uu.se>
 <20100601.153105.90813554.davem@davemloft.net>
 <20100602030925.GA3402@canonical.com>
In-Reply-To: <20100602030925.GA3402@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>, mikpe@it.uu.se, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

* Alex Chiang <achiang@canonical.com>:
> * David Miller <davem@davemloft.net>:
> > From: Mikael Pettersson <mikpe@it.uu.se>
> > Date: Tue, 1 Jun 2010 21:57:42 +0200
> > 
> > > Booting 2.6.35-rc1 on a Sun Blade 2500 Red, I'm greeted with:
> > 
> > I know about the problem and will look at it soon hopefully, I see it
> > on some of my sparc64 boxes too.
>  
> I haven't been able to reproduce this yet (trying with kvm, not
> successful with bare metal), but one thing I've noticed is that
> it occurs when either a PCI hotplug driver or the ACPI PCI slot
> detection driver is loaded.

Hm. If acpiphp is a built-in, I get the warnings (in kvm). If
it's a module, no warnings, not even after modprobing.

Continuing to dig...

/ac
