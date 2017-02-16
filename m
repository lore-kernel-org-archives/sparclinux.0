From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 16 Feb 2017 20:13:53 +0000
Subject: [PATCH] sparc64: memblock resizes are not handled properly
Message-Id: <1487276034-154065-1-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Tested on T4-4 with 2T of memory, the hang is not happening anymore,
also tested on M6-32 ldom

Pavel Tatashin (1):
  sparc64: memblock resizes are not handled properly

 arch/sparc/mm/init_64.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

