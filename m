From: Thomas Gleixner <tglx@linutronix.de>
Date: Sat, 16 Jun 2018 13:36:28 +0000
Subject: Re: [RFC PATCH 03/23] genirq: Introduce IRQF_DELIVER_AS_NMI
Message-Id: <alpine.DEB.2.21.1806161528040.1582@nanos.tec.linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com> <1528851463-21140-4-git-send-email-ricardo.neri-calderon@linux.intel.com> <20180613083419.GS12258@hirez.programming.kicks-ass.net> <26687332-ab8f-7f6d-909a-f0918dbfea86@arm.com>
 <alpine.DEB.2.21.1806131104570.2280@nanos.tec.linutronix.de> <c000699c-7859-74ec-7944-ec484e887f60@arm.com> <20180615021213.GC11625@voyager> <4eb34b18-11f8-7d70-46a5-f206d127b768@arm.com> <20180616003916.GA6659@voyager>
In-Reply-To: <20180616003916.GA6659@voyager>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Julien Thierry <julien.thierry@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi.kleen@intel.com>, Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>, Randy Dunlap <rdunlap@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>

On Fri, 15 Jun 2018, Ricardo Neri wrote:
> On Fri, Jun 15, 2018 at 09:01:02AM +0100, Julien Thierry wrote:
> > In my patches, I'm not sure there is much to adapt to your work as most of
> > it is arch specific (although I wont say no to another pair of eyes looking
> > at them). From what I've seen of your patches, the point where we converge
> > is that need for some code to be able to tell the irqchip "I want that
> > particular interrupt line to be treated/setup as an NMI".
> 
> Indeed, there has to be a generic way for the irqchip to announce that it
> supports configuring an interrupt as NMI... and a way to actually configuring
> it.

There has to be nothing. The irqchip infrastructure might be able to
provide certain aspects of NMI support, perhaps for initialization, but
everything else is fundamentally different and the executional parts simply
cannot use any of the irq chip functions at all.

Thanks,

	tglx
