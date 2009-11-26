From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 26 Nov 2009 04:03:23 +0000
Subject: Re: [PATCH 02/11] of/flattree: Merge earlyinit_dt_scan_root()
Message-Id: <fa686aa40911252003i7534599egae235e1d115c7213@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20091124081316.6216.66310.stgit@angua> <20091124081800.6216.27311.stgit@angua>
	<1259207655.16367.220.camel@pasglop>
In-Reply-To: <1259207655.16367.220.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au, sfr@canb.auug.org.au, davem@davemloft.net, monstr@monstr.eu

On Wed, Nov 25, 2009 at 8:54 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2009-11-24 at 01:18 -0700, Grant Likely wrote:
>> Merge common code between PowerPC and Microblaze
>>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>> ---
>
> Ok with that, like the precendent, however you are making global some
> symbols that were previously static which sucks a bit... But then they
> can be made static again I suppose once more has been merged.

exactly.  My plan is: 1) merge.  2) refactor (and make things static
again)  3) port to ARM  4) ????  5) profit.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
