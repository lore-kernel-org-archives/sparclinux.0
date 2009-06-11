From: Konrad Eisele <konrad@gaisler.com>
Date: Thu, 11 Jun 2009 07:50:51 +0000
Subject: Re: [PATCH 7/7] sparc-leon specific SRMMU initialization and
Message-Id: <4A30B75B.8040004@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4A2E45EE.40007@gaisler.com>
In-Reply-To: <4A2E45EE.40007@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> As for leon_kernel.c and leon_mm.c, they shouldn't be compiled unless
> CONFIG_LEON is set, exactly as you have it now.
> 
> As for this code, the cleanest option I see is to make leon_init() and
> leon_flush_cache_all() no-ops (or empty macros) when CONFIG_LEON isn't
> set. My rationale for this is simple: support for HyperSPARC CPUs adds
> some "dead" code on my MicroSPARC / SuperSPARC machines, and yet it
> cannot be compiled out, so why should LEON CPUs be treated any
> differently?
> 
> As for things like new hardware or new bus types, they add little
> bulk, so I see no reason to cut them out when CONFIG_LEON isn't set. -
> and for all we know, AMBA bus may become the emerging standard for
> open source SPARC systems, not just LEON.
> 
> Thanks for understanding =)
> 

Ok, then I'll do a is_leon approach and include the ambapp bus too, removing
the ifdef. I'll wait for some more comments before I'll post yet enother
round of patches, maybe next week.
-- Konrad

