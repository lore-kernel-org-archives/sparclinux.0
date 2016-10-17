From: Tushar Dave <tushar.n.dave@oracle.com>
Date: Mon, 17 Oct 2016 20:56:58 +0000
Subject: [PATCH 0/2] sparc/net: Fix compiler warnings
Message-Id: <1476737820-29584-1-git-send-email-tushar.n.dave@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org
Cc: chris.hyser@oracle.com, linux-kernel@vger.kernel.org

Recently, ATU (iommu) changes are submitted to sparclinux that
enables 64bit DMA on SPARC. However, this change also makes
'incompatible pointer type' compiler warnings inevitable on sunqe
and sunbmac driver.

The two patches in series fix compiler warnings.

Tushar Dave (2):
  sunqe: Fix compiler warnings
  sunbmac: Fix compiler warning

 drivers/net/ethernet/sun/sunbmac.c |  5 +++--
 drivers/net/ethernet/sun/sunbmac.h |  2 +-
 drivers/net/ethernet/sun/sunqe.c   | 11 ++++++-----
 drivers/net/ethernet/sun/sunqe.h   |  4 ++--
 4 files changed, 12 insertions(+), 10 deletions(-)

-- 
1.9.1

