From: David Miller <davem@davemloft.net>
Date: Wed, 24 Oct 2012 19:57:09 +0000
Subject: Re: [PATCH v2] sparc: Add sparc support for platform_get_irq()
Message-Id: <20121024.155709.1708953943310978462.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1350546164-8017-1-git-send-email-andreas@gaisler.com>
In-Reply-To: <1350546164-8017-1-git-send-email-andreas@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 24 Oct 2012 21:37:43 +0200

> First off - seeing a SPARC ifdef in base/drivers make me think
> that something is wrong. And there is not even a comment why SPARC is so
> special.

The problem is that, on sparc, we store the IRQs in the device
archdata area.  Whereas other platforms do this in a different
way, mostly via IORESOURCE_IRQ in the platform device.
