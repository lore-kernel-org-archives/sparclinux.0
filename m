From: David Miller <davem@davemloft.net>
Date: Tue, 07 Jan 2014 19:11:15 +0000
Subject: Re: [PATCH] sparc: replace __GFP_NOFAIL with GFP_ATOMIC in mdesc_kmalloc()
Message-Id: <20140107.141115.513158198056746890.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1389087077-311-1-git-send-email-ethan.kernel@gmail.com>
In-Reply-To: <1389087077-311-1-git-send-email-ethan.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ethan.kernel@gmail.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Ethan Zhao <ethan.kernel@gmail.com>
Date: Tue,  7 Jan 2014 17:31:17 +0800

> Has kmalloc() failure checking there, so it is unnecessary to allocate with
> __GFP_NOFAIL flag that might block forever.
> 
> Signed-off-by: Ethan Zhao <ethan.kernel@gmail.com>

This allocation failing borders on catastrophic.  The allocation failure
handling is just for looks.

This function is triggered when the firmware tells us that new cpus or
other devices are available.  This memory being allocated will hold
the machine description that we traverse to find those new devices.

If this allocation is allowed to fail, we will never have any way to
get the notification again.  It really is __GFP_NOFAIL and must
succeed.

I'm not applying this, sorry.
