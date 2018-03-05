From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Mon, 05 Mar 2018 19:35:42 +0000
Subject: Re: [PATCH v12 02/11] mm, swap: Add infrastructure for saving page metadata on swap
Message-Id: <d807ba68-decd-e195-f607-ef6962e40c96@linux.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1519227112.git.khalid.aziz@oracle.com>
 <f5316c71e645d99ffdd52963f1e9675de3fc6386.1519227112.git.khalid.aziz@oracle.com>
 <0d77dc3c-1454-a689-a0fb-f07e8973c29e@linux.intel.com>
 <4a766f6d-ba96-7963-b367-7214eab7e307@oracle.com>
In-Reply-To: <4a766f6d-ba96-7963-b367-7214eab7e307@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org, davem@davemloft.net, arnd@arndb.de
Cc: kirill.shutemov@linux.intel.com, mhocko@suse.com, ross.zwisler@linux.intel.com, dave.jiang@intel.com, mgorman@techsingularity.net, willy@infradead.org, hughd@google.com, minchan@kernel.org, hannes@cmpxchg.org, shli@fb.com, mingo@kernel.org, jglisse@redhat.com, me@tobin.cc, anthony.yznaga@oracle.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>

On 03/05/2018 11:29 AM, Khalid Aziz wrote:
> ADI data is per page data and is held in the spare bits in the RAM. It
> is loaded into the cache when data is loaded from RAM and flushed out to
> spare bits in the RAM when data is flushed from cache. Sparc allows one
> tag for each ADI block size of data and ADI block size is same as
> cacheline size.

Which does not square with your earlier assertion "ADI data is per page
data".  It's per-cacheline data.  Right?

> When a page is loaded into RAM from swap space, all of
> the associated ADI data for the page must also be loaded into the RAM,
> so it looks like page level data and storing it in page level software
> data structure makes sense. I am open to other suggestions though.

Do you have a way to tell that data is not being thrown away?  Like if
the ADI metadata is different for two different cachelines within a
single page?
