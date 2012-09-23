From: Jurij Smakov <jurij@wooyd.org>
Date: Sun, 23 Sep 2012 10:33:38 +0000
Subject: Problems with Debian in LDOM
Message-Id: <20120923103338.GA6800@wooyd.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

I recently got access to a T1000 machine running Solaris 10 with LDOMs 
version 1.2, and tried to test the latest Debian installer (Wheezy 
beta 2) by installing it into an LDOM. The installation appears to 
work mostly fine (we have a minor bug preventing automated loading of 
sunvnet and sunvdc modules), but after the installation finishes, the 
data on virtual disk (backed, in my case, by a file created with 
mkfile) is randomly corrupted, so on reboot the root file systems 
comes up in read-only mode, random binaries/scripts fail to execute, 
etc.

By now I tried the installation 3 times, first two were using ext4 as 
root/home filesystems. In these cases I was able to complete the 
installation, but the system was unusable after the reboot due to data 
corruption on disk. I then tried using ext2 only, thinking that it 
might be ext4 issue, and was not even able to complete the 
installation due to disk errors. Relevant portion of dmesg output 
saved from this install run:

[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.28.1 2008/02/11 13:04'
[    0.000000] PROMLIB: Root node compatible: sun4v
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.2.0-3-sparc64 (Debian 3.2.23-1) (debian-kernel@lists.debian.org) (gcc version 4.6.3 (Debian 4.6.3-8) ) #1 Mon Jul 23 03:37:35 UTC 2012
[...]
[ 6935.913467] sunvnet.c:v1.0 (June 25, 2007)
[ 6935.917982] eth0: Sun LDOM vnet 00:14:4f:f8:e2:6f
[ 6935.919764] sunvnet: eth0: PORT ( remote-mac 00:14:4f:f8:27:09 switch-port )
[ 7569.263779] sunvdc.c:v1.0 (June 25, 2007)
[ 7569.265299] sunvdc: vdiska: 41720805 sectors (20371 MB)
[ 7569.267844]  vdiska: vdiska1 vdiska2 vdiska3 vdiska4 vdiska5
[...]
[ 8659.183062] sunvdc: ldc_map_sg() failure, err=-40.
[ 8659.183083] end_request: I/O error, dev vdiska, sector 10969060
[ 8659.778350] sunvdc: ldc_map_sg() failure, err=-40.
[ 8659.778371] end_request: I/O error, dev vdiska, sector 10981396
[ 8659.857056] sunvdc: ldc_map_sg() failure, err=-40.
[...]
[ 8660.515942] Buffer I/O error on device vdiska2, logical block 1349865
[ 8660.515958] lost page write due to I/O error on vdiska2
[...]

Error messages like this logged in dmesg multiple times, until 
installer fails and is aborted. The complete dmesg output is available 
at http://www.wooyd.org/tmp/dmesg_ldom.log.

Questions: does anyone have properly working setup with Debian (or 
other Linux) in an LDOM? Should my particular setup (combination of 
Solaris/LDOM/kernel version) be supported? Is there anything in the 
LDOM setup I might need to tweak to make it work?

Best regards,
-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC
