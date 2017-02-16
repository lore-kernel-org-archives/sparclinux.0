From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 16 Feb 2017 19:57:04 +0000
Subject: [PATCH] improve add_node_ranges() performance
Message-Id: <1487275558-153109-1-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This patch fixes a scalability issue where add_node_ranges() loops one
page a time through the memory to determine NUMA nodes.

Pavel Tatashin (1):
  sparc64: use latency groups to improve add_node_ranges speed

 arch/sparc/mm/init_64.c |  208 +++++++++++++++++++++++++---------------------
 1 files changed, 113 insertions(+), 95 deletions(-)

