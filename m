From: David Miller <davem@davemloft.net>
Date: Tue, 24 Oct 2006 23:44:46 +0000
Subject: Re: Problems booting 2.6.18 on SunBlade 100/150
Message-Id: <20061024.164446.13769256.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200401070729.56891.pkarlsen@mandriva.com>
In-Reply-To: <200401070729.56891.pkarlsen@mandriva.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Tue, 24 Oct 2006 16:32:59 -0700 (PDT)

> From: Per =D8yvind Karlsen <pkarlsen@mandriva.com>
> Date: Wed, 25 Oct 2006 01:31:23 +0200
>=20
> > So, did we get to any conclusion on this one?
> >=20
> > Should I dig through changes between -rc3 & -rc4 to exactly pinpoint th=
e=20
> > breakage, or do you have enough info on the matter to work with?
>=20
> I have enough info to look into this.

Well, I just did a diff between 2.6.17-rc3 and 2.6.17-rc4, which is
where you say the breakage got introduced, and there is nothing that
even remotely could cause atyfb breaking.

All sparc64 changes are:

1) Changes to arguments passed to audit_syscall_{entry,exit}()
   Cannot possibly effect framebuffer operation.

2) Add support for vmsplice() system call, again cannot possibly
   break your framebuffer.

3) Add preempt() protection around flush_tlb_pending(), again cannot
   possible break your framebuffer.

4) Remove prototype for a function whose implementation got deleted
   years ago.  Cannot possibly break anything.

All PCI layer changes are:

1) MSI layer memory leak fix, sparc64 does not turn on CONFIG_MSI
   and thus can't even execute this code.

2) printk message change in quirk layer, can't break anything.

All framebuffer layer changes are:

1) Help text added to FB_ASILIANT kernel config option, cannot
   break atyfb.

2) Changes to au1200fb.c driver, not used by sparc64 nor every built
   into the sparc64 kernel image.

3) SYSFS changes for framebuffer, wrt. cmap writes to /sys filesystem
   files after boot.  Cannot break the atyfb framebuffer on bootup.

4) Minor changes to the Makefile rule that builds the video
   framebuffer logo image file, cannot break atyfb.

So there is absolutely nothing for me to work with.

Does the kernel in 2.6.17-rc4 say anything interesting if you
boot with the "-p" option on the kernel boot command line?
Do you get an OOPS or some other kind of crash message?
