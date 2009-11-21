From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Sat, 21 Nov 2009 20:40:55 +0000
Subject: Re: 2.6.31.6 freezes on v210
Message-Id: <20091121204055.GB22256@lemon.iwr.uni-heidelberg.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20091120210249.A20906@linux.karinthy.hu>
In-Reply-To: <20091120210249.A20906@linux.karinthy.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Nov 21, 2009 at 05:47:43AM +0100, Laszlo Valko wrote:
> On Fri, Nov 20, 2009 at 02:49:51PM -0800, David Miller wrote:
> > From: Laszlo Valko <valko@linux.karinthy.hu>
> > Date: Fri, 20 Nov 2009 21:02:49 +0100
> > 
> > > I'd appreciate any help to track down the problem.
> > 
> > It's a well known issue we've been trying to track down for some time
> > now.  We still have no real idea what the exact problem is.
> > 
> > Somone has a remote console setup for me to diagnose this remotely
> > since none of my own systems trigger this behavior.
> 
> Does it help if I try to narrow this down both the kernel version introducing
> this, and the minimum set of config options with which I can still
> reproduce it?

Just to let you know, thats what I found on my SunFire880/480:

Date: Fri, 6 Feb 2009 11:28:25 +0100

> I bisected meanwhile the complete versions from 2.6.26 to 2.6.27 series:
> 
> <2.6.26.8	boots
>  2.6.27-rc1	compile fails (see below)
> >2.6.27-rc2	hangs at boot

Will try your config with a 2.6.28 kernel next week. Could you please provide
your working 2.6.28 vmlinux binary on the web/ftp so that I can try this
on my machines ?

Thanks,
  Hermann

-- 
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de
