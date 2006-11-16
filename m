From: BERTRAND =?iso-8859-1?Q?Jo=EBl?= <joel.bertrand@systella.fr>
Date: Thu, 16 Nov 2006 15:46:38 +0000
Subject: Super/HyperSPARC (2.6.18.2)
Message-Id: <20061116154638.GA3138@rayleigh.systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hello,

	I use a SparcSTATION 20 to do some tests (network configuration and some
	others...). On one of these, I have two SuperSPARC-II/75 and this
	workstation runs a Linux 2.6.18.2 kernel (smp) without any trouble.
	The last week, I have changed both processors by a dual RT-626 module.
	The workstation boots and is usable, but, when I try to install a new
	package with apt-get, I receive :

hilbert:~# LANG=C apt-get install fbset
Reading package lists... Done
Building dependency tree... Done
The following NEW packages will be installed:
  fbset
0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.
Need to get 0B/103kB of archives.
After unpacking 336kB of additional disk space will be used.
Preconfiguring packages ...
dpkg: error processing /var/cache/apt/archives/fbset_2.1-19_sparc.deb
(--unpack):
parse error, in file `/var/lib/dpkg/tmp.ci/control' near line 3 package 'fbset':
field name `Section: admin
Priority: optional
Architecture: sparc
Depends: libc6' must be followed by colon
Erreur de segmentation
hilbert:~# 

	I have six different modules and I receive the same error with all modules.
	I have tested all modules under Solaris9 and they work fine and this error
	does not come from SMP code (I have tried with only one CPU).

	A bug in hypersparc MMU code ? But why the only error I can see is with
	apt-get ?

	Regards,

	JKB
