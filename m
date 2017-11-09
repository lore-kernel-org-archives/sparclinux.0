From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Thu, 09 Nov 2017 06:16:50 +0000
Subject: [PATCH v2 0/2] sparc: pass endianness info to sparse
Message-Id: <20171109061652.14948-1-luc.vanoostenryck@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S . Miller" <davem@davemloft.net>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

The goal of these two patches is to ass endianness and machine
size info to sparse so that sparse can emit correct diagnostics
even when the endianness or machine size doesn't correspond to
sparse's defaults.

Change since v1:
- move sparse options common to sparc32 & sparc64 at the 
  same place.

Luc Van Oostenryck (2):
  sparc: use a common CHECKFLAGS entry for common flags
  sparc: pass endianness info to sparse

 arch/sparc/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
To: David S. Miller <davem@davemloft.net>
CC: Sam Ravnborg <sam@ravnborg.org>
CC: sparclinux@vger.kernel.org
CC: linux-kernel@vger.kernel.org
