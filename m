From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 09 Apr 2019 11:34:21 +0000
Subject: Re: [RFC PATCH v2 10/14] kernel/watchdog: Add a function to obtain the watchdog_allowed_mask
Message-Id: <20190409113421.GU4038@hirez.programming.kicks-ass.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1551283518-18922-11-git-send-email-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <1551283518-18922-11-git-send-email-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alexei Starovoitov <ast@kernel.org>, Kai-Heng Feng <kai.heng.feng@canonical.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Christoffer Dall <cdall@linaro.org>, Davidlohr Bueso <dave@stgolabs.net>, Ashok Raj <ashok.raj@intel.com>, x86@kernel.org, David Rientjes <rientjes@google.com>, Andi Kleen <andi.kleen@intel.com>, Waiman Long <longman@redhat.com>, Borislav Petkov <bp@suse.de>, Don Zickus <dzickus@redhat.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Marc Zyngier <marc.zyngier@arm.com>, Frederic Weisbecker <frederic@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Ricardo Neri <ricardo.neri@intel.com>, Byungchul Park <byungchul.park@lge.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>, Babu Moger <babu.moger@oracle.com>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Philippe Ombredanne <pombredanne@nexb.com>, Colin Ian King <colin.king@canonical.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

On Wed, Feb 27, 2019 at 08:05:14AM -0800, Ricardo Neri wrote:
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index 8fbfda94a67b..367aa81294ef 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -44,7 +44,7 @@ int __read_mostly soft_watchdog_user_enabled = 1;
>  int __read_mostly watchdog_thresh = 10;
>  int __read_mostly nmi_watchdog_available;
>  
> -struct cpumask watchdog_allowed_mask __read_mostly;
> +static struct cpumask watchdog_allowed_mask __read_mostly;
>  
>  struct cpumask watchdog_cpumask __read_mostly;
>  unsigned long *watchdog_cpumask_bits = cpumask_bits(&watchdog_cpumask);

Hurmph, more struct cpumask, ideally this would get converted to
cpumask_var_t, I don't think we need this before the allocators work, do
we?
