From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 08 May 2006 06:05:11 +0000
Subject: Re: [PATCH] sparc: Remove duplicate symbol exports
Message-Id: <20060507.230511.09155802.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060507152349.GA3410@palantir8>
In-Reply-To: <20060507152349.GA3410@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Sun, 7 May 2006 16:23:49 +0100

> This patch resolves the following build warnings seen in 2.6.17-rc3:
> WARNING: vmlinux: 'sys_close' exported twice. Previous export was in vmlinux
> WARNING: vmlinux: 'memchr' exported twice. Previous export was in vmlinux
> WARNING: vmlinux: 'strstr' exported twice. Previous export was in vmlinux
> WARNING: vmlinux: 'strnlen' exported twice. Previous export was in vmlinux
> WARNING: vmlinux: 'strrchr' exported twice. Previous export was in vmlinux
> WARNING: vmlinux: 'strchr' exported twice. Previous export was in vmlinux
> WARNING: vmlinux: 'strcmp' exported twice. Previous export was in vmlinux
> WARNING: vmlinux: 'strncat' exported twice. Previous export was in vmlinux
> WARNING: vmlinux: 'strcat' exported twice. Previous export was in vmlinux
> WARNING: vmlinux: 'strncpy' exported twice. Previous export was in vmlinux
> WARNING: vmlinux: 'strcpy' exported twice. Previous export was in vmlinux
> 
> Please apply.
> Martin
> 
> 	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>

Applied, thanks a lot.
