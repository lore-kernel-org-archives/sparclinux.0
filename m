From: Tom De Rybel <tomr@ece.ubc.ca>
Date: Fri, 01 Feb 2008 21:03:56 +0000
Subject: TILO segfaults
Message-Id: <47A3893C.8010608@ece.ubc.ca>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

I've been trying to use TILO to generate a new boot file.
The issue is that it keeps segfautling as follows:

tilo vmlinux_test initrd_test.gz
Converting vmlinux_test (sun4u) to a.out:
PT 0 Entry: Loadable to 0x400000[0x459b58] from 0x0[0x3e6085] align 0x100000
PT 1 Entry: unknown
Compressing vmlinux_test.raw:
vmlinux_test.raw:        55.7%
Sizes (sun4u):
  raw size    = 4071557
  packed size  = 1804675
  root address = 0000000000859b58
Root image packed size = 5259697
WARNING: Kernel for Sun4c/m/d not specified
Images are large. Will load on machines with at least 5M mapped by PROM only
Segmentation fault

I tried the version that came with Ubuntu 7.10 and many different
versions of the silo package, with similar results. Also, I tried
varying compressed and uncompressed versions of the input files. The
system is an Ultra5. The used input files are those found in the Ubuntu
6.10LTS release. I tried to re-generate their supplied file first before
making my changes. No luck.

Any help and suggestions would be much appreciated.

Sincerely yours,
Tom De Rybel
