From: Thomas Gleixner <tglx@linutronix.de>
Date: Sun, 08 Nov 2009 20:16:47 +0000
Subject: Re: [patch] sparc: Remove bogus of_set_property_mutex
Message-Id: <alpine.LFD.2.00.0911082115250.2725@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <20091107184538.543684450@linutronix.de>
In-Reply-To: <20091107184538.543684450@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 7 Nov 2009, David Miller wrote:

> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Sat, 07 Nov 2009 18:58:13 -0000
> 
> > of_set_property_mutex is taken inside the devtree_lock write locked
> > region which triggers the might_sleep check. The mutex protects the
> > call to prom_setprop() which is not necessary as the code is the only
> > caller of prom_setprop() and already serialized by devtree_lock. The
> > mutex is nowhere else used despite being exported. So it can be
> > removed safely.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Please see commit 2481d76615d5e15340ccfb0243fe8779766dfc6e to see why
> this mutex really is necessary, regardless of the locking done by the
> caller(s) of of_set_property().  And how it will thus need to be used
> in the future.
> 
> The long and short of it is that the firmware uses I2C accesses to
> write the property values on some systems, and therefore the sparc64
> I2C bus drivers will need this mutex to coordinate with callers of
> prom_set_property().  Those I2C drivers aren't merged yet, but I
> definitely plan to get them in soon :-)

Then you need to fix the problem that you lock the mutex inside the
preempt disabled region under devtree_lock. :)

Thanks,

	tglx

