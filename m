From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 22 May 2007 23:28:14 +0000
Subject: Re: [PATCH/RFC] Rework ptep_set_access_flags and fix sun4c
Message-Id: <1179876494.32247.887.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0705012354290.12808@mtfhpc.demon.co.uk>
	 <20070509231937.ea254c26.akpm@linux-foundation.org>
	 <1178778583.14928.210.camel@localhost.localdomain>
	 <20070510.001234.126579706.davem@davemloft.net>
	 <Pine.LNX.4.64.0705142018090.18453@blonde.wat.veritas.com>
	 <1179176845.32247.107.camel@localhost.localdomain>
	 <1179212184.32247.163.camel@localhost.localdomain>
	 <1179757647.6254.235.camel@localhost.localdomain>
	 <1179815339.32247.799.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0705222247010.5890@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0705222247010.5890@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Cc: "Tom \"spot\" Callaway" <tcallawa@redhat.com>, Hugh Dickins <hugh@veritas.com>, David Miller <davem@davemloft.net>, akpm@linux-foundation.org, linuxppc-dev@ozlabs.org, wli@holomorphy.com, linux-mm@kvack.org, andrea@suse.de, sparclinux@vger.kernel.org

On Tue, 2007-05-22 at 22:52 +0100, Mark Fortescue wrote:
> Hi Benjamin,
> 
> I have just tested this patch on my Sun4c Sparcstation 1 using my 2.6.20.9 
> test kernel without any problems.
> 
> Thank you for the work.

Wow, there is more than one user of these still ! :-)

Cheers,
Ben.


