From: David Miller <davem@davemloft.net>
Date: Sat, 25 Oct 2008 05:18:13 +0000
Subject: Re: kernel crashes on Sun Fire 480R with cassini network driver
Message-Id: <20081024.221813.238062145.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080923133152.GC17211@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20080923133152.GC17211@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Fri, 24 Oct 2008 17:24:33 +0200

> Hello all,
> 
> On Mon, Sep 29, 2008 at 10:19:54AM +0200, Hermann Lauer wrote:
> > > while trying to run vanilla linux-2.6.26.5 or the debian etchnhalf kernel
> > > (2.6.24.x) I noticed the cassini network driver for the builtin gigabit
> > > network is unstable and brings the kernel down on a dualprocessor sparc
> > > SunFire 480R with a Hardware FATAL RESET.
> > 
> > I now noticed that even a few pings are possible with the cassini
> > network driver if you configure it statically, but then the machine again 
> > crashes with the known: 
> > ERROR: System Hardware FATAL RESET from  CPU0 CPU2
> 
> tried 2.6.27.2 today, but this hangs already at loading the kernel.
> Output is attached. Please tell me what else I can provide.

Thanks, but for the time being all you can really do to help is be
patient until I can look into this again.

More and more dumps only backlogs me further, and will make it take
longer for me to analyze your initial report.
