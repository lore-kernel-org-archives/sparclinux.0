From: David Miller <davem@davemloft.net>
Date: Mon, 26 Jun 2017 02:01:36 +0000
Subject: Re: [sparc-next] sparc64: fix typo in property
Message-Id: <20170625.220136.667497229539345270.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1498433226-557786-1-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1498433226-557786-1-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Sun, 25 Jun 2017 19:27:06 -0400

> There is a typo in a comment that propagated into code:
> upa-portis instead of upa-portid
> 
> This problem was detected by code inspection.
> 
> Fixes: eea9833453bd ("sparc64: broken %tick frequency on spitfire cpus"
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> Reported-by: Steven Sistare <steven.sistare@oracle.com>
> Reviewed-by: Steven Sistare <steven.sistare@oracle.com>

Applied to sparc-next, thanks a lot!
