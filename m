From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 15 Jun 2017 14:40:57 +0000
Subject: [v1 0/2] Early boot timestamp fixes
Message-Id: <1497537659-419752-1-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Guenter Roeck reported a problem that was introduced by early boot
timestamp changes. Where: tick_get_frequency() returns 0.

Guenter Roeck: could you please test if these patches fix the issue?

Pavel Tatashin (2):
  sparc64: use prom interface to get %stick frequency
  sparc64: broken %tick frequency on spitfire cpus

 arch/sparc/kernel/time_64.c |   34 ++++++++++++++++++++++++++++------
 1 files changed, 28 insertions(+), 6 deletions(-)

