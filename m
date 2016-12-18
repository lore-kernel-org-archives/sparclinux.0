From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Sun, 18 Dec 2016 23:33:59 +0000
Subject: Re: [RFC PATCH 02/14] sparc64: add new fields to mmu context for shared context support
Message-Id: <b1c84633-7b4a-98d3-fd60-bcaf64574e4d@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1481913337-9331-1-git-send-email-mike.kravetz@oracle.com>
 <1481913337-9331-3-git-send-email-mike.kravetz@oracle.com>
 <20161217073406.GA23567@ravnborg.org>
In-Reply-To: <20161217073406.GA23567@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Bob Picco <bob.picco@oracle.com>, Nitin Gupta <nitin.m.gupta@oracle.com>, Vijay Kumar <vijay.ac.kumar@oracle.com>, Julian Calaby <julian.calaby@gmail.com>, Adam Buchbinder <adam.buchbinder@gmail.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>

On 12/16/2016 11:34 PM, Sam Ravnborg wrote:
> Hi Mike.
> 
> On Fri, Dec 16, 2016 at 10:35:25AM -0800, Mike Kravetz wrote:
>> Add new fields to the mm_context structure to support shared context.
>> Instead of a simple context ID, add a pointer to a structure with a
>> reference count.  This is needed as multiple tasks will share the
>> context ID.
> 
> What are the benefits with the shared_mmu_ctx struct?
> It does not save any space in mm_context_t, and the CPU only
> supports one extra context.
> So it looks like over-engineering with all the extra administration
> required to handle it with refcount, poitners etc.
> 
> what do I miss?

Multiple tasks will share this same context ID.  The first task to need
a new shared context will allocate the structure, increment the ref count
and point to it.  As other tasks join the sharing, they will increment
the ref count and point to the same structure.  Similarly, when tasks
no longer use the shared context ID, they will decrement the reference
count.

The reference count is important so that we will know when the last
reference to the shared context ID is dropped.  When the last reference
is dropped, then the ID can be recycled/given back to the global pool
of context IDs.

This seemed to be the most straight forward way to implement this.
-- 
Mike Kravetz
