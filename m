From: Aaron Wirtz <awirtz@novapointe.com>
Date: Wed, 31 Dec 2003 22:29:26 +0000
Subject: socal
Message-Id: <200312311429.26841.awirtz@novapointe.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I have a Sun e3500 and I am trying to get the linux socal/fcal drivers 
working.  I have done a bit of reasearch and have tried several different 
linux kernel versions and different socal microcode versions to no avail.  
Does anyone know of a patch that fixes the broken socal/fcal drivers under 
2.4.x or, failing that, does anyone know what version of the linux kernel and 
the Solaris microcode Jakub was using in the past (1999) when he had the 
driver working?

As a side note, all of the socal microcode I have seen so far uses the full 
64kb of data and has none of the null padding at the end that Jakub mentioned 
in his post - this confuses part of the driver code (65536 is too big for an 
unsigned int) so I just cut out the code that adds the null padding for 
microcode <64kb since my microcode has no padding anyway, and the module 
compiles properly.

When I try to modpobe the socal drivers, there are no messages and it shows as 
loaded under lsmod.
When I try to load fcal, it complains that there are no devices.

The same machine runs fine with the solaris socal driver under Solaris 9.

Thanks.

-Aaron Wirtz

