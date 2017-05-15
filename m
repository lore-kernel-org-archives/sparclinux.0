From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Mon, 15 May 2017 17:51:06 +0000
Subject: [PATCH net-next 0/2] ldmvsw: port removal stability
Message-Id: <1494870668-65047-1-git-send-email-shannon.nelson@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, netdev@vger.kernel.org
Cc: sparclinux@vger.kernel.org, Shannon Nelson <shannon.nelson@oracle.com>

Under heavy reboot stress testing we found a couple of timing issues
when removing the device that could cause the kernel great heartburn,
addressed by these two patches.

Shannon Nelson (1):
  ldmvsw: stop the clean timer at beginning of remove

Thomas Tai (1):
  ldmvsw: unregistering netdev before disable hardware

 drivers/net/ethernet/sun/ldmvsw.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

