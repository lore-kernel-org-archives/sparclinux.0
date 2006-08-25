From: Jurij Smakov <jurij@wooyd.org>
Date: Fri, 25 Aug 2006 06:14:11 +0000
Subject: Re: cassini driver failure in 2.6.17
Message-Id: <Pine.LNX.4.63.0608242301500.6263@bobcat>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

We have a report from a user (CC'd) who tried to install Debian testing 
with 2.6.17 (including all patches up to 2.6.17.8) kernel onto a B100 
blade with two cassini ethernet adapters [0]. The installer was 
successfully netbooted, but an attempt to load the cassini driver later 
failed with the messages:

  cassini.c:v1.4 (1 July 2004)
  cassini: Cannot find proper PCI device base address, aborting.
  cassini: Cannot find proper PCI device base address, aborting.

Any help in resolving this issue would be appreciated.

[0] http://bugs.debian.org/384549

Best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
