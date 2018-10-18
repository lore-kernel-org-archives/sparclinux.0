From: David Miller <davem@davemloft.net>
Date: Thu, 18 Oct 2018 04:55:18 +0000
Subject: Re: [PATCH] sparc: vDSO: Silence an uninitialized variable warning
Message-Id: <20181017.215518.39092071152820324.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20181013102653.GE16086@mwanda>
In-Reply-To: <20181013102653.GE16086@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Sat, 13 Oct 2018 13:26:53 +0300

> Smatch complains that "val" would be uninitialized if kstrtoul() fails.
> 
> Fixes: 9a08862a5d2e ("vDSO for sparc")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

So much bike shedding in this thread ;-)

Applied, thanks Dan.
