From: "Benoit-Pierre Guay" <bpguay@infopremiere.com>
Date: Fri, 20 Mar 2009 17:25:50 +0000
Subject: Re: esp scsi problem on shutdown - sunhme related?
Message-Id: <b7a9a1b9-20fc-4f4a-ad2f-a8fb6dd6c3be@infopremiere.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0903041320480.12608@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0903041320480.12608@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Hello David!

I have exactly the same problem of Meelis on my Sun Ultra Enterprise 3000.

Here's the output of my /proc/interrupts :

berta-test:~# cat /proc/interrupts
           CPU10       CPU14       
  0:       8346       7272     <NULL>  timer
  2:          7          0      sun4u  zs
  4:          0          0      sun4u  SYSIO_UE
  5:          0          0      sun4u  SYSIO_CE
  6:          0          0      sun4u  SYSIO_SBERR
 13:          0          0      sun4u  SYSIO_UE
 14:          0          0      sun4u  SYSIO_CE
 15:          0          0      sun4u  SYSIO_SBERR
 19:       1676          0      sun4u  eth0
 20:       1604      11293      sun4u  ESP
 22:          0          0      sun4u  SYSIO_UE
 23:          0          0      sun4u  SYSIO_CE
 24:          0          0      sun4u  SYSIO_SBERR
 31:          0          0      sun4u  SYSIO_UE
 32:          0          0      sun4u  SYSIO_CE
 33:          0          0      sun4u  SYSIO_SBERR
 38:         15          0      sun4u  ESP
 39:          0          7      sun4u  ESP
berta-test:~# 

Hope it can help to solve the problem!

Benoit-Pierre


From: David Miller <davem@davemloft.net>

> From: David Miller <davem@davemloft.net>
> Date: Wed, 04 Mar 2009 03:35:14 -0800 (PST)
> 
> > From: Meelis Roos <mroos@linux.ee>
> > Date: Wed, 4 Mar 2009 13:22:21 +0200 (EET)
> > 
> > > > I successfully installed Debian Lenny with 2.6.26 kernel, later compiled 
> > > > yesterdays 2.6.29-rc6+git. Both kernels have the same problem - on 
> > > > shutdown, scsi disk goes offline like in console log below. This is 
> > > > repeatable and happens every shutdown so far.
> > > 
> > > Testing by hand shows that 'ifconfig eth0 down' on eth0 (SBus hme) is 
> > > the command that kills esp.
> > 
> > Thanks for figuring out this clue.  I'll see if there is anything
> > obvious in that area.
> 
> Meelis... if ESP is aborting commands this smells like
> interrupt problems.  I suspect that when HME is brought
> down, this accidently disables ESP's interrupt.
> 
> Do any of your hme chips share interrupts with esp chips?
> 
> What does /proc/interrupts look like on this system when
> everything is up and running?
> 
> Thanks!
> 
