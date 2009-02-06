From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Fri, 06 Feb 2009 07:59:45 +0000
Subject: Re: HOLES_IN_ZONE...
Message-Id: <20090206085945.17aed03e@osiris.boeblingen.de.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20090204.222651.26527737.davem@davemloft.net>
	<20090205090016.6197d588@osiris.boeblingen.de.ibm.com>
	<20090205.154403.200370311.davem@davemloft.net>
In-Reply-To: <20090205.154403.200370311.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: mel@csn.ul.ie, kamezawa.hiroyu@jp.fujitsu.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Thu, 05 Feb 2009 15:44:03 -0800 (PST)
David Miller <davem@davemloft.net> wrote:

> > Later I reduced MAX_ORDER to 9 on s390, so we don't leave large
> > portions of memory unused.
> 
> Isn't is easier to just make sure your vmemmap mappings extend to such
> boundaries, whether they contain available memory or not?
> 
> That's the only requirement you have to satisfy to avoid having to
> specify HOLES_IN_ZONE.  You don't have to have memory there, just
> some vmmemmap page structs have to be mapped at those indices.
> 
> And then you won't need waste memory with these MAX_ORDER boundary
> adjustments.

Sounds reasonable. Back then I was under the impression that it is not
sufficient to only have a struct page but also a page for each PFN.
I'll give it a try as soon as time permits.

Thanks!
