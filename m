From: Neeraj Gupta <Neeraj.Gupta@Sun.COM>
Date: Sat, 07 Oct 2006 03:05:20 +0000
Subject: How to run diskless linux on T2000
Message-Id: <45271970.1020503@sun.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I would like to run diskless linux (ubuntu 6.06.1) on T2000.
Here is what I have tried so far :
- prepare a network server using boot.img (on sparc/solaris serving rarp 
and tftpboot)
- setup /etc/ethers, /etc/hosts etc
- issue a "boot net" from T2000
- T2000 picks up boot.img and presents me "boot:" prompt
- I have correct vmlinuz on this remote server and I do have root file 
system also (copied from a T2000 running ubuntu locally)
- How do I tell T2000 to pickup a) vmlinuz and b) rootfs from nfs

I tried to give network device path name with several options as 
mentioned in "help" from boot" but no luck.
The message says that it can not find the specified file.

Please provide some pointers.

Thanks,
Neeraj
