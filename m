From: Hugh Dickins <hughd@google.com>
Date: Tue, 03 Mar 2020 06:34:00 +0000
Subject: Re: [RFC 3/3] mm/vma: Introduce some more VMA flag wrappers
Message-Id: <alpine.LSU.2.11.2003022212090.1344@eggly.anvils>
List-Id: <sparclinux.vger.kernel.org>
References: <1583131666-15531-1-git-send-email-anshuman.khandual@arm.com> <1583131666-15531-4-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1583131666-15531-4-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, "David S. Miller" <davem@davemloft.net>, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Hugh Dickins <hughd@google.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org

On Mon, 2 Mar 2020, Anshuman Khandual wrote:

> This adds the following new VMA flag wrappers which will replace current
> open encodings across various places. This should not have any functional
> implications.
> 
> vma_is_dontdump()
> vma_is_noreserve()
> vma_is_special()
> vma_is_locked()
> vma_is_mergeable()
> vma_is_softdirty()
> vma_is_thp()
> vma_is_nothp()

Why?? Please don't. I am not at all keen on your 1/3 and 2/3 (some
of us actually like to see what the VM_ flags are where they're used,
without having to chase through scattered wrappers hiding them),
but this 3/3 particularly upset me.

There is a good reason for the (hideously named) is_vm_hugetlb_page(vma):
to save "#ifdef CONFIG_HUGETLB_PAGE"s all over (though I suspect the
same could have been achieved much more nicely by #define VM_HUGETLB 0);
but hiding all flags in vma_is_whatever()s is counter-productive churn.

Improved readability? Not to my eyes.

Hugh
