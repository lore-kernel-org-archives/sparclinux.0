From: David Miller <davem@davemloft.net>
Date: Wed, 14 Apr 2010 23:08:57 +0000
Subject: Re: [PATCH 7/7] sparc64: Add function graph tracer support.
Message-Id: <20100414.160857.98667312.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100412.234300.212396783.davem@davemloft.net>
In-Reply-To: <20100412.234300.212396783.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Wed, 14 Apr 2010 17:48:04 +0200

> Ok, I've applied the two patches and it fixes the problems
> partially.
> 
> The crashes happen less likely as run into a manual
> loop of
> 
> 	echo function_graph > current_tracer
> 	echo nop > current_tracer
> 
> But after some trials:

Thanks for testing, I still get weird crashes too during stress tests.

At this point I think either we're still getting stack overflow due to
deep call chains, or something that is supposed to be NMI safe
actually isn't :-)

Validating the stack overflow theory is pretty simple so I'll do some
tests tonight to check that out.
