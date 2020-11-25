From: Matthew Wilcox <willy@infradead.org>
Date: Wed, 25 Nov 2020 12:46:03 +0000
Subject: Re: [PATCH 2/2] mm: Move free_unref_page to mm/internal.h
Message-Id: <20201125124603.GL4327@casper.infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20201125034655.27687-1-willy@infradead.org>
 <20201125034655.27687-2-willy@infradead.org>
 <6418f355-ae69-a0bc-3006-b89a4e1cc09c@suse.cz>
In-Reply-To: <6418f355-ae69-a0bc-3006-b89a4e1cc09c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, davem@davemloft.net, rppt@kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org

On Wed, Nov 25, 2020 at 01:34:04PM +0100, Vlastimil Babka wrote:
> On 11/25/20 4:46 AM, Matthew Wilcox (Oracle) wrote:
> > Code outside mm/ should not be calling free_unref_page().  Also
> > move free_unref_page_list().
> 
> Good idea.
> 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> There seems to be some effort to remove "extern" from function declarations
> from headers. Do we want to do that, at once, or piecemeal? If the latter,
> this is a chance for these functions at least :)

I'm generally in favour of those efforts, but since I was just moving
the function declarations, and all the code near the destination was
using 'extern', I decided not to remove it so as to avoid getting caught
up in bikeshedding ...
