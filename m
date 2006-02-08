From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Wed, 08 Feb 2006 20:25:31 +0000
Subject: div, udiv, mul, umul, rem, urem broken again?!?
Message-Id: <20060208202531.GA16118@palantir8>
List-Id: <sparclinux.vger.kernel.org>
References: <1128550254.2140.103.camel@localhost.localdomain>
In-Reply-To: <1128550254.2140.103.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I tried to build 2.6.16-rc2 today, but got a lot of these
errors from depmod:

WARNING: /lib/modules/2.6.16-rc2-mph2/kernel/crypto/crypto_null.ko needs unknown symbol urem
WARNING: /lib/modules/2.6.16-rc2-mph2/kernel/crypto/crypto_null.ko needs unknown symbol umul
WARNING: /lib/modules/2.6.16-rc2-mph2/kernel/crypto/crc32c.ko needs unknown symbol udiv
WARNING: /lib/modules/2.6.16-rc2-mph2/kernel/crypto/crc32c.ko needs unknown symbol div
WARNING: /lib/modules/2.6.16-rc2-mph2/kernel/crypto/crc32c.ko needs unknown symbol urem
WARNING: /lib/modules/2.6.16-rc2-mph2/kernel/crypto/crc32c.ko needs unknown symbol umul
WARNING: /lib/modules/2.6.16-rc2-mph2/kernel/arch/sparc/kernel/led.ko needs unknown symbol udiv
WARNING: /lib/modules/2.6.16-rc2-mph2/kernel/arch/sparc/kernel/led.ko needs unknown symbol div
WARNING: /lib/modules/2.6.16-rc2-mph2/kernel/arch/sparc/kernel/led.ko needs unknown symbol urem
WARNING: /lib/modules/2.6.16-rc2-mph2/kernel/arch/sparc/kernel/led.ko needs unknown symbol umul

There was a long thread regarding this last october, but I did not find
a resolution.

My module-init-tools are version 3.2-pre1-2 (Debian).

Any tips/hints?
-- 
Martin
---------------------------------------------------------------------------
30 years from now GNU/Linux will be as redundant a term as MERT/UNIX is 
today. - Martin Habets
---------------------------------------------------------------------------
