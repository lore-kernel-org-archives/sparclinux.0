From: Laszlo Valko <valko@linux.karinthy.hu>
Date: Sat, 21 Nov 2009 23:26:05 +0000
Subject: Re: 2.6.31.6 freezes on v210
Message-Id: <20091122002605.A13449@linux.karinthy.hu>
List-Id: <sparclinux.vger.kernel.org>
References: <20091120210249.A20906@linux.karinthy.hu>
In-Reply-To: <20091120210249.A20906@linux.karinthy.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Nov 21, 2009 at 09:40:55PM +0100, Hermann Lauer wrote:
> Just to let you know, thats what I found on my SunFire880/480:
> 
> Date: Fri, 6 Feb 2009 11:28:25 +0100
> 
> > I bisected meanwhile the complete versions from 2.6.26 to 2.6.27 series:
> > 
> > <2.6.26.8	boots
> >  2.6.27-rc1	compile fails (see below)
> > >2.6.27-rc2	hangs at boot
> 

What I have found so far with 2.6.31.6:

I have read the threads in the mail archives about your & Sebastien's
problems, and it looks pretty much the same to me (with log timing printout
switched off, the last characters I see is 'Test').

CONFIG_PROM_CONSOLE has already been ripped from the kernel so I don't
have to switch that off.

If I leave CONFIG_SMP in, then the problem is there. I stripped off almost
everything (all block devices, all character devices, all filesystems, all
networking, even PCI support), and I still get the freeze. Even if I
specify nosmp to the kernel.
However, if I switch off CONFIG_SMP, then the problem goes away. I
cross-checked this also with my gentoo hardened 2.6.31, will all my nifty
features turn on, but SMP off, and voila, everything works - well, at
least on one CPU.

Now I'm going to see which kernel update introduced the problem.

> Will try your config with a 2.6.28 kernel next week. Could you please provide
> your working 2.6.28 vmlinux binary on the web/ftp so that I can try this
> on my machines ?

Here's the 2.6.28 kernel that worked for me:
http://info.mediastorm.hu/kernel-2.6.28-hardened-r9

Regards,
Laszlo


> 
> Thanks,
>   Hermann
> 
> -- 
> Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
> Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
> IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
> Email: Hermann.Lauer@iwr.uni-heidelberg.de
