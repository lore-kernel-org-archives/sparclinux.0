From: "David S. Miller" <davem@redhat.com>
Date: Wed, 12 May 2004 18:32:28 +0000
Subject: Re: Another gcc 3.4 fix
Message-Id: <20040512113228.3fdbd6d6.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040512052744.GA31207@localhost>
In-Reply-To: <20040512052744.GA31207@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 12 May 2004 01:27:44 -0400
Mathieu Chouquet-Stringer <mchouque@online.fr> wrote:

> Ok, one more problem while using gcc 3.4.0. It has a "nice" feature called
> "unit-at-a-time compilation", basically files are better "optimized" than
> before (you can read more about it here:
> http://gcc.gnu.org/gcc-3.4/changes.html).

Well, what seems to be happening is that GCC believes that
kernel_unaligned_trap() is not invoked so it does not emit
the code for that function.

As a consequence, unaligned_panic() can also not be emitted since
it is only invoked from kernel_unaligned_trap().

Is gcc-3.4 emitting kernel_unaligned_trap() into the unaligned.s file?

If not, that's a bug since it is invoked, at a minimum, from
arch/sparc64/kernel/traps.c and also arch/sparc64/kernel/entry.S
