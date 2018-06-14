From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Thu, 14 Jun 2018 01:19:01 +0000
Subject: Re: [RFC PATCH 14/23] watchdog/hardlockup: Decouple the hardlockup detector from perf
Message-Id: <20180614011901.GA22652@voyager>
List-Id: <sparclinux.vger.kernel.org>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1528851463-21140-15-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <20180613084324.GU12258@hirez.programming.kicks-ass.net>
In-Reply-To: <20180613084324.GU12258@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi.kleen@intel.com>, Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@intel.com>, Don Zickus <dzickus@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Weisbecker <frederic@kernel.org>, Babu Moger <babu.moger@oracle.com>, "David S. Miller" <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Mathieu Desnoyers <mat>

On Wed, Jun 13, 2018 at 10:43:24AM +0200, Peter Zijlstra wrote:
> On Tue, Jun 12, 2018 at 05:57:34PM -0700, Ricardo Neri wrote:
> > The current default implementation of the hardlockup detector assumes that
> > it is implemented using perf events.
> 
> The sparc and powerpc things are very much not using perf.

Isn't it true that the current hardlockup detector
(under kernel/watchdog_hld.c) is based on perf? As far as I understand,
this hardlockup detector is constructed using perf events for architectures
that don't provide an NMI watchdog. Perhaps I can be more specific and say
that this synthetized detector is based on perf.

On a side note, I saw that powerpc might use a perf-based hardlockup
detector if it has perf events [1].

Please let me know if my understanding is not correct.

Thanks and BR,
Ricardo

[1]. https://elixir.bootlin.com/linux/v4.17/source/arch/powerpc/Kconfig#L218

