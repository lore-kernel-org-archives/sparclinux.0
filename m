From: David Miller <davem@davemloft.net>
Date: Wed, 04 Mar 2009 11:45:28 +0000
Subject: Re: esp scsi problem on shutdown - sunhme related?
Message-Id: <20090304.034528.162386526.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0903041320480.12608@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0903041320480.12608@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Wed, 04 Mar 2009 03:35:14 -0800 (PST)

> From: Meelis Roos <mroos@linux.ee>
> Date: Wed, 4 Mar 2009 13:22:21 +0200 (EET)
> 
> > > I successfully installed Debian Lenny with 2.6.26 kernel, later compiled 
> > > yesterdays 2.6.29-rc6+git. Both kernels have the same problem - on 
> > > shutdown, scsi disk goes offline like in console log below. This is 
> > > repeatable and happens every shutdown so far.
> > 
> > Testing by hand shows that 'ifconfig eth0 down' on eth0 (SBus hme) is 
> > the command that kills esp.
> 
> Thanks for figuring out this clue.  I'll see if there is anything
> obvious in that area.

Meelis... if ESP is aborting commands this smells like
interrupt problems.  I suspect that when HME is brought
down, this accidently disables ESP's interrupt.

Do any of your hme chips share interrupts with esp chips?

What does /proc/interrupts look like on this system when
everything is up and running?

Thanks!
