From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 30 Mar 2011 10:04:49 +0000
Subject: Re: [patch 0/4] sparc: Final irq bits for .39
Message-Id: <alpine.LFD.2.00.1103301204030.22418@localhost6.localdomain6>
List-Id: <sparclinux.vger.kernel.org>
References: <20110325140808.738196492@linutronix.de>
In-Reply-To: <20110325140808.738196492@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 30 Mar 2011, David Miller wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Fri, 25 Mar 2011 14:10:44 -0000
> 
> > David,
> > 
> > the following series 
> > 
> >     - makes use of the new core functions
> >     - cleans up open coded irq_desc access
> >     - converts to new function names
> >     - switches to the generic show_interrupts()
> 
> These appear to all be merged already, so nothing for me to do :-)

Right. I hope it's not unfixable broken. My supply of sparc64 test
machines is roughly zero.

Thanks,

	tglx

