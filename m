From: Ed L Cashin <ecashin@uga.edu>
Date: Mon, 19 Jan 2004 21:27:13 +0000
Subject: Re: TLB miss handler code
Message-Id: <87brozd3ym.fsf@uga.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.43.0401191315430.13707-100000@gatekeeper.ececs.uc.edu>
In-Reply-To: <Pine.GSO.4.43.0401191315430.13707-100000@gatekeeper.ececs.uc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Nawab Ali <alin@ececs.uc.edu> writes:

> Hi,
> I have a Sun Ultra-10 running Debian woody. I need to modify the TLB miss
> handler code. Basically everytime there is a TLB miss, I'm trying to log
> the new PTE that is brought into the TLB.
>
> I know that SPARC machines handle TLB refills in software. Can someone
> please point me to the TLB miss handler code(which file???) in the linux
> kernel(2.4.24)??? I'm a bit lost here.
>
> Any help would be greatly appreciated.

Well, I am not sure about 2.4.24, but in 2.6.0, the do_sparc64_fault
routine in arch/sparc64/mm/fault.c is invoked during TLB miss
handling.  When it's a TLB miss you can tell by the fact that
(fault_code & FAULT_CODE_DTLB || fault_code & FAULT_CODE_ITLB).

-- 
--Ed L Cashin            |   PGP public key:
  ecashin@uga.edu        |   http://noserose.net/e/pgp/

