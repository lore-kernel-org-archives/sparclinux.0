From: Anatoly Pugachev <matorola@gmail.com>
Date: Sun, 08 Sep 2019 10:58:08 +0000
Subject: [sparc64] Kernel unaligned access at TPC lzo1x_1_do_compress
Message-Id: <CADxRZqxmvfE9gYoT+1oLV6-o_BbUsay_U45qmMEYL3vErTCCLA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sparc kernel list <sparclinux@vger.kernel.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>

Hello!

trying to use zram block device, shows the following:

# zramctl -f -s 16g
# cat /sys/block/zram0/comp_algorithm
lzo [lzo-rle] lz4 lz4hc 842 zstd
# zramctl
NAME       ALGORITHM DISKSIZE  DATA COMPR TOTAL STREAMS MOUNTPOINT
/dev/zram0 lzo-rle        16G 10.4M    4K  112K      32

# mkfs.xfs /dev/zram0
...

[   71.095998] zram: Added device: zram0
[   71.765591] zram0: detected capacity change from 0 to 17179869184
[   80.058772] Kernel unaligned access at TPC[8f2534]
lzo1x_1_do_compress+0x1b4/0x820
[   80.073832] Kernel unaligned access at TPC[8f2534]
lzo1x_1_do_compress+0x1b4/0x820
[   80.073866] Kernel unaligned access at TPC[8f2534]
lzo1x_1_do_compress+0x1b4/0x820
[   80.074709] Kernel unaligned access at TPC[8f2534]
lzo1x_1_do_compress+0x1b4/0x820
[   80.074923] Kernel unaligned access at TPC[8f2534]
lzo1x_1_do_compress+0x1b4/0x820


all other tested compression algorithms (lzo, lz4, lz4hc, deflate,
842) work without producing kernel TPC.
