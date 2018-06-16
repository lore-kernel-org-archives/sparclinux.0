From: Thomas Gleixner <tglx@linutronix.de>
Date: Sat, 16 Jun 2018 13:24:49 +0000
Subject: Re: [RFC PATCH 17/23] watchdog/hardlockup/hpet: Convert the timer's interrupt to NMI
Message-Id: <alpine.DEB.2.21.1806161517050.1582@nanos.tec.linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com> <1528851463-21140-18-git-send-email-ricardo.neri-calderon@linux.intel.com> <alpine.DEB.2.21.1806131128570.2280@nanos.tec.linutronix.de> <20180615020314.GA11625@voyager>
 <alpine.DEB.2.21.1806151029210.2079@nanos.tec.linutronix.de> <20180616005103.GC6659@voyager>
In-Reply-To: <20180616005103.GC6659@voyager>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi.kleen@intel.com>, Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Don Zickus <dzickus@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Weisbecker <frederic@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Babu Moger <babu.moger@oracle.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>

On Fri, 15 Jun 2018, Ricardo Neri wrote:
> On Fri, Jun 15, 2018 at 11:19:09AM +0200, Thomas Gleixner wrote:
> > On Thu, 14 Jun 2018, Ricardo Neri wrote:
> > > Alternatively, there could be a counter that skips reading the HPET status
> > > register (and the detection of hardlockups) for every X NMIs. This would
> > > reduce the overall frequency of HPET register reads.
> > 
> > Great plan. So if the watchdog is the only NMI (because perf is off) then
> > you delay the watchdog detection by that count.
> 
> OK. This was a bad idea. Then, is it acceptable to have an read to an HPET
> register per NMI just to check in the status register if the HPET timer
> caused the NMI?

The status register is useless in case of MSI. MSI is edge triggered ....

The only register which gives you proper information is the counter
register itself. That adds an massive overhead to each NMI, because the
counter register access is synchronized to the HPET clock with hardware
magic. Plus on larger systems, the HPET access is cross node and even
slower.

Thanks,

	tglx
