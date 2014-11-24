From: David Miller <davem@davemloft.net>
Date: Mon, 24 Nov 2014 22:09:33 +0000
Subject: Re: Another (ESP?) scsi blk-mq problem on sparc64
Message-Id: <20141124.170933.410328396352735176.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <547367DF.5060706@kernel.dk>
	<20141124.165623.42259031853400756.davem@davemloft.net>
	<5473AAD3.7010409@kernel.dk>
In-Reply-To: <5473AAD3.7010409@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: axboe@kernel.dk
Cc: paulmck@linux.vnet.ibm.com, hch@infradead.org, mroos@linux.ee, linux-scsi@vger.kernel.org, sparclinux@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>
Date: Mon, 24 Nov 2014 15:01:55 -0700

> I'll just updated blk-mq to use nr_cpu_ids and be done with it.

Wow, a grep on nr_cpu_ids gets a lot of hits on people allocating just
these kinds of tables :)
