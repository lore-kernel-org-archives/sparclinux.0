From: Joe Moriarty <joe.moriarty@oracle.com>
Date: Tue, 24 May 2016 15:16:10 +0000
Subject: [PATCH V2 0/2] SPARC-S7 epsapp changes
Message-Id: <1464102972-676961-1-git-send-email-joe.moriarty@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

epsapp is a client application that runs in a ldom environment 
using a minimal UEK4.1 version of Oracle Linux.  The patches
provided here are for the minimal UEK4.1 kernel that epsapp runs on. 

V2:
 * submitting multiple patch set correctly to sparclinux
 * No program changes between the initial patchset and V2.

Joe Moriarty (2):
  arch/sparc:  SPARC-S7 piggyback support
  arch/sparc:  SPARC-S7 epsc group support

 arch/sparc/boot/piggyback.c         |   17 +++++++++--------
 arch/sparc/include/asm/hypervisor.h |    1 +
 arch/sparc/kernel/hvapi.c           |    1 +
 3 files changed, 11 insertions(+), 8 deletions(-)

