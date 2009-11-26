From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 26 Nov 2009 05:27:46 +0000
Subject: Re: [PATCH 04/11] of/flattree: eliminate cell_t typedef
Message-Id: <1259213266.16367.274.camel@pasglop>
List-Id: <sparclinux.vger.kernel.org>
References: <20091124081316.6216.66310.stgit@angua>
	<20091124081827.6216.1896.stgit@angua>
	<1259207974.16367.226.camel@pasglop>
	<fa686aa40911252005o2db85dfk3d9acc61c12ca5e5@mail.gmail.com>
In-Reply-To: <fa686aa40911252005o2db85dfk3d9acc61c12ca5e5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely@secretlab.ca>
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

On Wed, 2009-11-25 at 21:05 -0700, Grant Likely wrote:
> 
> You're right, it's not, but makes merging less complex, and then I can
> refactor properly. 

Still, make them __be32 at least

Cheers,
Ben.

