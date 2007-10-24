From: Josip Rodin <joy@entuzijast.net>
Date: Wed, 24 Oct 2007 21:11:02 +0000
Subject: arch/sparc64/kernel/iommu_common.c:237: error: implicit declaration of function 'next_sg'
Message-Id: <20071024211102.GA5842@keid.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

Just tried 2.6.24-rc1... but:

arch/sparc64/kernel/iommu_common.c: In function 'prepare_sg':
arch/sparc64/kernel/iommu_common.c:237: error: implicit declaration of function 'next_sg'
cc1: warnings being treated as errors
arch/sparc64/kernel/iommu_common.c:237: warning: assignment makes pointer from integer without a cast
make[1]: *** [arch/sparc64/kernel/iommu_common.o] Error 1

The error looks like a simple typo - should this be sg_next(), like
elsewhere in the file? It compiles the file when I replace that.

-- 
     2. That which causes joy or happiness.
