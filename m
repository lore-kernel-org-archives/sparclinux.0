From: David Miller <davem@davemloft.net>
Date: Sun, 17 May 2020 19:46:27 +0000
Subject: Re: [PATCH] oradax: convert get_user_pages() --> pin_user_pages()
Message-Id: <20200517.124627.503340627820837794.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20200517020829.856731-1-jhubbard@nvidia.com>
In-Reply-To: <20200517020829.856731-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jhubbard@nvidia.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>
Date: Sat, 16 May 2020 19:08:29 -0700

> This code was using get_user_pages_fast(), in a "Case 2" scenario
> (DMA/RDMA), using the categorization from [1]. That means that it's
> time to convert the get_user_pages_fast() + put_page() calls to
> pin_user_pages_fast() + unpin_user_pages() calls.
> 
> There is some helpful background in [2]: basically, this is a small
> part of fixing a long-standing disconnect between pinning pages, and
> file systems' use of those pages.
> 
> [1] Documentation/core-api/pin_user_pages.rst
> 
> [2] "Explicit pinning of user-space pages":
>     https://lwn.net/Articles/807108/
> 
> Cc: David S. Miller <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Applied to sparc-next, thanks.
