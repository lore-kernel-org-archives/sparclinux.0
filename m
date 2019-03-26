From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 26 Mar 2019 21:22:40 +0000
Subject: Re: [RFC PATCH v2 10/14] kernel/watchdog: Add a function to obtain the watchdog_allowed_mask
Message-Id: <alpine.DEB.2.21.1903262221140.1789@nanos.tec.linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1551283518-18922-11-git-send-email-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <1551283518-18922-11-git-send-email-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, Kai-Heng Feng <kai.heng.feng@canonical.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Christoffer Dall <cdall@linaro.org>, Davidlohr Bueso <dave@stgolabs.net>, Ashok Raj <ashok.raj@intel.com>, x86@kernel.org, David Rientjes <rientjes@google.com>, Andi Kleen <andi.kleen@intel.com>, Waiman Long <longman@redhat.com>, Borislav Petkov <bp@suse.de>, Don Zickus <dzickus@redhat.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Marc Zyngier <marc.zyngier@arm.com>, Frederic Weisbecker <frederic@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Ricardo Neri <ricardo.neri@intel.com>, Byungchul Park <byungchul.park@lge.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Tony Luck <tony.luck@intel.com>, Babu Moger <babu.moger@oracle.com>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Philippe Ombredanne <pombredanne@nexb.com>, Colin Ian King <colin.king@canonical.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

On Wed, 27 Feb 2019, Ricardo Neri wrote:
>  
> -struct cpumask watchdog_allowed_mask __read_mostly;
> +static struct cpumask watchdog_allowed_mask __read_mostly;

That hunk is correct.

>  struct cpumask watchdog_cpumask __read_mostly;
>  unsigned long *watchdog_cpumask_bits = cpumask_bits(&watchdog_cpumask);
> @@ -92,6 +92,11 @@ static int __init hardlockup_all_cpu_backtrace_setup(char *str)
>  }
>  __setup("hardlockup_all_cpu_backtrace=", hardlockup_all_cpu_backtrace_setup);
>  # endif /* CONFIG_SMP */
> +
> +struct cpumask *watchdog_get_allowed_cpumask(void)
> +{
> +	return &watchdog_allowed_mask;
> +}

That part is pointless as I showed you in the other reply. You don't need
that mask in your code at all.

Thanks,

	tglx
