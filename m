From: Christoph Hellwig <hch@infradead.org>
Date: Thu, 10 Sep 2020 05:51:12 +0000
Subject: Re: [PATCH v4 3/4] mm/pageblock: work around multiple arch's cmpxchg support issue
Message-Id: <20200910055112.GA11727@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1599116482-7410-1-git-send-email-alex.shi@linux.alibaba.com>
 <1599116482-7410-3-git-send-email-alex.shi@linux.alibaba.com>
In-Reply-To: <1599116482-7410-3-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alex Shi <alex.shi@linux.alibaba.com>
Cc: linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, David Hildenbrand <david@redhat.com>, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, Anshuman Khandual <anshuman.khandual@arm.com>, Russell King <linux@armlinux.org.uk>, Alexander Duyck <alexander.duyck@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Max Filippov <jcmvbkbc@gmail.com>, Matthew Wilcox <willy@infradead.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, sparclinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Vlastimil Babka <vbabka@suse.cz>

On Thu, Sep 03, 2020 at 03:01:22PM +0800, Alex Shi wrote:
> Armv6, sh2, sparc32 and xtensa can not do cmpxchg1, so we have to use
> cmpxchg4 on it.
> 
> Here we mark above 4 arch's NO_CMPXCHG_BYTE, and would add more if we
> found.
> 
> This is the first usages of cmpxchg flase sharing change. We'd better
> check more cmpxchg usages in current kernel...

I think a positive symbol, e.g. HAVE_CMPXCHG_BYTE is a lot easier to
understand, and also fool-proof.
