From: =?ISO-8859-1?Q?S=E9bastien_Bernard?= <seb@frankengul.org>
Date: Sun, 06 Sep 2009 21:49:39 +0000
Subject: Problem with saturn since 2.6.29 (debian kernel).
Message-Id: <4AA42E73.3050907@frankengul.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I'm running on linux-image-2.6.29-2-sparc64-smp on an U60 (2x Uii 450mhz).

I'm on SID and I had quite a lot of problems with my ethernet controler.

Here's the references of the controler :
0000:00:02.0 Ethernet controller: National Semiconductor Corporation 
DP83065 [Saturn] 10/100/1000 Ethernet Controller (rev 30)

PCI Id is 100b:0035.

The Kernel reported the following problem :
[1684214.274488] eth1: Link down
[1684214.274512] eth1:reset called in cas_abnormal_irq [0xa721000]
[1684220.889911] eth1: Link up at 1000 Mbps, full-duplex.
[1684220.889937] eth1: Pause is enabled (rxfifo: 16384 off: 13312 on: 11776)
[1684221.081675] eth1: Link down
[1684221.081694] eth1:reset called in cas_abnormal_irq [0x21000]
[1684236.586802] eth1: Link up at 100 Mbps, full-duplex.
[1684236.586826] eth1: Pause is enabled (rxfifo: 16384 off: 13312 on: 11776)
[1707485.501429] eth1: Link down
[1707485.501448] eth1:reset called in cas_abnormal_irq [0x4621000]
[1707505.313339] eth1: Link up at 1000 Mbps, full-duplex.
[1707505.313363] eth1: Pause is enabled (rxfifo: 16384 off: 13312 on: 11776)
[1707505.321494] eth1: Link down
[1707505.321511] eth1:reset called in cas_abnormal_irq [0x21000]
[1707509.789804] eth1: Link up at 100 Mbps, full-duplex.
[1707509.789826] eth1: Pause is enabled (rxfifo: 16384 off: 13312 on: 11776)


The machine was working ok with 2.6.28-7-smp kernel.
Transfert are slow (~ 4-7 MBytes/s) and pauses at regular times.

On 2.6.30-1, it goes worse. Link goes down and up every few seconds, 
making the work
a nightmare.

Is this a know problem or should I report a bug for this ?

    Seb

