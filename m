From: Arnd Bergmann <arnd@kernel.org>
Date: Tue, 03 Nov 2020 12:25:27 +0000
Subject: Re: [patch V3 05/37] asm-generic: Provide kmap_size.h
Message-Id: <CAK8P3a3q1O=vTLHpjkufNhspj+OJFn0BkMD6XaPZvN_0D+=FFQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20201103092712.714480842@linutronix.de>
 <20201103095857.078043987@linutronix.de>
In-Reply-To: <20201103095857.078043987@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-aio <linux-aio@kvack.org>, Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, Ben Segall <bsegall@google.com>, Chris Mason <clm@fb.com>, Huang Rui <ray.huang@amd.com>, Paul Mackerras <paulus@samba.org>, Gerd Hoffmann <kraxel@redhat.com>, Daniel Bristot de Oliveira <bristot@redhat.com>, sparclinux <sparclinux@vger.kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Vincent Chen <deanbo422@gmail.com>, Christoph Hellwig <hch@lst.de>, Vincent Guittot <vincent.guittot@linaro.org>, Paul McKenney <paulmck@kernel.org>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, the arch/x86 maintainers <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, linux-csky@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, David Airlie <airlied@linux.ie>, VMware Graphics <linux-graphics-maintainer@vmware.com>, Mel Gorman <mgorman@suse.de>, ML nouveau <nouveau@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>, "open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>, Ben Skeggs <bskeggs@redhat.com>, linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>, Intel Graphics <intel-gfx@lists.freedesktop.org>, Roland Scheidegger <sroland@vmware.com>, Josef Bacik <josef@toxicpanda.com>, Steven Rostedt <rostedt@goodmis.org>, Linus Torvalds <torvalds@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, spice-devel@lists.freedesktop.org, David Sterba <dsterba@suse.com>, virtualization@lists.linux-foundation.org, Dietmar Eggemann <dietmar.eggemann@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nick Hu <nickhu@andestech.com>, Linux-MM <linux-mm@kvack.org>, Vineet Gupta <vgupta@synopsys.com>, LKML <linux-kernel@vger.kernel.org>, Christian Koenig <christian.koenig@amd.com>, Benjamin LaHaise <bcrl@kvack.org>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "David S. Miller" <davem@davemloft.net>, linux-btrfs <linux-btrfs@vger.kernel.org>, Greentime Hu <green.hu@gmail.com>

On Tue, Nov 3, 2020 at 10:27 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> kmap_types.h is a misnomer because the old atomic MAP based array does not
> exist anymore and the whole indirection of architectures including
> kmap_types.h is inconinstent and does not allow to provide guard page
> debugging for this misfeature.
>
> Add a common header file which defines the mapping stack size for all
> architectures. Will be used when converting architectures over to a
> generic kmap_local/atomic implementation.
>
> The array size is chosen with the following constraints in mind:
>
>     - The deepest nest level in one context is 3 according to code
>       inspection.
>
>     - The worst case nesting for the upcoming reemptible version would be:
>
>       2 maps in task context and a fault inside
>       2 maps in the fault handler
>       3 maps in softirq
>       2 maps in interrupt
>
> So a total of 16 is sufficient and probably overestimated.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>
