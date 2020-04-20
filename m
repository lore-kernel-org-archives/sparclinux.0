From: Nate Karstens <nate.karstens@garmin.com>
Date: Mon, 20 Apr 2020 07:15:44 +0000
Subject: Implement close-on-fork
Message-Id: <20200420071548.62112-1-nate.karstens@garmin.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Changli Gao <xiaosuo@gmail.com>

Series of 4 patches to implement close-on-fork. Tests have been
published to https://github.com/nkarstens/ltp/tree/close-on-fork.

close-on-fork addresses race conditions in system(), which
(depending on the implementation) is non-atomic in that it
first calls a fork() and then an exec().

This functionality was approved by the Austin Common Standards
Revision Group for inclusion in the next revision of the POSIX
standard (see issue 1318 in the Austin Group Defect Tracker).

[PATCH 1/4] fs: Implement close-on-fork
[PATCH 2/4] fs: Add O_CLOFORK flag for open(2) and dup3(2)
[PATCH 3/4] fs: Add F_DUPFD_CLOFORK to fcntl(2)
[PATCH 4/4] net: Add SOCK_CLOFORK
