From: Gustavo Zacarias <gustavoz@gentoo.org>
Date: Tue, 04 May 2004 15:07:56 +0000
Subject: Re: Illegal instruction with silo 1.4.4 and ultra 1
Message-Id: <4097B1CC.2070106@gentoo.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.58.0404292048550.13989@stargazer.weeve.org>
In-Reply-To: <Pine.LNX.4.58.0404292048550.13989@stargazer.weeve.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ben Collins wrote:

|>Recently re-did an Ultra 1 from the ground up.  On the initial reboot, I
|>get an illegal instruction with SILO 1.4.4 after it appears to finish
|>loading the kernel.  The output (with ctrace) is as below;
|
|
| When you say an Ultra 1, do you mean an UltraSPARC 1, or an
| UltraSPARC-I?
|
| Also, shoot me the output of ".registers" after the illegal instruction.
|

I was able to reproduce this problem in a scientific way :)
Scenario: Power up and boots cleanly linux. Power up, boot a solaris CD,
halt, and then try to boot linux and it fails. reset-all doesn't help.
Powering off and booting linux again and again works, just when solaris
gets in the way the problem shows up.
Trace:

- -----
# halt
syncing file systems... done
Program terminated
ok boot
Resetting ...




Sun Ultra 5/10 UPA/PCI (UltraSPARC-IIi 400MHz), No Keyboard
OpenBoot 3.31, 384 MB (50 ns) memory installed, Serial #16109071.
Ethernet address 8:0:20:f5:ce:f, Host ID: 80f5ce0f.






Rebooting with command: boot
Boot device: disk:a  File and args:
SILO Version 1.4.4
boot:
Allocated 8 Megs of memory at 0x40000000 for kernel
Loaded kernel version 2.4.26
Illegal Instruction
ok .registers
~        Normal          Alternate       MMU               Vector
0:                 0                0                0                0
1:          40004000         fffde6c0                d               2b
2:          40004000         f0000000               14         f0000000
3:            400000                0         fffe0000      80000000000
4:            3a5c00                0 ffffffffffffffff         fffe7b48
5:  e00000001f002077                f         fffde000               f8
6:                 0       4400001601 800000001ff660b6      80000000000
7:               1f8               10                2         f0055574
%PC  40004498 %nPC 4000449c
%TBA f0000000 %CCR 44 XCC:nZvc   ICC:nZvc
ok ctrace
PC: 40004498
Last leaf: call 10558    from 10400
~     0 w  %o0-%o5: (0 fff9bd40 1 1 f00673e8 0 )
- -----

- --
Gustavo Zacarias
Gentoo/SPARC & HPPA monkey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFAl7HMV3G/IBCn/JARArUHAJ9xaHPdsXFmBF0ExsDCp2Lwc3q8twCdHRAS
E7D9UIDWDgCb1+XRrBCjoMg=kEkZ
-----END PGP SIGNATURE-----
