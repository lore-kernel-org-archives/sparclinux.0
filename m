From: David Miller <davem@davemloft.net>
Date: Thu, 14 Aug 2014 02:55:58 +0000
Subject: Re: [PATCH v14 3/8] sparc: add pmd_[dirty|mkclean] for THP
Message-Id: <20140813.195558.2039710996129294402.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1407981212-17818-1-git-send-email-minchan@kernel.org>
	<1407981212-17818-4-git-send-email-minchan@kernel.org>
In-Reply-To: <1407981212-17818-4-git-send-email-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: minchan@kernel.org
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, mtk.manpages@gmail.com, linux-api@vger.kernel.org, hughd@google.com, hannes@cmpxchg.org, riel@redhat.com, kosaki.motohiro@jp.fujitsu.com, mgorman@suse.de, je@fb.com, zhangyanfei@cn.fujitsu.com, kirill@shutemov.name, sparclinux@vger.kernel.org

From: Minchan Kim <minchan@kernel.org>
Date: Thu, 14 Aug 2014 10:53:27 +0900

> MADV_FREE needs pmd_dirty and pmd_mkclean for detecting recent
> overwrite of the contents since MADV_FREE syscall is called for
> THP page.
> 
> This patch adds pmd_dirty and pmd_mkclean for THP page MADV_FREE
> support.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Minchan Kim <minchan@kernel.org>

Acked-by: David S. Miller <davem@davemloft.net>
