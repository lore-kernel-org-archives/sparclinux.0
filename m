From: Vegard Nossum <vegard.nossum@oracle.com>
Date: Sun, 17 Jul 2016 12:29:18 +0000
Subject: openpromfs root inode has ino 0
Message-Id: <578B7A1E.5090500@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org

Hi,

I noticed that fs/openpromfs/inode.c has:

#define OPENPROM_ROOT_INO  0

It seems it was originally 16 but was changed to 0 here:

commit 3d824a46b7210ea3b0a13ab0d0fbd7f6e2e91ddf
Author: David S. Miller <davem@davemloft.net>
Date:   Sun Jun 25 23:19:14 2006 -0700

     [OPENPROMFS]: Rewrite using in-kernel device tree and seq_file.

As far as I understand, inode 0 should never be used and can cause
various things to fail, e.g. my /bin/ls seems to completely ignore
getdents() results which have ->d_ino = 0.

I don't know if it actually causes any problems for people who are
actually using this, and I don't have the means to test the code anyway,
so just a heads up...


Vegard
