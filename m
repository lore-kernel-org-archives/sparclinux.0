From: David Miller <davem@davemloft.net>
Date: Mon, 29 Mar 2010 19:56:49 +0000
Subject: Re: [BUG] fault while using perf callchains in sparc64
Message-Id: <20100329.125649.228306906.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100328043446.GA11748@nowhere>
In-Reply-To: <20100328043446.GA11748@nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fweisbec@gmail.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Sun, 28 Mar 2010 06:34:49 +0200

> It triggers with a simple:
> 
> 	perf record -a -f -g sleep 1

I can reproduce, thanks for the report, I fix this now.
