From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 12 Jan 2017 18:52:45 +0000
Subject: [PATCH 0/4] n2rng: add support for m5/m7 rng register layout
Message-Id: <1484247169-245086-1-git-send-email-shannon.nelson@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-crypto@vger.kernel.org
Cc: sparclinux@vger.kernel.org, herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org, Shannon Nelson <shannon.nelson@oracle.com>

Commit c1e9b3b0eea1 ("hwrng: n2 - Attach on T5/M5, T7/M7 SPARC CPUs")
added config strings to enable the random number generator in the sparc
m5 and m7 platforms.  This worked fine for client LDoms, but not for the
primary LDom, or running on bare metal, because the actual rng hardware
layout changed and self-test would now fail, continually spewing error
messages on the console.

This patch series adds correct support for the new rng register layout,
and adds a limiter to the spewing of error messages.

Orabug: 25127795

Shannon Nelson (4):
  n2rng: limit error spewage when self-test fails
  n2rng: add device data descriptions
  n2rng: support new hardware register layout
  n2rng: update version info

 drivers/char/hw_random/n2-drv.c |  204 +++++++++++++++++++++++++++++----------
 drivers/char/hw_random/n2rng.h  |   51 ++++++++--
 2 files changed, 196 insertions(+), 59 deletions(-)

