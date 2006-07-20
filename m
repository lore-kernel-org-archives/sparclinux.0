From: Raymond Burns <rayburns@comcast.net>
Date: Thu, 20 Jul 2006 03:44:14 +0000
Subject: Re: sparc32: git SCSI and fs
Message-Id: <Pine.LNX.4.10.10607192023350.10727-100000@coalcreekmill.cm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20060719.134205.74563314.davem@davemloft.net>
In-Reply-To: <20060719.134205.74563314.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 19 Jul 2006, David Miller wrote:

> From: Raymond Burns <rayburns@comcast.net>
> Date: Wed, 19 Jul 2006 19:50:18 -0700 (PDT)
> 
> The zilog_irq starts out with the value -1.  If we probe any zilog
> devices it will be set to the IRQ of that device, and therefore it
> will be something other than -1 if we have an IRQ handler to register.

Then should zs_probe not be calling request_irq() when it sets
zilog_irq to op->irqs[0]

currently zsprobe calls request_irq() when static_irq is 1 allocating 
static_irqaction[1] to the irq zilog_irq.

sunzilog_init() then calls request_irq() a second time assigning the
same irq with the next static_irq, static_irqaction[2]


Thanx
  Ray


