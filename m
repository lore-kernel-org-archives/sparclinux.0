From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Fri, 15 Jun 2018 02:23:09 +0000
Subject: Re: [RFC PATCH 14/23] watchdog/hardlockup: Decouple the hardlockup detector from perf
Message-Id: <20180615022309.GF11625@voyager>
List-Id: <sparclinux.vger.kernel.org>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1528851463-21140-15-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <20180613084324.GU12258@hirez.programming.kicks-ass.net>
 <20180614011901.GA22652@voyager>
 <20180614114144.05891a04@roar.ozlabs.ibm.com>
In-Reply-To: <20180614114144.05891a04@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi.kleen@intel.com>, Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@intel.com>, Don Zickus <dzickus@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Weisbecker <frederic@kernel.org>, Babu Moger <babu.moger@oracle.com>, "David S. Miller" <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>

On Thu, Jun 14, 2018 at 11:41:44AM +1000, Nicholas Piggin wrote:
> On Wed, 13 Jun 2018 18:19:01 -0700
> Ricardo Neri <ricardo.neri-calderon@linux.intel.com> wrote:
> 
> > On Wed, Jun 13, 2018 at 10:43:24AM +0200, Peter Zijlstra wrote:
> > > On Tue, Jun 12, 2018 at 05:57:34PM -0700, Ricardo Neri wrote:  
> > > > The current default implementation of the hardlockup detector assumes that
> > > > it is implemented using perf events.  
> > > 
> > > The sparc and powerpc things are very much not using perf.  
> > 
> > Isn't it true that the current hardlockup detector
> > (under kernel/watchdog_hld.c) is based on perf?
> 
> arch/powerpc/kernel/watchdog.c is a powerpc implementation that uses
> the kernel/watchdog_hld.c framework.
> 
> > As far as I understand,
> > this hardlockup detector is constructed using perf events for architectures
> > that don't provide an NMI watchdog. Perhaps I can be more specific and say
> > that this synthetized detector is based on perf.
> 
> The perf detector is like that, but we want NMI watchdogs to share
> the watchdog_hld code as much as possible even for arch specific NMI
> watchdogs, so that kernel and user interfaces and behaviour are
> consistent.
> 
> Other arch watchdogs like sparc are a little older so they are not
> using HLD. You don't have to change those for your series, but it
> would be good to bring them into the fold if possible at some time.
> IIRC sparc was slightly non-trivial because it has some differences
> in sysctl or cmdline APIs that we don't want to break.
> 
> But powerpc at least needs to be updated if you change hld apis.

I will look into updating at least the powerpc implementation as part
of these changes.

Thanks and BR,
Ricardo
