From: Joe Ciccone <jciccone@gmail.com>
Date: Tue, 07 Mar 2006 01:12:16 +0000
Subject: Re: Silo 1.4.10
Message-Id: <440CDDF0.6020500@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1136175018.27583.50.camel@grayson>
In-Reply-To: <1136175018.27583.50.camel@grayson>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This task is finally over. The link to the following patch is as minimal
as i think it can be giving the structure of silo. /include/emul_32
contains asm headers that control the types, This was what i was after
when I pulled in all of the system headers. CC is split up into CC and
CC-SILO, CC builds default to whatever the host is, and CC-SILO will
always build 32bit ensuring that the loaders are properly built. This
patch has been tested by myself on a multilib pure64 build and by one
other person on a pure64 build. Enjoy a 32bit less machine! - Joe

http://www.crazyeyesoft.com/silo-1.4.10-fixes-2.patch
-or-
http://www.linuxfromscratch.org/patches/downloads/silo/silo-1.4.10-fixes-2.patch
