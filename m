From: Jason Wever <weeve@gentoo.org>
Date: Fri, 30 Apr 2004 03:32:26 +0000
Subject: Re: Illegal instruction with silo 1.4.4 and ultra 1
Message-Id: <Pine.LNX.4.58.0404292131120.13989@stargazer.weeve.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.58.0404292048550.13989@stargazer.weeve.org>
In-Reply-To: <Pine.LNX.4.58.0404292048550.13989@stargazer.weeve.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thu, 29 Apr 2004, Ben Collins wrote:

> When you say an Ultra 1, do you mean an UltraSPARC 1, or an
> UltraSPARC-I?

It's an Ultra 1 Workstation (143 MHz).
 
> Also, shoot me the output of ".registers" after the illegal instruction.

ok .registers
        Normal          Alternate       MMU               Vector
0:                 0                0                0                0
1:          40004000         fffdf6c0       4400001600              7f1
2:          40004000         f0000000               14         f0000000
3:            400000                0         fffe0000      10000000000
4:            3a5400                0 ffffffffffffffff             4000
5:  e00000003f002077                f         fffde000               f8
6:                 0       4400001601 800000003ff660b6                e
7:               1f8               10                2         f0055cec
%PC  40004498 %nPC 4000449c 
%TBA f0000000 %CCR 44 XCC:nZvc   ICC:nZvc


- -- 
Jason Wever
Gentoo/Sparc Co-Team Lead
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAkcjMdKvgdVioq28RAuqbAJ0ctt3m+YW+S2dVRejWQPRfqso1PgCfT0ep
XA0FYUFa/F2yMDEfVQWoT8E=yE2N
-----END PGP SIGNATURE-----
