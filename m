From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Thu, 14 Jun 2018 01:26:32 +0000
Subject: Re: [RFC PATCH 12/23] kernel/watchdog: Introduce a struct for NMI watchdog operations
Message-Id: <20180614012632.GB22652@voyager>
List-Id: <sparclinux.vger.kernel.org>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1528851463-21140-13-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <20180613174141.539fc6c1@roar.ozlabs.ibm.com>
 <20180613084219.GT12258@hirez.programming.kicks-ass.net>
In-Reply-To: <20180613084219.GT12258@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi.kleen@intel.com>, Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@intel.com>, Don Zickus <dzickus@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Weisbecker <frederic@kernel.org>, Babu Moger <babu.moger@oracle.com>, "David S. Miller" <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Mathieu Desnoyers <mat>

On Wed, Jun 13, 2018 at 10:42:19AM +0200, Peter Zijlstra wrote:
> On Wed, Jun 13, 2018 at 05:41:41PM +1000, Nicholas Piggin wrote:
> > On Tue, 12 Jun 2018 17:57:32 -0700
> > Ricardo Neri <ricardo.neri-calderon@linux.intel.com> wrote:
> > 
> > > Instead of exposing individual functions for the operations of the NMI
> > > watchdog, define a common interface that can be used across multiple
> > > implementations.
> > > 
> > > The struct nmi_watchdog_ops is defined for such operations. These initial
> > > definitions include the enable, disable, start, stop, and cleanup
> > > operations.
> > > 
> > > Only a single NMI watchdog can be used in the system. The operations of
> > > this NMI watchdog are accessed via the new variable nmi_wd_ops. This
> > > variable is set to point the operations of the first NMI watchdog that
> > > initializes successfully. Even though at this moment, the only available
> > > NMI watchdog is the perf-based hardlockup detector. More implementations
> > > can be added in the future.
> > 
> > Cool, this looks pretty nice at a quick glance. sparc and powerpc at
> > least have their own NMI watchdogs, it would be good to have those
> > converted as well.
> 
> Yeah, agreed, this looks like half a patch.

I planned to look into the conversion of sparc and powerpc. I just wanted
to see the reception to these patches before jumping and do potentially
useless work. Comments in this thread lean towards keep using the weak
stubs.

Thanks and BR,
Ricardo
