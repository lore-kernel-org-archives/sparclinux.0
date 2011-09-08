From: Yong Zhang <yong.zhang0@gmail.com>
Date: Thu, 08 Sep 2011 03:15:35 +0000
Subject: Re: [PATCH 20/62] sparc: irq: Remove IRQF_DISABLED
Message-Id: <20110908031535.GB8890@zhy>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LFD.2.02.1109071933080.2723@ionos>
 <20110907.135110.2069876782156753239.davem@davemloft.net>
 <alpine.LFD.2.02.1109071954200.2723@ionos>
 <20110907.141424.1469075127690660949.davem@davemloft.net>
 <alpine.LFD.2.02.1109072043020.2723@ionos>
In-Reply-To: <alpine.LFD.2.02.1109072043020.2723@ionos>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, joe@perches.com, sparclinux@vger.kernel.org

On Wed, Sep 07, 2011 at 08:43:56PM +0200, Thomas Gleixner wrote:
> On Wed, 7 Sep 2011, David Miller wrote:
> 
> > From: Thomas Gleixner <tglx@linutronix.de>
> > Date: Wed, 7 Sep 2011 19:57:21 +0200 (CEST)
> > 
> > > On Wed, 7 Sep 2011, David Miller wrote:
> > >> From: Thomas Gleixner <tglx@linutronix.de>
> > >> Date: Wed, 7 Sep 2011 19:33:52 +0200 (CEST)
> > >> 
> > >> We had big problems when openning thousands of virtual network
> > >> devices, each with their own unique IRQ, and pointed all at the same
> > >> cpu, and we'd get IRQ stack overflows.
> > >> 
> > >> See commit c58543c869606532c2382f027d6466f4672ea756
> > >> 
> > >> So this change to make IRQF_DISABLED a nop has reintroduced this bug.
> > > 
> > > See commit e58aa3d2d0cc01ad8d6f7f640a0670433f794922
> > > 
> > > We run ALL interrupt handlers with interrupts disabled for that reason
> > > and we even check and yell when an interrupt handler returns with
> > > interrupts enabled. That's why IRQF_DISABLED became meaningless.
> > 
> > Awesome.
> > 
> > Can I politely ask that a reference to that commit and something like
> > your paragraph here explaining things is added to these IRQF_DISABLED
> > removal patches?

I should have shown more in the commit log, thus this kind of misleading
could be avoided. Sorry Dave.

> 
> That's a good idea. I'll let sed loose on the changelogs when I pick
> them up.

Thanks Thomas.

	Yong

