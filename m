From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 17 Sep 2009 23:24:37 +0000
Subject: Re: [PATCH] fix BUILD_BUG_ON() and a couple of bogus uses of it
Message-Id: <20090917162437.b1a890de.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <4A8AEBFD0200007800010580@vpn.id2.novell.com>
In-Reply-To: <4A8AEBFD0200007800010580@vpn.id2.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Tue, 18 Aug 2009 16:59:25 +0100
"Jan Beulich" <JBeulich@novell.com> wrote:

> gcc permitting variable length arrays makes the current construct
> used for BUILD_BUG_ON() useless, as that doesn't produce any diagnostic
> if the controlling expression isn't really constant. Instead, this
> patch makes it so that a bit field gets used here. Consequently, those
> uses where the condition isn't really constant now also need fixing.
> 
> Note that in the gfp.h, kmemcheck.h, and virtio_config.h cases
> MAYBE_BUILD_BUG_ON() really just serves documentation purposes - even
> if the expression is compile time constant (__builtin_constant_p()
> yields true), the array is still deemed of variable length by gcc, and
> hence the whole expression doesn't have the intended effect.

sparc64:

In file included from arch/sparc/kernel/vio.c:17:
/usr/src/devel/arch/sparc/include/asm/vio.h: In function `vio_dring_avail':
/usr/src/devel/arch/sparc/include/asm/vio.h:261: error: bit-field `<anonymous>' width not an integer constant

static inline u32 vio_dring_avail(struct vio_dring_state *dr,
				  unsigned int ring_size)
{
	BUILD_BUG_ON(!is_power_of_2(ring_size));

	return (dr->pending -
		((dr->prod - dr->cons) & (ring_size - 1)));
}

changing it to MAYBE_BUILD_BUG_ON seems to have fixed it.
