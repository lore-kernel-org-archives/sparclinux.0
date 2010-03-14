From: Jack Morgan <jack@bonyari.com>
Date: Sun, 14 Mar 2010 18:21:26 +0000
Subject: QFE Cards
Message-Id: <4B9D2926.9080606@bonyari.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I've got two sbus based quad ethernet (100baseT) in an Ultra 2. Only one
card is getting detected by the kernel. It looks like the sunhme driver
supports this card and I'm running a 2.6.33 kernel. Here is the output
from dmesg:

eth0: HAPPY MEAL (SBUS) 10/100baseT Ethernet 08:00:20:80:eb:8f
eth1: Quattro HME slot 0 (SBUS) 10/100baseT Ethernet 08:00:20:aa:90:54
eth2: Quattro HME slot 1 (SBUS) 10/100baseT Ethernet 08:00:20:aa:90:55
eth3: Quattro HME slot 2 (SBUS) 10/100baseT Ethernet 08:00:20:aa:90:56
eth4: Quattro HME slot 3 (SBUS) 10/100baseT Ethernet 08:00:20:aa:90:57


Assuming both cards aren't broken, is there anything else that would
prevent both cards from being detected?


Thanks,
Jack Morgan
