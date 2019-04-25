From: Corentin Labbe <clabbe.montjoie@gmail.com>
Date: Thu, 25 Apr 2019 07:07:13 +0000
Subject: Build failure on next-20190424
Message-Id: <20190425070713.GA28161@Red>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello

On next-20190424, I hit the following build failure:
arch/sparc/kernel/ds.c: In function 'ldom_set_var':
arch/sparc/kernel/ds.c:799:3: error: 'strcpy': writing at least 1 byte into a region of size 0 overflows the destination [-Werror=stringop-overflow=]

Regards
