From: Per =?iso-8859-1?q?=D8yvind_Karlsen?= <pkarlsen@mandriva.com>
Date: Wed, 25 Oct 2006 15:23:34 +0000
Subject: Re: Problems booting 2.6.18 on SunBlade 100/150
Message-Id: <200610251723.35495.pkarlsen@mandriva.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200401070729.56891.pkarlsen@mandriva.com>
In-Reply-To: <200401070729.56891.pkarlsen@mandriva.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Onsdag 25 oktober 2006 01:44, skrev David Miller:
> From: David Miller <davem@davemloft.net>
> Date: Tue, 24 Oct 2006 16:32:59 -0700 (PDT)
>
> > From: Per =D8yvind Karlsen <pkarlsen@mandriva.com>
> > Date: Wed, 25 Oct 2006 01:31:23 +0200
> >
> > > So, did we get to any conclusion on this one?
> > >
> > > Should I dig through changes between -rc3 & -rc4 to exactly pinpoint
> > > the breakage, or do you have enough info on the matter to work with?
> >
> > I have enough info to look into this.
>
> Well, I just did a diff between 2.6.17-rc3 and 2.6.17-rc4, which is
> where you say the breakage got introduced, and there is nothing that
> even remotely could cause atyfb breaking.
>
> All sparc64 changes are:
>
> 1) Changes to arguments passed to audit_syscall_{entry,exit}()
>    Cannot possibly effect framebuffer operation.
>
> 2) Add support for vmsplice() system call, again cannot possibly
>    break your framebuffer.
>
> 3) Add preempt() protection around flush_tlb_pending(), again cannot
>    possible break your framebuffer.
>
> 4) Remove prototype for a function whose implementation got deleted
>    years ago.  Cannot possibly break anything.
>
> All PCI layer changes are:
>
> 1) MSI layer memory leak fix, sparc64 does not turn on CONFIG_MSI
>    and thus can't even execute this code.
>
> 2) printk message change in quirk layer, can't break anything.
>
> All framebuffer layer changes are:
>
> 1) Help text added to FB_ASILIANT kernel config option, cannot
>    break atyfb.
>
> 2) Changes to au1200fb.c driver, not used by sparc64 nor every built
>    into the sparc64 kernel image.
>
> 3) SYSFS changes for framebuffer, wrt. cmap writes to /sys filesystem
>    files after boot.  Cannot break the atyfb framebuffer on bootup.
>
> 4) Minor changes to the Makefile rule that builds the video
>    framebuffer logo image file, cannot break atyfb.
>
> So there is absolutely nothing for me to work with.
>
> Does the kernel in 2.6.17-rc4 say anything interesting if you
> boot with the "-p" option on the kernel boot command line?
> Do you get an OOPS or some other kind of crash message?
Okay, I did some more testing, and just to be on the safe side to ensure=20
kernel actually being the one to blame I recompiled -rc3 with the same conf=
ig=20
(from /proc/config.gz) and now I have the same problem with 2.4.17-rc3 too =

(even the same messages related to PCI/DMA stuff)!

So I'm really puzzled, could it be related to any possible changes in=20
toolchain causing this or something similar?

I did try booting with -p and I saw it booting up, no oopses when trying to=
=20
change to framebuffer as far as I could see, but then again, I only catched=
 a=20
glimpse ;) Is there any way to log these messages to somewhere? I'm unable =
to=20
get serial cnsole & framebuffer working at same time and heard rumours abou=
t=20
it not being doable..

Btw. if you have a kernel with atyfb booting without any issues on your SB1=
00,=20
could you maybe put it up somewhere for me to test? If it boots without=20
screwing things up, it must be the toolchain, I see my old kernel was=20
compiled with another release of gcc..
--=20
Regards,
Per =D8yvind Karlsen
Mandriva
