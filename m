From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Wed, 03 Jan 2018 22:53:58 +0000
Subject: Separate kernel and userspace address spaces on Linux SPARC?
Message-Id: <9ce7f029-6894-5f69-0984-84a871b12979@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi!

In the light of the recent x86 vulnerability which allows user space
applications to peak into kernel memory and consequently make the
system vulnerable to Return-Oriented Programming (ROP) attacks, I have
heard that these attacks are not possible on SPARC v9 as the architecture
uses separate address spaces for kernel and userspace.

While I have found literature that this applies to Solaris, I couldn't
find any direct mentions of Linux on SPARC.

Does anyone of the SPARC kernel people know what the situation on Linux
SPARC is?

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
