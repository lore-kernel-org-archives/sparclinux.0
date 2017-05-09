From: David Miller <davem@davemloft.net>
Date: Tue, 09 May 2017 19:16:41 +0000
Subject: Re: [PATCH] sparc: use memdup_user_nul in sun4m LED driver
Message-Id: <20170509.151641.1419805204909413899.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <6baf3aa45d0b5e0fd016b508bac905ebf8443aac.1493779294.git.geliangtang@gmail.com>
        <870186e3b1d678cc96c902c26032ef9ce89c337c.1493783414.git.geliangtang@gmail.com>
In-Reply-To: <870186e3b1d678cc96c902c26032ef9ce89c337c.1493783414.git.geliangtang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: geliangtang@gmail.com
Cc: mingo@kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Geliang Tang <geliangtang@gmail.com>
Date: Sat,  6 May 2017 23:40:20 +0800

> Use memdup_user_nul() helper instead of open-coding to simplify the code.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>

Applied.
