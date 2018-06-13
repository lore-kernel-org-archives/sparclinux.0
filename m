From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 13 Jun 2018 09:57:21 +0000
Subject: Re: [RFC PATCH 03/23] genirq: Introduce IRQF_DELIVER_AS_NMI
Message-Id: <alpine.DEB.2.21.1806131149410.2280@nanos.tec.linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com> <1528851463-21140-4-git-send-email-ricardo.neri-calderon@linux.intel.com> <20180613083419.GS12258@hirez.programming.kicks-ass.net> <26687332-ab8f-7f6d-909a-f0918dbfea86@arm.com>
 <alpine.DEB.2.21.1806131104570.2280@nanos.tec.linutronix.de> <344b838e-81e3-97d8-f90d-315fed7879c1@arm.com>
In-Reply-To: <344b838e-81e3-97d8-f90d-315fed7879c1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julien Thierry <julien.thierry@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi.kleen@intel.com>, Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>, Randy Dunlap <rdunlap@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Bartosz Golaszewski <brg>

On Wed, 13 Jun 2018, Julien Thierry wrote:
> On 13/06/18 10:20, Thomas Gleixner wrote:
> > Adding NMI delivery support at low level architecture irq chip level is
> > perfectly fine, but the exposure of that needs to be restricted very
> > much. Adding it to the generic interrupt control interfaces is not going to
> > happen. That's doomed to begin with and a complete abuse of the interface
> > as the handler can not ever be used for that.
> > 
> 
> Understood, however the need would be to provide a way for a driver to request
> an interrupt to be delivered as an NMI (if irqchip supports it).

s/driver/specialized code written by people who know what they are doing/

> But from your response this would be out of the question (in the
> interrupt/irq/irqchip definitions).

Adding some magic to the irq chip is fine, because that's where the low
level integration needs to be done, but exposing it through the generic
interrupt subsystem is a NONO for obvious reasons.

> Or somehow the concerned irqchip informs the arch it supports NMI delivery and
> it is up to the interested drivers to query the arch whether NMI delivery is
> supported by the system?

Yes, we need some infrastructure for that, but that needs to be separate
and with very limited exposure.

Thanks,

	tglx


