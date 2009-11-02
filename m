From: David Miller <davem@davemloft.net>
Date: Mon, 02 Nov 2009 12:24:21 +0000
Subject: Leon patches...
Message-Id: <20091102.042421.72817389.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Konrad, I've just done a review of the two pending Leon patches.
Sorry for taking so long.

The SMP patch looks fine, I've applied it to sparc-next-2.6 and am
doing some build validation tests before pushing it out to kernel.org

The AMBA device patch needs a little bit of work.

I think you should create a CONFIG_AMBA in drivera/ambapp/Kconfig
that protects everything.  CONFIG_AMBA should "depends on SPARC_LEON"

Then drivers/Makefile should only traverse down into ambapp/
if CONFIG_AMBA is set, just as we do for other bus layers such
as PCI.

Fix that up and I'll try to add the Amba patch into sparc-next-2.6
too, thanks!

Thanks.
