From: David Miller <davem@davemloft.net>
Date: Wed, 17 May 2017 19:08:56 +0000
Subject: Re: [PATCH] sparc64: Fix mapping of 64k pages with MAP_FIXED
Message-Id: <20170517.150856.2126069972913896228.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1494890909-247009-1-git-send-email-nitin.m.gupta@oracle.com>
In-Reply-To: <1494890909-247009-1-git-send-email-nitin.m.gupta@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: nitin.m.gupta@oracle.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Mon, 15 May 2017 16:28:17 -0700

> An incorrect huge page alignment check caused
> mmap failure for 64K pages when MAP_FIXED is used
> with address not aligned to HPAGE_SIZE.
> 
> Orabug: 25885991
> 
> Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>

Applied, but I had to add an appropriate "Fixes: " line, please
do this in the future, like so on the line right before the
first signoff or ack:

Fixes: dcd1912d21a0 ("sparc64: Add 64K page size support")

Thanks.
