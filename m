From: Jim Gifford <maillist@jg555.com>
Date: Sun, 25 Jun 2006 18:36:12 +0000
Subject: Sparc32 Netboot - Build Errors - 2.6.17.1
Message-Id: <449ED79C.3030101@jg555.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hey all trying to make a sparc netboot image for 32 bit. Ran the make 
tftpboot.img and got the following errors. This is just a 10 lines or so 
of the error, there are about 10 pages of errors. Before I attempted to 
fix, anyone already talked this one?

  LD      arch/sparc/boot/image
drivers/built-in.o: In function `sym_free_resources':
sym_glue.c:(.text+0x5e118): undefined reference to `pci_iounmap'
sym_glue.c:(.text+0x5e130): undefined reference to `pci_iounmap'
drivers/built-in.o: In function `sym_detach':
sym_glue.c:(.text+0x5e198): undefined reference to `iowrite8'
sym_glue.c:(.text+0x5e1a4): undefined reference to `ioread8'
sym_glue.c:(.text+0x5e1c4): undefined reference to `iowrite8'
drivers/built-in.o: In function `sym53c8xx_proc_info':
sym_glue.c:(.text+0x5f210): undefined reference to `iowrite8'
sym_glue.c:(.text+0x5f37c): undefined reference to `iowrite8'
drivers/built-in.o: In function `sym2_probe':
sym_glue.c:(.text+0x5fe2c): undefined reference to `pci_iomap'
sym_glue.c:(.text+0x5fe94): undefined reference to `pci_iomap'
sym_glue.c:(.text+0x6035c): undefined reference to `pci_iomap'
drivers/built-in.o: In function `sym_reset_scsi_target':
(.text+0x61728): undefined reference to `iowrite8'
drivers/built-in.o: In function `sym_put_start_queue':

