From: Michael Tautschnig <michael.tautschnig@zt-consulting.com>
Date: Mon, 14 Feb 2005 19:41:33 +0000
Subject: TUNSETIFF: data not copied back to userspace
Message-Id: <Pine.LNX.4.61.0502141928510.11663@l01.thnet>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello!

Thanks for the information regarding userland/kernelspace - I think I 
understood ...

The reason of my question were problems using the tun/tap interface - I've 
got an application (namely l2tpns) demanding the ifreq-structure being 
copied back to userspace - which AFAIK doesn't happen in case of the 
TUNSETIFF-ioctl. Is this a bug or are there any reasons why this shouldn't 
happen in dev_ifsioc ?

Thanks,
Michael

