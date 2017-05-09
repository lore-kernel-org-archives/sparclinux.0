From: David Miller <davem@davemloft.net>
Date: Tue, 09 May 2017 19:16:53 +0000
Subject: Re: [PATCH] sparc64: fix fault handling in NGbzero.S and GENbzero.S
Message-Id: <20170509.151653.1672202276615313262.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1494320255-406137-1-git-send-email-david.j.aldridge@oracle.com>
In-Reply-To: <1494320255-406137-1-git-send-email-david.j.aldridge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dave Aldridge <david.j.aldridge@oracle.com>
Date: Tue,  9 May 2017 02:57:35 -0600

> When any of the functions contained in NGbzero.S and GENbzero.S
> vector through *bzero_from_clear_user, we may end up taking a
> fault when executing one of the store alternate address space
> instructions. If this happens, the exception handler does not
> restore the %asi register.
> 
> This commit fixes the issue by introducing a new exception
> handler that ensures the %asi register is restored when
> a fault is handled.
> 
> Orabug: 25577560
> 
> Signed-off-by: Dave Aldridge <david.j.aldridge@oracle.com>
> Reviewed-by: Rob Gardner <rob.gardner@oracle.com>
> Reviewed-by: Babu Moger <babu.moger@oracle.com>

Applied and queued up for -stable, thanks Dave.
