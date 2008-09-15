From: Meelis Roos <mroos@linux.ee>
Date: Mon, 15 Sep 2008 09:05:39 +0000
Subject: Re: psycho_irq_build: Wacky INO [3c]
Message-Id: <Pine.SOC.4.64.0809151204180.4206@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Below is a debugging patch for the sunhme driver, so we can see if
> it is actually trying to probe those QFE PCI interfaces and failing
> in some strange way.

All I get with this patch is the dmesg excerpt below:

sunhme.c:v3.00 June 23, 2006 David S. Miller (davem@davemloft.net)
eth0: Quattro HME slot 0 (SBUS) 10/100baseT Ethernet 08:00:20:9d:77:08
eth1: Quattro HME slot 1 (SBUS) 10/100baseT Ethernet 08:00:20:9d:77:09
eth2: Quattro HME slot 2 (SBUS) 10/100baseT Ethernet 08:00:20:9d:77:0a
eth3: Quattro HME slot 3 (SBUS) 10/100baseT Ethernet 08:00:20:9d:77:0b
eth4: HAPPY MEAL (SBUS) 10/100baseT Ethernet 08:00:20:b6:ee:e2
eth5: Quattro HME slot 0 (SBUS) 10/100baseT Ethernet 08:00:20:93:79:94
eth6: Quattro HME slot 1 (SBUS) 10/100baseT Ethernet 08:00:20:93:79:95
eth7: Quattro HME slot 2 (SBUS) 10/100baseT Ethernet 08:00:20:93:79:96
eth8: Quattro HME slot 3 (SBUS) 10/100baseT Ethernet 08:00:20:93:79:97
sunhme: Probing PCI device bus[0] devfn[0x9]
PCI: Enabling device: (0000:00:01.1), cmd 2
eth9: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet 08:00:20:b6:ee:e2
sunhme: Success


-- 
Meelis Roos (mroos@linux.ee)
