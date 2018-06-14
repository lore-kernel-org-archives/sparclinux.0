From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 14 Jun 2018 08:32:00 +0000
Subject: Re: [RFC PATCH 12/23] kernel/watchdog: Introduce a struct for NMI watchdog operations
Message-Id: <alpine.DEB.2.21.1806141029070.1581@nanos.tec.linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com> <1528851463-21140-13-git-send-email-ricardo.neri-calderon@linux.intel.com> <20180613174141.539fc6c1@roar.ozlabs.ibm.com> <20180613084219.GT12258@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1806131121180.2280@nanos.tec.linutronix.de> <20180613215225.2a938abc@roar.ozlabs.ibm.com> <20180614013117.GC22652@voyager> <20180614123250.230667f6@roar.ozlabs.ibm.com>
In-Reply-To: <20180614123250.230667f6@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi.kleen@intel.com>, Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@intel.com>, Don Zickus <dzickus@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Weisbecker <frederic@kernel.org>, Babu Moger <babu.moger@oracle.com>, "David S. Miller" <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Math

On Thu, 14 Jun 2018, Nicholas Piggin wrote:
> On Wed, 13 Jun 2018 18:31:17 -0700
> > I could look into creating the library for
> > common code and relocate the hpet watchdog into arch/x86 for the hpet-
> > specific parts.
> 
> If you can investigate that approach, that would be appreciated. I hope
> I did not misunderstand you there, Thomas.

I'm not against cleanups and consolidation, quite the contrary.

But this stuff just adds new infrastructure w/o showing that it's actually
a cleanup and consolidation.

Thanks,

	tglx
