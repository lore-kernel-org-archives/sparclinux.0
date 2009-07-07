From: Robert Reif <reif@earthlink.net>
Date: Tue, 07 Jul 2009 23:40:09 +0000
Subject: sparc32 dma-debug found bug?
Message-Id: <4A53DCD9.30104@earthlink.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

I have the latest dma debug patches from FUJITA Tomonori
and http://patchwork.kernel.org/patch/33866/ running on
sparc32 and it looks like it might have found an issue at
boot time:

WARNING: at lib/dma-debug.c:874 check_for_illegal_area+0x174/0x1ac()
esp ffd7ba30: DMA-API: device driver maps memory from kernel text or=20
rodata [addr=F0007000] [size@96]
Modules linked in: ext3 jbd sd_mod sun_esp esp_scsi scsi_transport_spi=20
scsi_mod
[f01200ec : check_for_illegal_area+0x174/0x1ac ]
[f0120c6c : debug_dma_map_sg+0x15c/0x1c8 ]
[fe6946d0 : sbus_esp_map_sg+0xec/0xfc [sun_esp] ]
[fe684454 : esp_maybe_execute_command+0x1f0/0x6f8 [esp_scsi] ]
[fe6849e4 : esp_queuecommand+0x88/0x98 [esp_scsi] ]
[fe638c00 : scsi_dispatch_cmd+0x200/0x2a8 [scsi_mod] ]
[fe63f038 : scsi_request_fn+0x3f4/0x52c [scsi_mod] ]
[f00f6e28 : __generic_unplug_device+0x40/0x50 ]
[f00f6e54 : generic_unplug_device+0x1c/0x38 ]
[f00f4ca8 : blk_unplug+0x14/0x24 ]
[f00adf10 : sync_buffer+0x48/0x60 ]
[f01f7184 : __wait_on_bit+0x4c/0xa4 ]
[f01f728c : out_of_line_wait_on_bit+0xb0/0xc0 ]
[fe709320 : __ext3_get_inode_loc+0x3bc/0x418 [ext3] ]
[fe7093b4 : ext3_iget+0x38/0x65c [ext3] ]
[fe712c70 : ext3_get_journal+0xc/0xd4 [ext3] ]

f0007000 in kallsyms is:

f0007000 T trapbase_cpu3

which matches the error message.
