From: David Miller <davem@davemloft.net>
Date: Sun, 25 Jun 2017 19:24:34 +0000
Subject: Re: [PATCH v2] sparc64: Fix gup_huge_pmd
Message-Id: <20170625.152434.163343347007478148.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1498176950-233141-1-git-send-email-nitin.m.gupta@oracle.com>
In-Reply-To: <1498176950-233141-1-git-send-email-nitin.m.gupta@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: nitin.m.gupta@oracle.com
Cc: julian.calaby@gmail.com, lstoakes@gmail.com, jack@suse.cz, mhocko@suse.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Thu, 22 Jun 2017 17:15:08 -0700

> The function assumes that each PMD points to head of a
> huge page. This is not correct as a PMD can point to
> start of any 8M region with a, say 256M, hugepage. The
> fix ensures that it points to the correct head of any PMD
> huge page.
> 
> Cc: Julian Calaby <julian.calaby@gmail.com>
> Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
> ---
>  Changes since v1
>  - Clarify use of 'head' variable (Julian Calaby)

Applied and queued up for -stable, thanks.
