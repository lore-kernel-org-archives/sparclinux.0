From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 20 Dec 2016 11:22:38 +0000
Subject: Re: [PATCH] sparc: use symbolic names for tsb indexing
Message-Id: <20161220112238.GA27972@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1482203828-22017-1-git-send-email-mike.kravetz@oracle.com>
In-Reply-To: <1482203828-22017-1-git-send-email-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>

On Mon, Dec 19, 2016 at 07:17:08PM -0800, Mike Kravetz wrote:
> Use symbolic names MM_TSB_BASE and MM_TSB_HUGE instead of numeric values
> 0 and 1 in __tsb_context_switch.  Code cleanup only, no functional change.
> 
> Suggested-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>

	Sam
