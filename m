From: Ben Collins <ben.collins@ubuntu.com>
Date: Mon, 02 Jan 2006 04:10:18 +0000
Subject: SILO 1.4.10
Message-Id: <1136175018.27583.50.camel@grayson>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Been a long time coming. This mainly includes:

- Fix for printing banner
- Fix for allocation of initrd memory region on some memory layouts
(patch from davem)

There's a few other minor tweaks, like building on current systems
(gcc/libc/libext2 changes).

http://www.sparc-boot.org/pub/silo/

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux

