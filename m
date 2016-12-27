From: David Miller <davem@davemloft.net>
Date: Tue, 27 Dec 2016 18:57:29 +0000
Subject: Re: [PATCH] sparc: use symbolic names for tsb indexing
Message-Id: <20161227.135729.9020901706870265.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1482203828-22017-1-git-send-email-mike.kravetz@oracle.com>
In-Reply-To: <1482203828-22017-1-git-send-email-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mike.kravetz@oracle.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, sam@ravnborg.org

From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Mon, 19 Dec 2016 19:17:08 -0800

> Use symbolic names MM_TSB_BASE and MM_TSB_HUGE instead of numeric values
> 0 and 1 in __tsb_context_switch.  Code cleanup only, no functional change.
> 
> Suggested-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Applied.
