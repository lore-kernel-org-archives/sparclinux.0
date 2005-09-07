From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 07 Sep 2005 20:36:28 +0000
Subject: Re: [gentoo-sparc] 2.6 kernel and docs
Message-Id: <20050907.133628.72333547.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050829.130957.02952920.davem@davemloft.net>
In-Reply-To: <20050829.130957.02952920.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josh Grebe <squash@gentoo.org>
Date: Wed, 07 Sep 2005 15:01:35 -0500

> Sorry it took a few days to get back on this, but I wanted to get
> some additional testing in before I came back in.

Thanks for the report Josh.

One thing you can do to make debugging easier is to make the sym53c8xx
interrupts sit on one cpu and make all the other interrupt on other
cpus.  This way if the cpu dies in the sym53c8xx interrupt handler,
it won't take out all the other devices.

You can do this using /proc/irq/???/smp_affinity on sparc64.

As an example, my Ultra60 reports in /proc/interrupts:

  0:  194764100          0  timer:dead
  4:         40   12856363  su(mouse):7ea, sym53c8xx:7e0, sym53c8xx:7e6
  5:          0    7738341  eth0:7e1
  9:         91          5  su(kbd):7e9
 15:          0          0  PSYCHO UE:7ee, PSYCHO CE:7ef, PSYCHO PCIERR:7f0, PSYCHO PCIERR:7f1

After each IRQ name is the 3-hex IRQ number.  The 'smp_affinity' value
is a bit-mask.  The cpu numbers on my machine are 0 and 2, so all
the smp_affinity values default to "00000005" enabling both cpus.

So what you'd want to do is, for example:

1) Set the smp_affinity of 7e0 and 7e6 (the two sym53c8xx driver
   irqs) to "00000001"

2) Set the smp_affinity of all other interrupts to "00000004"

In this way the serial console, network, and keyboard/framebuffer
will not die if the cpu hangs in the sym53c8xx interrupt handler
which I am certain is the root of this bug.

Once you have that setup, CONFIG_DEBUG_SPINLOCK should give meaningful
output when the system wedges.

Hope this helps.
