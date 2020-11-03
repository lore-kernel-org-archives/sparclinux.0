From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 03 Nov 2020 09:27:33 +0000
Subject: [patch V3 21/37] Documentation/io-mapping: Remove outdated blurb
Message-Id: <20201103095858.734064977@linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20201103092712.714480842@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-aio@kvack.org, Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Ben Segall <bsegall@google.com>, Chris Mason <clm@fb.com>, Huang Rui <ray.huang@amd.com>, Paul Mackerras <paulus@samba.org>, Gerd Hoffmann <kraxel@redhat.com>, Daniel Bristot de Oliveira <bristot@redhat.com>, sparclinux@vger.kernel.org, Vincent Chen <deanbo422@gmail.com>, Christoph Hellwig <hch@lst.de>, Vincent Guittot <vincent.guittot@linaro.org>, Paul McKenney <paulmck@kernel.org>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, linux-csky@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, David Airlie <airlied@linux.ie>, VMware Graphics <linux-graphics-maintainer@vmware.com>, Mel Gorman <mgorman@suse.de>, nouveau@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>, linux-snps-arc@lists.infradead.org, Ben Skeggs <bskeggs@redhat.com>, linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>, intel-gfx@lists.freedesktop.org, Roland Scheidegger <sroland@vmware.com>, Josef Bacik <josef@toxicpanda.com>, Steven Rostedt <rostedt@goodmis.org>, Linus Torvalds <torvalds@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, spice-devel@lists.freedesktop.org, David Sterba <dsterba@suse.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nick Hu <nickhu@andestech.com>, linux-mm@kvack.org, Vineet Gupta <vgupta@synopsys.com>, linux-mips@vger.kernel.org, Christian Koenig <christian.koenig@amd.com>, Benjamin LaHaise <bcrl@kvack.org>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>, linux-btrfs@vger.kernel.org, Greentime Hu <green.hu@gmail.com>

The implementation details in the documentation are outdated and not really
helpful. Remove them.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: New patch
---
 Documentation/driver-api/io-mapping.rst |   22 ----------------------
 1 file changed, 22 deletions(-)

--- a/Documentation/driver-api/io-mapping.rst
+++ b/Documentation/driver-api/io-mapping.rst
@@ -73,25 +73,3 @@ for pages mapped with io_mapping_map_wc.
 At driver close time, the io_mapping object must be freed::
 
 	void io_mapping_free(struct io_mapping *mapping)
-
-Current Implementation
-===========
-
-The initial implementation of these functions uses existing mapping
-mechanisms and so provides only an abstraction layer and no new
-functionality.
-
-On 64-bit processors, io_mapping_create_wc calls ioremap_wc for the whole
-range, creating a permanent kernel-visible mapping to the resource. The
-map_atomic and map functions add the requested offset to the base of the
-virtual address returned by ioremap_wc.
-
-On 32-bit processors with HIGHMEM defined, io_mapping_map_atomic_wc uses
-kmap_atomic_pfn to map the specified page in an atomic fashion;
-kmap_atomic_pfn isn't really supposed to be used with device pages, but it
-provides an efficient mapping for this usage.
-
-On 32-bit processors without HIGHMEM defined, io_mapping_map_atomic_wc and
-io_mapping_map_wc both use ioremap_wc, a terribly inefficient function which
-performs an IPI to inform all processors about the new mapping. This results
-in a significant performance penalty.
