From: Ed L Cashin <ecashin@uga.edu>
Date: Thu, 22 Jan 2004 05:24:47 +0000
Subject: Re: TLB miss handler code
Message-Id: <877jzkk128.fsf@uga.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.43.0401191315430.13707-100000@gatekeeper.ececs.uc.edu>
In-Reply-To: <Pine.GSO.4.43.0401191315430.13707-100000@gatekeeper.ececs.uc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

...
> There are also very strict restrictions regarding register usage, you only
> have 4 or 5 global registers to use, the other 2 or 3 global registers
> have hardcoded values and furthermore if the VPTE_BASE mapping takes a TLB
> miss the miss handler for that knows what values are precomputed in global
> registers by the top-level TLB miss handler.
>
> He cannot even touch any data structures as that would cause potential
> recursive TLB misses and corrupt the current handler.
>
> In short, I would only recommend this work to a true expert in Sparc v9
> and UltraSPARC TLB programming.  I myself would take a few long days to
> implement said tracing support.

Wow.  I had a feeling it might not be so simple.  ;)

Sounds like the only hope for Nawab Ali is if there's a simulator for
the sparc environment where he wants to perform the measuring.

I don't know anything about performance counters on ultrasparc, but
even if there are some, it wouldn't be enough to log the ptes that get
loaded on TLB misses.

-- 
--Ed L Cashin            |   PGP public key:
  ecashin@uga.edu        |   http://noserose.net/e/pgp/

