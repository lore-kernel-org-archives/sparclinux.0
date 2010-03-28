From: David Miller <davem@davemloft.net>
Date: Sun, 28 Mar 2010 04:12:13 +0000
Subject: Re: [PATCH 7/7] arch/sparc/kernel: Use set_cpus_allowed_ptr
Message-Id: <20100327.211213.13750482.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.1003262303500.6480@ask.diku.dk>
In-Reply-To: <Pine.LNX.4.64.1003262303500.6480@ask.diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: julia@diku.dk
Cc: peterz@infradead.org, mingo@elte.hu, tglx@linutronix.de, oleg@redhat.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

From: Julia Lawall <julia@diku.dk>
Date: Fri, 26 Mar 2010 23:04:09 +0100 (CET)

> Use set_cpus_allowed_ptr rather than set_cpus_allowed.
> 
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
 ...
> Signed-off-by: Julia Lawall <julia@diku.dk>

Applied, thanks Julia.
