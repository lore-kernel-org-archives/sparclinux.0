From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 24 Nov 2016 22:59:31 +0000
Subject: silo: Add 64-bit support, v2
Message-Id: <20161124225932.13472-1-glaubitz@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Replaced "LD=ld -m elf64_sparc" with "LD=ld" which essentially
reverts c836dbda which hard-wired the build to 32 bits. Since
both 32- and 64-bit builds are supported these days, this should
no longer be necessary.

Adrian

