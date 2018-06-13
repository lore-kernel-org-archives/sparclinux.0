From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 13 Jun 2018 09:48:09 +0000
Subject: Re: [RFC PATCH 20/23] watchdog/hardlockup/hpet: Rotate interrupt among all monitored CPUs
Message-Id: <alpine.DEB.2.21.1806131140560.2280@nanos.tec.linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com> <1528851463-21140-21-git-send-email-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <1528851463-21140-21-git-send-email-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi.kleen@intel.com>, Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Don Zickus <dzickus@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Weisbecker <frederic@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Babu Moger <babu.moger@oracle.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>

On Tue, 12 Jun 2018, Ricardo Neri wrote:
> +	/* There are no CPUs to monitor. */
> +	if (!cpumask_weight(&hdata->monitored_mask))
> +		return NMI_HANDLED;
> +
>  	inspect_for_hardlockups(regs);
>  
> +	/*
> +	 * Target a new CPU. Keep trying until we find a monitored CPU. CPUs
> +	 * are addded and removed to this mask at cpu_up() and cpu_down(),
> +	 * respectively. Thus, the interrupt should be able to be moved to
> +	 * the next monitored CPU.
> +	 */
> +	spin_lock(&hld_data->lock);

Yuck. Taking a spinlock from NMI ... 

> +	for_each_cpu_wrap(cpu, &hdata->monitored_mask, smp_processor_id() + 1) {
> +		if (!irq_set_affinity(hld_data->irq, cpumask_of(cpu)))
> +			break;

... and then calling into generic interrupt code which will take even more
locks is completely broken.

Guess what happens when the NMI hits a section where one of those locks is
held? Then you need another watchdog to decode the lockup you just ran into.

Thanks,

	tglx


