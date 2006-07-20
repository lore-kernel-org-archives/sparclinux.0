From: David Miller <davem@davemloft.net>
Date: Thu, 20 Jul 2006 03:51:38 +0000
Subject: Re: sparc32: git SCSI and fs
Message-Id: <20060719.205138.75431090.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060719.134205.74563314.davem@davemloft.net>
In-Reply-To: <20060719.134205.74563314.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Raymond Burns <rayburns@comcast.net>
Date: Wed, 19 Jul 2006 20:44:14 -0700 (PDT)

> Then should zs_probe not be calling request_irq() when it sets
> zilog_irq to op->irqs[0]

That's the bug, good spotting.  Just remove that call
in zs_probe().

