From: Jason Wever <weeve@gentoo.org>
Date: Fri, 30 Apr 2004 02:58:33 +0000
Subject: Illegal instruction with silo 1.4.4 and ultra 1
Message-Id: <Pine.LNX.4.58.0404292048550.13989@stargazer.weeve.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi All,

Recently re-did an Ultra 1 from the ground up.  On the initial reboot, I 
get an illegal instruction with SILO 1.4.4 after it appears to finish 
loading the kernel.  The output (with ctrace) is as below;


Boot device: disk  File and args:
SILO Version 1.4.4
boot:
Allocated 8 Megs of memory at 0x40000000 for kernel
Loaded kernel version 2.4.26
Illegal Instruction
ok ctrace
PC: 40004498
Last leaf: call 10558    from 10400
     0 w  %o0-%o5: (0 fffe8810 1 1 f005b2f8 0 )

I do have the SILO build from which this came still on the drive, so 
first.map and second.map are available for reference.  The version of OBP 
currently on the Ultra 1 is 3.1.1.   This had previously worked before the 
new install so I'm not sure what's the key element here.  I've tried with 
both 2.4.26 and 2.6.6-rc2 kernels to try and eliminate that as a possible 
culprit.

Thanks,
- -- 
Jason Wever
Gentoo/Sparc Co-Team Lead
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAkcDcdKvgdVioq28RAjqNAJ425XipdNttD9xhNPTfMxVRkznJCgCguxAm
FzDjd1kEGmZnUL7ogApcecUzp5
-----END PGP SIGNATURE-----
