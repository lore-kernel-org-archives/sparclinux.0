From: David Miller <davem@davemloft.net>
Date: Sat, 23 May 2009 00:21:31 +0000
Subject: Re: [PATCH v2] sparc64: fix and optimize irq distribution
Message-Id: <20090522.172131.193715983.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1242233551-3369-1-git-send-email-hong.pham@windriver.com>
In-Reply-To: <1242233551-3369-1-git-send-email-hong.pham@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Hong H. Pham" <hong.pham@windriver.com>
Date: Fri, 22 May 2009 17:55:16 -0400

> As a side note, here's a dump of cpu_data() on a 2 way T5440.
> There's a hole between 48 and 71.
> 
> [714162.134215] Brought up 96 CPUs

Of course there is, you only have 96 out of 128 cpus enabled so there
will be holes wherever the cores have been disabled.
