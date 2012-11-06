From: David Miller <davem@davemloft.net>
Date: Tue, 06 Nov 2012 23:40:58 +0000
Subject: Re: SPARC and OF_GPIO
Message-Id: <20121106.184058.636480855516538607.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20121105095315.GG5847@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20121105095315.GG5847@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: thierry.reding@avionic-design.de
Cc: sparclinux@vger.kernel.org, linus.walleij@linaro.org, grant.likely@secretlab.ca, linux-kernel@vger.kernel.org

From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Mon, 5 Nov 2012 10:53:15 +0100

> Are you aware of any reasons why this conflict would still be necessary?

No reason that I can see, I'll push something like the patch below
via the sparc tree.

> This is not only the case for OF_GPIO but likely also for OF_SPI,
> OF_I2C, OF_IRQ and OF_ADDRESS. Shouldn't those all work even on SPARC
> nowadays?

Those also would need to be tested on an individual basis, but
there are no fundamental problems that I am aware of.

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index b6b442b..f0a5391 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -14,6 +14,7 @@ config SPARC
 	default y
 	select OF
 	select OF_PROMTREE
+	select OF_GPIO
 	select HAVE_IDE
 	select HAVE_OPROFILE
 	select HAVE_ARCH_KGDB if !SMP || SPARC64
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index d055cee..f11d8e3 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -47,7 +47,7 @@ if GPIOLIB
 
 config OF_GPIO
 	def_bool y
-	depends on OF && !SPARC
+	depends on OF
 
 config DEBUG_GPIO
 	bool "Debug GPIO calls"
