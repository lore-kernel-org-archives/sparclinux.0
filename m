From: Nicholas Piggin <npiggin@gmail.com>
Date: Wed, 13 Jun 2018 07:41:41 +0000
Subject: Re: [RFC PATCH 12/23] kernel/watchdog: Introduce a struct for NMI watchdog operations
Message-Id: <20180613174141.539fc6c1@roar.ozlabs.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
        <1528851463-21140-13-git-send-email-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <1528851463-21140-13-git-send-email-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi.kleen@intel.com>, Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@intel.com>, Don Zickus <dzickus@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Weisbecker <frederic@kernel.org>, Babu Moger <babu.moger@oracle.com>, "David S. Miller" <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Masami

On Tue, 12 Jun 2018 17:57:32 -0700
Ricardo Neri <ricardo.neri-calderon@linux.intel.com> wrote:

> Instead of exposing individual functions for the operations of the NMI
> watchdog, define a common interface that can be used across multiple
> implementations.
> 
> The struct nmi_watchdog_ops is defined for such operations. These initial
> definitions include the enable, disable, start, stop, and cleanup
> operations.
> 
> Only a single NMI watchdog can be used in the system. The operations of
> this NMI watchdog are accessed via the new variable nmi_wd_ops. This
> variable is set to point the operations of the first NMI watchdog that
> initializes successfully. Even though at this moment, the only available
> NMI watchdog is the perf-based hardlockup detector. More implementations
> can be added in the future.

Cool, this looks pretty nice at a quick glance. sparc and powerpc at
least have their own NMI watchdogs, it would be good to have those
converted as well.

Is hpet a cross platform thing, or just x86? We should avoid
proliferation of files under kernel/ I think, so with these watchdog
driver structs then maybe implementations could go in drivers/ or
arch/

Thanks,
Nick
