From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Tue, 10 Mar 2020 20:26:09 +0000
Subject: Re: [RFC 3/3] mm/vma: Introduce some more VMA flag wrappers
Message-Id: <20200310202609.GA6287@avx2>
List-Id: <sparclinux.vger.kernel.org>
References: <1583131666-15531-1-git-send-email-anshuman.khandual@arm.com>
 <1583131666-15531-4-git-send-email-anshuman.khandual@arm.com>
 <alpine.LSU.2.11.2003022212090.1344@eggly.anvils>
 <ce7dd2ac-26e8-d83c-46d0-0c61609be417@arm.com>
In-Reply-To: <ce7dd2ac-26e8-d83c-46d0-0c61609be417@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Hugh Dickins <hughd@google.com>, linux-mm@kvack.org, "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org

On Tue, Mar 03, 2020 at 02:43:21PM +0530, Anshuman Khandual wrote:
> On 03/03/2020 12:04 PM, Hugh Dickins wrote:
> > On Mon, 2 Mar 2020, Anshuman Khandual wrote:

> >> vma_is_dontdump()
> >> vma_is_noreserve()
> >> vma_is_special()
> >> vma_is_locked()
> >> vma_is_mergeable()
> >> vma_is_softdirty()
> >> vma_is_thp()
> >> vma_is_nothp()

> > Improved readability? Not to my eyes.
> 
> As mentioned before, I dont feel strongly about patch 3/3 and will drop.

Should be "const struct vm_area_struct *" anyway.
