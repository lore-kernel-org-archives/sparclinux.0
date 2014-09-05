From: David L Stevens <david.stevens@oracle.com>
Date: Fri, 05 Sep 2014 15:12:03 +0000
Subject: commit 8c86e70acead629aacb4afcd818add66bf6844d9 hangs SPARC64 LDOMs
Message-Id: <5409D2C3.6010806@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I was trying to rebase some patches to the latest net-next and I found that the LDOMs
(Solaris virtual machines) hang on boot.

git bisect narrowed to commit 8c86e70acead629aacb4afcd818add66bf6844d9 and reverting
that makes it work again.

commit 8c86e70acead629aacb4afcd818add66bf6844d9
Author: Vivek Goyal <vgoyal@redhat.com>
Date:   Fri Aug 8 14:25:50 2014 -0700

    resource: provide new functions to walk through resources

    I have added two more functions to walk through resources.

						+-DLS
