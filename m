From: David Miller <davem@davemloft.net>
Date: Tue, 08 Mar 2011 22:00:52 +0000
Subject: Re: Status update on sparc32 genirq support
Message-Id: <20110308.140052.193716519.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110307.230120.226776255.davem@davemloft.net>
In-Reply-To: <20110307.230120.226776255.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Marcel van Nies <morcles@gmail.com>
Date: Tue, 8 Mar 2011 22:51:00 +0100

> I start thinking there is something wrong with Jakub's srmmu patch for
> hyperSPARC...

That's just the code that links up the cpu specific cache and tlb
flushing routines, it's been doing that for more than 10 years.
