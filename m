From: David Miller <davem@davemloft.net>
Date: Tue, 24 Nov 2009 22:21:14 +0000
Subject: [PATCH 0/7]: 480R et al. bug fixes...
Message-Id: <20091124.142114.147421816.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


The following 7 patches fix the most obvious bootup and console
problems on 480R and related systems.

The most important fix is the VMEMMAP_SIZE macro error.  It's
easy to backport to older kernels, the macro definition might
live in a different place but the correction is the same.

The rest is the necessary infrastructure and logic changes to
recognize and use the RSC and LOM consoles properly on sparc64
systems.
