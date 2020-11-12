From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 12 Nov 2020 11:03:20 +0000
Subject: Re: [patch V3 10/37] ARM: highmem: Switch to generic kmap atomic
Message-Id: <87v9ean8g7.fsf@nanos.tec.linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20201103092712.714480842@linutronix.de>
 <20201103095857.582196476@linutronix.de>
 <CGME20201112081036eucas1p14e135a370d3bccab311727fd2e89f4df@eucas1p1.samsung.com>
 <c07bae0c-68dd-2693-948f-00e8a50f3053@samsung.com>
In-Reply-To: <c07bae0c-68dd-2693-948f-00e8a50f3053@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marek Szyprowski <m.szyprowski@samsung.com>, LKML <linux-kernel@vger.kernel.org>
Cc: linux-aio@kvack.org, Peter Zijlstra <peterz@infradead.org>, nouveau@lists.freedesktop.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Huang Rui <ray.huang@amd.com>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Paul McKenney <paulmck@kernel.org>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, linux-csky@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Mel Gorman <mgorman@suse.de>, Dave Airlie <airlied@redhat.com>, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Steven Rostedt <rostedt@goodmis.org>, Linus Torvalds <torvalds@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, spice-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, Christian Koenig <christian.koenig@amd.com>, linux-btrfs@vger.kernel.org

Marek,

On Thu, Nov 12 2020 at 09:10, Marek Szyprowski wrote:
> On 03.11.2020 10:27, Thomas Gleixner wrote:
>
> I can do more tests to help fixing this issue. Just let me know what to do.

Just sent out the fix before I saw your report.

     https://lore.kernel.org/r/87y2j6n8mj.fsf@nanos.tec.linutronix.de

Thanks,

        tglx
