From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 04 Mar 2009 00:09:06 +0000
Subject: "leds: Add openfirmware platform device support" breaks sparc
Message-Id: <20090303160906.9b30b376.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Trent Piepho <tpiepho@freescale.com>, Grant Likely <grant.likely@secretlab.ca>, Sean MacLennan <smaclennan@pikatech.com>, Richard Purdie <rpurdie@linux.intel.com>
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org


linux-next's dc0f6e94d7f487c624254597a0b86ef41c525673 (which I don't
seem to be able to find on any mailing lists to which I subscribe)
breaks the sparc64 allmodconfig build:

drivers/leds/leds-gpio.c: In function `gpio_led_init':
drivers/leds/leds-gpio.c:286: error: implicit declaration of function `of_register_platform_driver'
drivers/leds/leds-gpio.c: In function `gpio_led_exit':
drivers/leds/leds-gpio.c:302: error: implicit declaration of function `of_unregister_platform_driver'

afacit that interface is powerpc-only.
