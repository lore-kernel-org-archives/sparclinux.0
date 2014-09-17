From: David Miller <davem@davemloft.net>
Date: Wed, 17 Sep 2014 00:49:43 +0000
Subject: Re: [PATCH V2] sparc64: sun4v TLB error power off events
Message-Id: <20140916.204943.1394160383600191742.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1410874007-11501-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410874007-11501-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bpicco@meloft.net>
Date: Tue, 16 Sep 2014 09:26:47 -0400

> Normally sun4v_itlb_error_report() and sun4v_dtlb_error_report() would call
> prom_halt() and drop us to OF command prompt "ok". This isn't the case for
> LDOMs and the machine powers off.
> 
> For the HV reported error of HV_ENORADDR for HV HV_MMU_MAP_ADDR_TRAP we cause
> a SIGBUS error by qualifying it within do_sparc64_fault() for fault code mask
> of FAULT_CODE_BAD_RA. This is done when trap level (%tl) is less or equal
> one("1"). Otherwise, for %tl > 1,  we proceed eventually to die_if_kernel().

This patch is great, applied, thanks Bob.

I think I'd like to request a follow-on patch to this if you don't
mind.

If %tl > 1, the only situation we can possibly be in is to be taking a
TLB miss during a window spill/fill trap, in which case we should
up-trap back up through the spill/fill handler and into the long path
fault code via winfix_trampoline.

Then you can kill all of the {i,d}tlb error code paths.

Thanks!
