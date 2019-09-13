From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Date: Fri, 13 Sep 2019 18:27:13 +0000
Subject: Re: [RFC PATCH v2 00/12] Unify SMP stop generic logic to common code
Message-Id: <20190913182713.GB13294@shell.armlinux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20190913181953.45748-1-cristian.marussi@arm.com>
In-Reply-To: <20190913181953.45748-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mark.rutland@arm.com, peterz@infradead.org, catalin.marinas@arm.com, takahiro.akashi@linaro.org, james.morse@arm.com, hidehiro.kawai.ez@hitachi.com, tglx@linutronix.de, will@kernel.org, dave.martin@arm.com, linux-arm-kernel@lists.infradead.org, mingo@redhat.com, x86@kernel.org, dzickus@redhat.com, ehabkost@redhat.com, davem@davemloft.net, sparclinux@vger.kernel.org, hch@infradead.org

On Fri, Sep 13, 2019 at 07:19:41PM +0100, Cristian Marussi wrote:
> Tested as follows:
> 
> - arm:
> 1. boot

So this basically means the code paths you're touching are untested on
ARM... given that, and the variety of systems we have out there, why
should the patches touching ARM be taken?

Given that you're an ARM Ltd employee, I'm sure you can find 32-bit
systems to test - or have ARM Ltd got rid of everything that isn't
64-bit? ;)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
