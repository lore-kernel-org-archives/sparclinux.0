From: David Miller <davem@davemloft.net>
Date: Thu, 05 Feb 2009 23:44:03 +0000
Subject: Re: HOLES_IN_ZONE...
Message-Id: <20090205.154403.200370311.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090204.222651.26527737.davem@davemloft.net>
	<20090205090016.6197d588@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20090205090016.6197d588@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: heiko.carstens@de.ibm.com
Cc: mel@csn.ul.ie, kamezawa.hiroyu@jp.fujitsu.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Thu, 5 Feb 2009 09:00:16 +0100

> On Wed, 04 Feb 2009 22:26:51 -0800 (PST)
> David Miller <davem@davemloft.net> wrote:
> 
> > Later this HOLES_IN_ZONE requirement was removed on s390 by commit:
> > 
> > commit 9f4b0ba81f158df459fa2cfc98ab1475c090f29c
> > Author: Heiko Carstens <heiko.carstens@de.ibm.com>
> > Date:   Sat Jan 26 14:11:02 2008 +0100
> > 
> >     [S390] Get rid of HOLES_IN_ZONE requirement.
> 
> This just made sure that all zones start on a MAX_ORDER boundary and
> just leaves memory that doesn't fit unused. So the requirement for
> HOLES_IN_ZONE went away.
> 
> Later I reduced MAX_ORDER to 9 on s390, so we don't leave large
> portions of memory unused.

Isn't is easier to just make sure your vmemmap mappings extend to such
boundaries, whether they contain available memory or not?

That's the only requirement you have to satisfy to avoid having to
specify HOLES_IN_ZONE.  You don't have to have memory there, just
some vmmemmap page structs have to be mapped at those indices.

And then you won't need waste memory with these MAX_ORDER boundary
adjustments.

Really, I think IA64 should do this too (it's the only remaining
HOLES_IN_ZONE setting arch), then we can just delete this whole thing
completely.
