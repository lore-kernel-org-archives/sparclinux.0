From: "David S. Miller" <davem@redhat.com>
Date: Thu, 22 Jan 2004 02:16:07 +0000
Subject: Re: TLB miss handler code
Message-Id: <20040121181607.25f623b4.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.43.0401191315430.13707-100000@gatekeeper.ececs.uc.edu>
In-Reply-To: <Pine.GSO.4.43.0401191315430.13707-100000@gatekeeper.ececs.uc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 21 Jan 2004 21:15:58 -0500
Ed L Cashin <ecashin@uga.edu> wrote:

> Is it just that simple?  Nawab Ali could, e.g., copy a section "S" of
> the trap handler code to a different part of the kernel and replace S
> with a jump to the new location.  It would be a lot slower, I
> suppose. 
> 
> Then, with S in the regular kernel, he could add whatever he wanted,
> including jumps to C functions that he writes himself.  That way he
> could write his own stuff in C with minimal modifications to the asm.

There are also very strict restrictions regarding register usage, you only
have 4 or 5 global registers to use, the other 2 or 3 global registers
have hardcoded values and furthermore if the VPTE_BASE mapping takes a TLB
miss the miss handler for that knows what values are precomputed in global
registers by the top-level TLB miss handler.

He cannot even touch any data structures as that would cause potential
recursive TLB misses and corrupt the current handler.

In short, I would only recommend this work to a true expert in Sparc v9
and UltraSPARC TLB programming.  I myself would take a few long days to
implement said tracing support.
