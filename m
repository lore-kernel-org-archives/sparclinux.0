From: Kaj-Michael Lang <milang@tal.org>
Date: Mon, 16 Apr 2012 09:18:35 +0000
Subject: PCI SATA controllers on ultrasparc?
Message-Id: <1334567915.29201.10.camel@ubctp.tal.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi

Has anyone had any luck with adding SATA drives using an extra PCI
card ?

I have a Netra AX1105 and tried adding some disk space by adding a SATA
controller and some disks, but no luck. I've tried with two PCI card,
using sata_via and sata_promise drivers. 

The via one won't even see the connected drives, the promise sees the
drives but any use starts to give DMA errors and is painfully slow.
Controllers and drives are known to work on x86.

I've tried with 3.3 and 2.6.39.4 kernels, no difference.

I have a plain old PATA PCI card and that one works.

-- 
Kaj-Michael Lang <milang@tal.org>

