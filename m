From: Meelis Roos <mroos@linux.ee>
Date: Tue, 22 Mar 2005 08:51:26 +0000
Subject: sunqe driver does not recognize the card
Message-Id: <Pine.SOC.4.61.0503221048210.29185@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I have a Sparcstation 20 with qec/be card (Sun FastEthernet). I have 
compiled the sunqe module in 2.6.12-rc1 and it does not load - complains 
about no such device:
FATAL: Error inserting sunqe (/lib/modules/2.6.12-rc1/kernel/drivers/net/sunqe.ko): No such device
Nothing is in the dmesg.

This is the info about the card - should it be supported?

kirss:/proc/openprom/iommu@f,e0000000/sbus@f,e0001000# find qec\@1\,20000 qec\@1\,20000/be\@0\,0/ -type f -exec echo {} \; -exec cat {} \;
qec@1,20000/.node
ffd767d0
qec@1,20000/#channels
00000001
qec@1,20000/ranges
00000000.00000000.00000001.00030000.00004000.00000010.00000000.00000001.00010000.00008000.00000020.00000000.00000001.00018000.00008000
qec@1,20000/reg
00000001.00020000.00010000.00000001.00040000.00020000
qec@1,20000/model
'SUNW,270-2450'
qec@1,20000/name
'qec'
qec@1,20000/be@0,0/.node
ffd77960
qec@1,20000/be@0,0/board-version
00000001
qec@1,20000/be@0,0/reg
00000000.00000000.00004000.00000010.00000000.00008000.00000020.00000000.00008000
qec@1,20000/be@0,0/device_type
'network'
qec@1,20000/be@0,0/intr
00000037.00000000
qec@1,20000/be@0,0/interrupts
00000004
qec@1,20000/be@0,0/address-bits
00000030
qec@1,20000/be@0,0/max-frame-size
00004000
qec@1,20000/be@0,0/channel#
00000000
qec@1,20000/be@0,0/name
'be'


-- 
Meelis Roos (mroos@linux.ee)
