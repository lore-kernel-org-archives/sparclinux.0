From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Tue, 14 Mar 2017 17:24:38 +0000
Subject: [PATCH v2 net-next 0/5] sunvnet: better connection management
Message-Id: <1489512283-422140-1-git-send-email-shannon.nelson@oracle.com>
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

v2:
 - added ldmvsw ndo_open to reset the LDC channel
 - updated copyrights

Shannon Nelson (5):
  ldmvsw: better use of link up and down on ldom vswitch
  sunvnet: add stats to track ldom to ldom packets and bytes
  sunvnet: track port queues correctly
  sunvnet: count multicast packets
  sunvnet: xoff not needed when removing port link

 drivers/net/ethernet/sun/ldmvsw.c         |   27 ++++++-
 drivers/net/ethernet/sun/sunvnet.c        |  116 ++++++++++++++++++++++++++++-
 drivers/net/ethernet/sun/sunvnet_common.c |   56 +++++++++++---
 drivers/net/ethernet/sun/sunvnet_common.h |   27 +++++--
 4 files changed, 201 insertions(+), 25 deletions(-)
