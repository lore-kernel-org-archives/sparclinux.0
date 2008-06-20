From: David Miller <davem@davemloft.net>
Date: Fri, 20 Jun 2008 03:26:35 +0000
Subject: [GIT]: ESP scsi driver.
Message-Id: <20080619.202635.89650161.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James.Bottomley@HansenPartnership.com
Cc: linux-scsi@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


James, please pull to get these ESP scsi driver fixes.

Thanks a lot!

The following changes since commit 9bedbcb207ed9a571b239231d99c8fd4a34ae24d:
  Dave Airlie (1):
        agp: brown paper bag patch - put back two lines that got lost

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/esp-2.6.git master

David S. Miller (2):
      esp: Fix OOPS in esp_reset_cleanup().
      esp: Correct chip ID probing sequence.

Frans Pop (1):
      esp: correct module name in Kconfig help for SCSI_SUNESP

 drivers/scsi/Kconfig    |    6 ++++--
 drivers/scsi/esp_scsi.c |   32 +++++++++++++++++++++-----------
 drivers/scsi/esp_scsi.h |    1 +
 3 files changed, 26 insertions(+), 13 deletions(-)
