From: Dennis Stosberg <dennis@stosberg.net>
Date: Tue, 11 Oct 2005 21:49:49 +0000
Subject: Re: linux-2.6.14-rc does not boot on Ultra 5
Message-Id: <20051011214949.GD2865@leonov.stosberg.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20051011210428.GC2865@leonov.stosberg.net>
In-Reply-To: <20051011210428.GC2865@leonov.stosberg.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David S. Miller wrote:

> I have an Ultra5 here and will try to reproduce, but meanwhile if you
> could send the output of the ".registers" command when it fails like
> this it would be appreciated.  Thanks.

Rebooting with command: boot net
Boot device: /pci@1f,0/pci@1,1/network@1,1  File and args:
29e000 Illegal Instruction
ok .registers
        Normal          Alternate       MMU               Vector
0:                 0                0                0                0
1:                 f         fffde6c0       9900001600       2000002402
2:            4042ec         f0000000               14    2220000080000
3:                 0                0         fffe0000 8220200000020000
4:                 0                0 ffffffffffffffff        200800400
5:                 0                f         fffda000     a00000000a00
6:                 0       4400001601         fffe0000        200000d00
7:                17               10         f0000e00   10080000180080
%PC  4042f0 %nPC 6c421084
%TBA f0000000 %CCR 99 XCC:NzvC   ICC:NzvC

-Dennis
