From: David Miller <davem@davemloft.net>
Date: Wed, 30 Jul 2008 22:40:17 +0000
Subject: Re: [PATCH 2.6.27-rc1] sparc64: FUTEX_OP_ANDN fix
Message-Id: <20080730.154017.10423102.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200807302214.m6UMEw7l000936@harpo.it.uu.se>
In-Reply-To: <200807302214.m6UMEw7l000936@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mikpe@it.uu.se
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Thu, 31 Jul 2008 00:14:58 +0200 (MEST)

> Correct sparc64's implementation of FUTEX_OP_ANDN to do a
> bitwise negate of the oparg parameter before applying the
> AND operation. All other archs that support FUTEX_OP_ANDN
> either negate oparg explicitly (frv, ia64, mips, sh, x86),
> or do so indirectly by using an and-not instruction (powerpc).
> Since sparc64 has and-not, I chose to use that solution.
> 
> I've not found any use of FUTEX_OP_ANDN in glibc so the
> impact of this bug is probably minor. But other user-space
> components may try to use it so it should still get fixed.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

Thanks a lot for this fix, I'll apply it!
