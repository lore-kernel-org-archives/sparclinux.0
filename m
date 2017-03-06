From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Mon, 06 Mar 2017 23:15:27 +0000
Subject: [PATCH net-next 0/5] sunvnet: better connection management
Message-Id: <1488842132-512058-1-git-send-email-shannon.nelson@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org, davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Shannon Nelson <shannon.nelson@oracle.com>

These patches remove some problems in handling of carrier state
with the ldmvsw vswitch, remove  an xoff misuse in sunvnet, and
add stats for debug and tracking of point-to-point connections
between the ldom VMs.

Shannon Nelson (5):
  ldmvsw: better use of link up and down on ldom vswitch
  sunvnet: add stats to track ldom to ldom packets and bytes
  sunvnet: track port queues correctly
  sunvnet: count multicast packets
  sunvnet: xoff not needed when removing port link

 drivers/net/ethernet/sun/ldmvsw.c         |   10 ++-
 drivers/net/ethernet/sun/sunvnet.c        |  114 +++++++++++++++++++++++++++++
 drivers/net/ethernet/sun/sunvnet_common.c |   50 +++++++++++--
 drivers/net/ethernet/sun/sunvnet_common.h |   26 ++++--
 4 files changed, 180 insertions(+), 20 deletions(-)

