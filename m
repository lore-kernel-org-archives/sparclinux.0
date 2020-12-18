From: Kjetil Oftedal <oftedal@gmail.com>
Date: Fri, 18 Dec 2020 22:28:08 +0000
Subject: Re: [RFC PATCH 0/13] sparc32: sunset sun4m and sun4d
Message-Id: <CALMQjD-M4MN+zcZ0t4P5hvtjbd57azmNRmsj9jvwyHFquY84Vw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20201218184347.2180772-1-sam@ravnborg.org>
In-Reply-To: <20201218184347.2180772-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: David S Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Anshuman Khandual <anshuman.khandual@arm.com>, Arvind Sankar <nivedita@alum.mit.edu>, Christian Brauner <christian.brauner@ubuntu.com>, Denis Efremov <efremov@linux.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ira Weiny <ira.weiny@intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@kernel.org>, Pekka Enberg <penberg@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org, debian-sparc@lists.debian.org

On 18/12/2020, Sam Ravnborg <sam@ravnborg.org> wrote:
> The sun4m and sun4d based SPARC machines was very popular in the
> 90'ties and was then replaced by the more powerful sparc64
> class of machines.
> Today there is only Gentoo that to my best knowledge supports
> sparc32 and people have moved on to more capable HW.
>
> Cobham Gaisler have variants of the LEON processer that
> runs sparc32 - and they are in production today.
>
> With this patchset I propose to sunset sun4m and sun4d and move
> focus to a more streamlined support for LEON.
>
> One downside is that qemu supports sun4m - and we may loose
> some testing possibilities when sun4m is dropped. qemu supports
> LEON to some degree - I have not yet tried it out.
>
> Andreas from Gaisler have indicated that they may be more active
> upstream on sparc32 - and this will only be easier with a kernel
> where the legacy stuff is dropped.
>

This makes me a bit sad. But I guess I haven't had any time to put
into the sparc32 port
for many years, so I guess it is time to let go.

But I do believe that by doing this we should make sure we are not
putting ourselves
in a position where the sparc kernel-developers don't have access to
any real sparc32
hardware.

SUN machines were at least plentiful. The LEON-family of processors
being targeted
towards the rad-hardened market are not so much available.

Maybe Gaisler can contribute some systems, or make some available remotely?

Best regards,
Kjetil Oftedal
