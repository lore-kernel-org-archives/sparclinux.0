From: David Miller <davem@davemloft.net>
Date: Sun, 31 Mar 2013 23:31:23 +0000
Subject: Re: [PATCH] sparc/iommu: fix typo s/265KB/256KB/
Message-Id: <20130331.193123.1462561597649302213.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1364564684-15469-2-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1364564684-15469-2-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Fri, 29 Mar 2013 22:44:44 +0900

> IOMMU_NPTES is 64K PTEs, so the size is 256KB (= 64K * sizeof(iopte_t))
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Applied.
