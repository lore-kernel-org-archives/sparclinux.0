From: till varoquaux <tvaroqua@ie2.u-psud.fr>
Date: Thu, 01 Jul 2004 17:48:09 +0000
Subject: initrd problems??
Message-Id: <20040701194809.3e060eb0.tvaroqua@ie2.u-psud.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I'm having problems netbooting a ultrasparc 1 server.
I'm using tilo (from silo1.4.6) with a home made initrd. In this initrd
I have a simple staticly linked busybox shell and a /linuxrc shell
script there are also a couple of devices under /dev. Now here is were
things start to get weird:
My initrd looks alright to me (at least it works find when I
mount it and chroot into it)
_If I use it without any changes I get the message you get when calling
busybox without any parametres ( /bin/busybox when the sha bang of my
/linuxrc is: #!/bin/sh)
_If I get rid of busybox put a statically linked bash in /bin and
replace the first line of /linuxrc with #!/bin/bash I get:
VFS: Mounted root (ext2 filesystem)
Kernel panic: No init found. Try passing init= option to your kernel

I'm confused: isn't the standard init for an initrd /linuxrc?
How do I pass options to the kernel with tilo?
How come busybox is called when there isn't even an init link??
My kernel is the one from the Debian boot cd (I don't have the time to
compile a new one until I get this problem solved).
Till Varoquaux
-- 
"pardon my french"
