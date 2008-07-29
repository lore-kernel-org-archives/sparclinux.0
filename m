From: Alexander Beregalov <a.beregalov@gmail.com>
Date: Tue, 29 Jul 2008 17:54:18 +0000
Subject: sparc64 build failure at iommu.c
Message-Id: <20080729175418.GA32295@orion>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Hi

It is double declaration.
Kernel version is 2.6.27-rc1

In file included from arch/sparc64/kernel/iommu.c:21:
arch/sparc64/kernel/iommu_common.h:40: error: static declaration of
'iommu_num_pages' follows non-static declaration
include/linux/iommu-helper.h:11: error: previous declaration of
'iommu_num_pages' was here
