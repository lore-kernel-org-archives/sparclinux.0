From: David Miller <davem@davemloft.net>
Date: Thu, 09 Apr 2009 05:37:19 +0000
Subject: [PATCH 0/12]: Sparc64 dynamic per-cpu support.
Message-Id: <20090408.223719.61587584.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tj@kernel.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


This patch set converts sparc64 over to use the dynamic per-cpu stuff.

Most of the work is the boring task of getting rid of the special
"real_setup_per_cpu_areas()" sparc64 uses to setup the per-cpu areas
before bootmem is available.  We needed to do this because we
initialized the cpu possible map at the same time as the stuff stored
in the per-cpu cpu_data array.

So we split those tasks up.  Otherwise we wouldn't be able to convert
to dynamic per-cpu because that stuff requires that bootmem and the
page structs are ready to use.

For now I'm using the draconian unoptimized x86 NUMA remap scheme.  I
really want to do this better because it is insanely suboptimal on
Niagara chips where in some cases 8 cpus share the same physical TLB.

This is against Linus's current tree and it's also in sparc-next-2.6
