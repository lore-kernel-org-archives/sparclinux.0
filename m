From: David Miller <davem@davemloft.net>
Date: Tue, 18 Apr 2017 20:11:50 +0000
Subject: Re: [PATCH] sparc64: Fix hugepage page table free
Message-Id: <20170418.161150.1222209826603615097.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1492469211-228826-1-git-send-email-nitin.m.gupta@oracle.com>
In-Reply-To: <1492469211-228826-1-git-send-email-nitin.m.gupta@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: nitin.m.gupta@oracle.com
Cc: mike.kravetz@oracle.com, mingo@kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Mon, 17 Apr 2017 15:46:41 -0700

> Make sure the start adderess is aligned to PMD_SIZE
> boundary when freeing page table backing a hugepage
> region. The issue was causing segfaults when a region
> backed by 64K pages was unmapped since such a region
> is in general not PMD_SIZE aligned.
> 
> Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>

Applied, thank you.
