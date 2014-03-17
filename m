From: David Miller <davem@davemloft.net>
Date: Mon, 17 Mar 2014 19:56:06 +0000
Subject: Re: [PATCH 1/1] sparc64:tsb.c:use array size macro rather than number
Message-Id: <20140317.155606.2293125630270390078.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1394189943-6012-1-git-send-email-doug.lkml@gmail.com>
In-Reply-To: <1394189943-6012-1-git-send-email-doug.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: doug.lkml@gmail.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Doug <doug.lkml@gmail.com>
Date: Fri,  7 Mar 2014 16:29:03 +0530

> From: Doug Wilson <doug.lkml@gmail.com>
> 
>     This is a small patch which uses ARRAY_SIZE macro
>     rather than a number to make code readability better.
> 
> Signed-off-by: Doug Wilson <doug.lkml@gmail.com>

Applied, thanks Doug.
