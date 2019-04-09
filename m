From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Tue, 09 Apr 2019 02:05:16 +0000
Subject: Re: [RFC PATCH v2 08/14] watchdog/hardlockup: Decouple the hardlockup detector from perf
Message-Id: <20190409020516.GA7165@ranerica-svr.sc.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1551283518-18922-9-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <alpine.DEB.2.21.1903262213470.1789@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1903262213470.1789@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Ricardo Neri <ricardo.neri@intel.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Ashok Raj <ashok.raj@intel.com>, x86@kernel.org, Andi Kleen <andi.kleen@intel.com>, Borislav Petkov <bp@suse.de>, Don Zickus <dzickus@redhat.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Frederic Weisbecker <frederic@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Tony Luck <tony.luck@intel.com>, Babu Moger <babu.moger@oracle.com>, linux-kernel@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Philippe Ombredanne <pombredanne@nexb.com>, Colin Ian King <colin.king@canonical.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

On Tue, Mar 26, 2019 at 10:18:32PM +0100, Thomas Gleixner wrote:
> On Wed, 27 Feb 2019, Ricardo Neri wrote:
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Detect hard lockups on a system
> > + *
> > + * Copyright (C) Intel Corporation 2019
> > + *
> > + * Note: All of this code comes from the original perf-specific hardlockup
> > + * detector.
> 
> And because you copied it from there without modification this becomes
> automatically Copyrighted by Intel?

Yes, it does not look correct.

> 
> May I recommend that you talk to your legal departement about this.
> 
> Aside of that there is really no value in creating yet another file. The
> code in question can simply wrapped into a large #ifdef PERF in the old
> file.

Sure, I'll implement the change in this manner.

Thanks and BR,
Ricardo
