From: Jonathan Corbet <corbet@lwn.net>
Date: Fri, 10 Jul 2015 16:11:18 +0000
Subject: Re: [PATCH V3 3/5] mm: mlock: Introduce VM_LOCKONFAULT and add mlock flags to enable it
Message-Id: <20150710101118.5d04d627@lwn.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1436288623-13007-1-git-send-email-emunson@akamai.com>
	<1436288623-13007-4-git-send-email-emunson@akamai.com>
	<20150708132351.61c13db6@lwn.net>
	<20150708203456.GC4669@akamai.com>
	<20150708151750.75e65859@lwn.net>
	<20150709184635.GE4669@akamai.com>
In-Reply-To: <20150709184635.GE4669@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eric B Munson <emunson@akamai.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.cz>, Vlastimil Babka <vbabka@suse.cz>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org

On Thu, 9 Jul 2015 14:46:35 -0400
Eric B Munson <emunson@akamai.com> wrote:

> > One other question...if I call mlock2(MLOCK_ONFAULT) on a range that
> > already has resident pages, I believe that those pages will not be locked
> > until they are reclaimed and faulted back in again, right?  I suspect that
> > could be surprising to users.  
> 
> That is the case.  I am looking into what it would take to find only the
> present pages in a range and lock them, if that is the behavior that is
> preferred I can include it in the updated series.

For whatever my $0.02 is worth, I think that should be done.  Otherwise
the mlock2() interface is essentially nondeterministic; you'll never
really know if a specific page is locked or not.

Thanks,

jon
