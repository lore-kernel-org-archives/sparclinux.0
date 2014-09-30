From: David Miller <davem@davemloft.net>
Date: Tue, 30 Sep 2014 21:41:07 +0000
Subject: Re: [PATCH] sparc64: Add vio_set_intr() to enable/disable Rx interrupts
Message-Id: <20140930.174107.374924487328791862.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140923153744.GB11042@oracle.com>
In-Reply-To: <20140923153744.GB11042@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Tue, 23 Sep 2014 11:37:44 -0400

> The vio_set_intr() API should be used by VIO consumers to enable/disable
> Rx interrupts to facilitate deferred processing in softirq/bottom-half
> context.
> 
> Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>

Applied, thanks.
