From: Meelis Roos <mroos@linux.ee>
Date: Tue, 15 Aug 2017 14:42:00 +0000
Subject: Niagara2 & Could not register hvapi ATU err=-22
Message-Id: <alpine.LRH.2.20.1708151738450.29628@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I noticed that on Niagara2, dmesg has a red error about ATU 
registration:

[    4.579231] pci_sun4v: Could not register hvapi ATU err=-22

This is preceded by info line
[    4.578073] pci_sun4v: Registered hvapi major[1] minor[0]

As I understand, there is no ATU on Niagara1 & Niagara2 sun4v platforms, 
so there is no point in trying to log an error to dmesg in that case?

-- 
Meelis Roos (mroos@linux.ee)
