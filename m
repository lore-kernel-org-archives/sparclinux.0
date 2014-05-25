From: Chan Kim <flyxtop@gmail.com>
Date: Sun, 25 May 2014 04:50:08 +0000
Subject: about using dma_alloc_writecombine in sparc
Message-Id: <CANFSLnyQ1=s84sEd=2JXu8gHwyspfyeYELwS-+Q77ixs9Dv8uQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

 Hi, folks,

I was trying to use dma_alloc_writecombine function from arm for our sparc
processor.
The dma_alloc_writecombine uses consistent memory near 0xffe00000 but I'm
allocating consistent memory around 0x69000000.
(we have physical memory at 0x60.. )
I need dma memory for frame buffer and SD card driver. (0x1000 and 0x1d5000
each)
Is my approach a good one? What is the proper way to allocate DMA address
for sparc?
(dma_aloc_coherent seems to be for smaller size buffer)
Thanks in advance.

regards,
Chan
