From: David Miller <davem@davemloft.net>
Date: Wed, 17 Oct 2012 05:05:28 +0000
Subject: [GIT] Networking
Message-Id: <20121017.010528.614908812231452770.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


1) Fix regression in /proc/net/if_inet6, sometimes devices do not
   get listed.  From Eric Dumazet.

2) Add IPSEC networking sub-section to MAINTAINERS.

3) S390 networking fixes from Hendrik Brueckner and
   Stefan Raspl.

4) Fix enslavement of devices that can't do VLAN properly, from
   Jiri Pirko.

5) SCTP sack handling fix from Zijie Pan.

Please pull, thanks a lot.

The following changes since commit 29bb4cc5e0547a7589556f8629e39016c5d203c0:

  docbook: networking: fix file paths for uapi headers (2012-10-15 08:04:41 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git master

for you to fetch changes up to 9f0d3c2781baa1102108e16efbe640dd74564a7c:

  ipv6: addrconf: fix /proc/net/if_inet6 (2012-10-16 14:41:47 -0400)

----------------------------------------------------------------
David S. Miller (1):
      MAINTAINERS: Add explicit section for IPSEC networking.

Dmitry Kravkov (1):
      bnx2x: fix handling mf storage modes

Eric Dumazet (1):
      ipv6: addrconf: fix /proc/net/if_inet6

Hendrik Brueckner (1):
      smsgiucv: reestablish IUCV path after resume

Jiri Pirko (1):
      vlan: fix bond/team enslave of vlan challenged slave/port

Stefan Raspl (1):
      qeth: fix deadlock between recovery and bonding driver

Zijie Pan (1):
      sctp: fix call to SCTP_CMD_PROCESS_SACK in sctp_cmd_interpreter()

 MAINTAINERS                                     | 14 ++++++++++++++
 drivers/net/bonding/bond_main.c                 |  2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c | 10 +++++++---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c  |  2 +-
 drivers/s390/net/qeth_l2_main.c                 | 11 ++++++-----
 drivers/s390/net/qeth_l3_main.c                 | 11 ++++++-----
 drivers/s390/net/smsgiucv.c                     |  2 +-
 net/8021q/vlan_core.c                           |  9 ++++++++-
 net/ipv6/addrconf.c                             | 15 +++++++++------
 net/sctp/sm_sideeffect.c                        |  3 ++-
 10 files changed, 55 insertions(+), 24 deletions(-)
