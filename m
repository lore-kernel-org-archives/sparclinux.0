From: David Miller <davem@davemloft.net>
Date: Thu, 20 Jul 2006 02:46:10 +0000
Subject: Re: sparc32: git SCSI and fs
Message-Id: <20060719.194610.119243235.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060719.134205.74563314.davem@davemloft.net>
In-Reply-To: <20060719.134205.74563314.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Raymond Burns <rayburns@comcast.net>
Date: Wed, 19 Jul 2006 19:50:18 -0700 (PDT)

> there is one improper call to request_irq() in sunzilog_init() where
> it looks for zilog_irq != -1, it should be equal -1 to request

I think you have the understanding reversed.

The zilog_irq starts out with the value -1.  If we probe any zilog
devices it will be set to the IRQ of that device, and therefore it
will be something other than -1 if we have an IRQ handler to register.
