From: "Roland Vossen" <rvossen@broadcom.com>
Date: Sun, 31 Jul 2011 08:36:40 +0000
Subject: Sparc, dma mapping and endianness
Message-Id: <4E351418.50101@broadcom.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello David,

I have got a DMA capable PCI device that writes its data into host 
memory. The CPU reads that data. For little endian processor this works 
fine, but for big endian processors the data has to be endianness 
swapped before interpretation.

The broadcom BCM47XX (MIPS) series has a hardware provision for this: 
its memory controller defines a 'SDRAM swap window'.

I read that the Sparc-V9 64 bit architecture also supports endianness 
swapping of pages. I wonder if it is easy to make use of this 
functionality in Linux.

Also I wonder if Linux supports an arch agnostic API to accomplish this.

I did read Documentation/DMA-mapping.txt but that did not provide more 
information on this subject to me.

Thanks, Roland.



