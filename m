From: David Miller <davem@davemloft.net>
Date: Fri, 10 Sep 2010 04:08:24 +0000
Subject: Re: bugs compiling 2.6.35.4
Message-Id: <20100909.210824.15251132.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201009092029.52510.dennis@ausil.us>
In-Reply-To: <201009092029.52510.dennis@ausil.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dennis Gilmore <dennis@ausil.us>
Date: Thu, 9 Sep 2010 22:56:29 -0500

> for now ive turned it off however the first issue still exists.

Ok, I need to add a CRYPTO_DES dependency on the N2 crypto
driver.

I'll send the following patch to the crypto maintainer, thanks.

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index ea0b386..ad1cd59 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -172,6 +172,7 @@ config CRYPTO_DEV_MV_CESA
 
 config CRYPTO_DEV_NIAGARA2
        tristate "Niagara2 Stream Processing Unit driver"
+       select CRYPTO_DES
        select CRYPTO_ALGAPI
        depends on SPARC64
        help
