From: Russell King - ARM Linux <linux@armlinux.org.uk>
Date: Tue, 30 Oct 2018 12:31:03 +0000
Subject: Re: [PATCH 0/7] serial: Finish kgdb on qcom_geni; fix many lockdep splats w/ kgdb
Message-Id: <20181030123103.GL30658@n2100.armlinux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20181029180707.207546-1-dianders@chromium.org>
 <20181030115628.eqtyqdugkpkxvyr2@holly.lan>
In-Reply-To: <20181030115628.eqtyqdugkpkxvyr2@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Douglas Anderson <dianders@chromium.org>, Jason Wessel <jason.wessel@windriver.com>, tglx@linutronix.de, mingo@kernel.org, gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, nm@ti.com, linux-mips@linux-mips.org, dalias@libc.org, catalin.marinas@arm.com, vigneshr@ti.com, linux-aspeed@lists.ozlabs.org, linux-sh@vger.kernel.org, peterz@infradead.org, will.deacon@arm.com, mhocko@suse.com, paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org, marex@denx.de, sfr@canb.auug.org.au, ysato@users.sourceforge.jp, linux-hexagon@vger.kernel.org, x86@kernel.org, pombredanne@nexb.com, tony@atomide.com, mingo@redhat.com, joel@jms.id.au, linux-serial@vger.kernel.org, rolf.evers.fischer@aptiv.com, jhogan@kernel.org, asierra@xes-inc.

On Tue, Oct 30, 2018 at 11:56:28AM +0000, Daniel Thompson wrote:
> On Mon, Oct 29, 2018 at 11:07:00AM -0700, Douglas Anderson wrote:
> > Looking back, this is pretty much two series squashed that could be
> > treated indepdently.  The first is a serial series and the second is a
> > kgdb series.
> 
> Indeed.
> 
> I couldn't work out the link between the first 5 patches and the last 2
> until I read this...
> 
> Is anything in the 01->05 patch set even related to kgdb? From the stack
> traces it looks to me like the lock dep warning would trigger for any
> sysrq. I think separating into two threads for v2 would be sensible.

I'm concerned about calling smp_call_function() from IRQ context with
IRQs disabled - that will block the ability of the _calling_ CPU to
process IPIs from other CPUs in the system.  If we have other CPUs
waiting on their IPIs to complete on _this_ CPU, we could end up
deadlocking while trying to grab the CSD lock.

This is the intention of warnings in smp_call_function*() - to catch
cases where deadlocks _can_ occur, but do not reliably show up.

The exceptions to the warning (disregarding oops_in_progress) are
chosen to allow IRQs-disabled calls when we're sure that the rest of
the system isn't going to be sending the calling CPU an IPI (eg,
because the CPU isn't marked online, and we only send IPIs to online
CPUs, or if we're still early in the kernel boot and hence have no
other CPUs running.)  The exception is oops_in_progress, which can
occur at any time - even with the current CPU already holding some
CSD locks (eg, oops while trying to send an IPI.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
