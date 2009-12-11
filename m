From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 11 Dec 2009 06:43:47 +0000
Subject: Re: [PATCH 04/11] of/flattree: eliminate cell_t typedef
Message-Id: <fa686aa40912102243x7f64c5aay13a84b3cde58a5b9@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20091124081316.6216.66310.stgit@angua> <20091124081827.6216.1896.stgit@angua>
	<1259207974.16367.226.camel@pasglop> <fa686aa40911252005o2db85dfk3d9acc61c12ca5e5@mail.gmail.com>
	<1259213266.16367.274.camel@pasglop>
In-Reply-To: <1259213266.16367.274.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au, sfr@canb.auug.org.au, davem@davemloft.net, monstr@monstr.eu

On Wed, Nov 25, 2009 at 10:27 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2009-11-25 at 21:05 -0700, Grant Likely wrote:
>>
>> You're right, it's not, but makes merging less complex, and then I can
>> refactor properly.
>
> Still, make them __be32 at least

Okay.  Done.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
