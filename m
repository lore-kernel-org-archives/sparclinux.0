From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 10 Dec 2009 22:21:47 +0000
Subject: Re: [PATCH 09/11] of: merge of_attach_node() & of_detach_node()
Message-Id: <fa686aa40912101421h4eabfeaat7925d89ebfe2c5a0@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20091124081316.6216.66310.stgit@angua> <20091124081931.6216.27102.stgit@angua>
	<1259208468.16367.234.camel@pasglop>
In-Reply-To: <1259208468.16367.234.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au, sfr@canb.auug.org.au, davem@davemloft.net, monstr@monstr.eu

On Wed, Nov 25, 2009 at 9:07 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2009-11-24 at 01:19 -0700, Grant Likely wrote:
>> Merge common code between PowerPC and Microblaze
>
> Some of those guys might wnat to be in of_dynamic (see previous email)
>
> Remember: We want to keep the footprint low for embedded archs that
> don't want to do dynamic stuff. Really low.

I agree.  If it is okay by you I'll update this in a subsequent patch.
 Once the code is merge, then I'm going to do a bunch of refactoring
patches.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
