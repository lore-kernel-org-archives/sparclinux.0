From: Ingo Molnar <mingo@elte.hu>
Date: Tue, 08 Jan 2008 22:56:31 +0000
Subject: Re: Linux 2.6.24-rc7: sparc64: WARNING: at
Message-Id: <20080108225631.GA7021@elte.hu>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LFD.1.00.0801061410290.3148@woody.linux-foundation.org> <200801081942.17139.m.kozlowski@tuxland.pl> <20080108.145038.203528847.davem@davemloft.net>
In-Reply-To: <20080108.145038.203528847.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: m.kozlowski@tuxland.pl, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>


* David Miller <davem@davemloft.net> wrote:

> > WARNING: at kernel/lockdep_proc.c:267 lockdep_stats_show()
> > Call Trace:
> >  [0000000000492704] lockdep_stats_show+0x6ac/0x6c0
> >  [00000000004eb4b4] seq_read+0x5c/0x340
> >  [000000000050b2bc] proc_reg_read+0x64/0xa0
> >  [00000000004cd72c] vfs_read+0x74/0x120
> >  [00000000004cdb4c] sys_read+0x34/0x60
> >  [00000000004062d4] linux_sparc_syscall32+0x3c/0x40
> >  [0000000000012ff4] 0x12ffc
> 
> Please turn off lockdep on sparc64, currently it not reliable.  I have 
> many things to audit, including how the stack frames are presented to 
> the lockdep layer.
> 
> So any problem you run into can be due to issues like that.

is this anything the core lockdep code could help improve? Let us know 
if any aspect is hindering you.

	Ingo
