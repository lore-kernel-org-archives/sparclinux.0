From: Rusty Russell <rusty@rustcorp.com.au>
Date: Thu, 09 Feb 2006 01:29:48 +0000
Subject: Re: div, udiv, mul, umul, rem, urem broken again?!?
Message-Id: <1139448588.19399.34.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <1128550254.2140.103.camel@localhost.localdomain>
In-Reply-To: <1128550254.2140.103.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 2006-02-08 at 14:51 -0600, Tom 'spot' Callaway wrote:
> On Wed, 2006-02-08 at 20:25 +0000, Martin Habets wrote:
> > I tried to build 2.6.16-rc2 today, but got a lot of these
> > errors from depmod:
> > 
> > WARNING: /lib/modules/2.6.16-rc2-mph2/kernel/crypto/crypto_null.ko needs unknown symbol urem
> > WARNING: /lib/modules/2.6.16-rc2-mph2/kernel/crypto/crypto_null.ko needs unknown symbol umul
> > WARNING: /lib/modules/2.6.16-rc2-mph2/kernel/crypto/crc32c.ko needs unknown symbol udiv
> > WARNING: /lib/modules/2.6.16-rc2-mph2/kernel/crypto/crc32c.ko needs unknown symbol div
> > WARNING: /lib/modules/2.6.16-rc2-mph2/kernel/crypto/crc32c.ko needs unknown symbol urem
> > WARNING: /lib/modules/2.6.16-rc2-mph2/kernel/crypto/crc32c.ko needs unknown symbol umul
> > WARNING: /lib/modules/2.6.16-rc2-mph2/kernel/arch/sparc/kernel/led.ko needs unknown symbol udiv
> > WARNING: /lib/modules/2.6.16-rc2-mph2/kernel/arch/sparc/kernel/led.ko needs unknown symbol div
> > WARNING: /lib/modules/2.6.16-rc2-mph2/kernel/arch/sparc/kernel/led.ko needs unknown symbol urem
> > WARNING: /lib/modules/2.6.16-rc2-mph2/kernel/arch/sparc/kernel/led.ko needs unknown symbol umul
> > 
> > There was a long thread regarding this last october, but I did not find
> > a resolution.

(1) it's just a warning, and it doesn't actually effect anything.
(2) Someone decided to be clever in arch/sparc/kernel/sparc_ksyms.c
between 2.6.13 and 2.6.14.  Rather than mangle ".div" to "div", they
decided to mangle it to "_Div".  The problem is that depmod knows about
skipping the ".": it's done for other architectures.  It has no idea
about this new mangling.

2.6.12 did it the obvious way, 2.6.13 used asm, and 2.6.14 the new
scheme.  One wonders what was wrong with 2.6.12, but I haven't been
following closely.

Now, possibly there was a legitimate reason not to pollute the namespace
with these symbols, but they could probably have been made static
without great concern.

Hope that clarifies,
Rusty.
-- 
 ccontrol: http://ozlabs.org/~rusty/ccontrol

