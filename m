From: Ingo Molnar <mingo@elte.hu>
Date: Wed, 09 Jan 2008 00:52:23 +0000
Subject: Re: Linux 2.6.24-rc7: sparc64: WARNING: at
Message-Id: <20080109005223.GA20392@elte.hu>
List-Id: <sparclinux.vger.kernel.org>
References: <200801081942.17139.m.kozlowski@tuxland.pl> <20080108.145038.203528847.davem@davemloft.net> <20080108225631.GA7021@elte.hu> <20080108.150609.43522839.davem@davemloft.net>
In-Reply-To: <20080108.150609.43522839.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: m.kozlowski@tuxland.pl, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, a.p.zijlstra@chello.nl


* David Miller <davem@davemloft.net> wrote:

> From: Ingo Molnar <mingo@elte.hu>
> Date: Tue, 8 Jan 2008 23:56:31 +0100
> 
> > is this anything the core lockdep code could help improve? Let us know 
> > if any aspect is hindering you.
> 
> No, it's a sparc64 issue.
> 
> Another problem I ran into are the huge static table sizes lockdep 
> uses.  They really need to be either made smaller or dynamically 
> allocated.

Andi has submitted patches for that.

> Sparc64 has hard limitations on kernel size (due to firmware and 
> bootloader issues) and I hit these limits if I am not careful on SMP 
> with lockdep enabled.
> 
> Andi Kleen and I discussed in a thread several weeks ago. I believe 
> Andi even came up with a suggested direction to fix this.

yeah, i'll pick them up, probably tomorrow.

	Ingo
