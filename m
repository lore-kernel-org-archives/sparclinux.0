From: Dave Rodgman <dave.rodgman@arm.com>
Date: Mon, 09 Sep 2019 10:10:50 +0000
Subject: Re: [sparc64] Kernel unaligned access at TPC lzo1x_1_do_compress
Message-Id: <VI1PR0802MB252826995ECEA2578C1B5C878FB70@VI1PR0802MB2528.eurprd08.prod.outlook.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqxmvfE9gYoT+1oLV6-o_BbUsay_U45qmMEYL3vErTCCLA@mail.gmail.com>
In-Reply-To: <CADxRZqxmvfE9gYoT+1oLV6-o_BbUsay_U45qmMEYL3vErTCCLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anatoly Pugachev <matorola@gmail.com>, Sparc kernel list <sparclinux@vger.kernel.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>

Thanks Anatoly, I'll take a look at this. Could you please let me know the exact hardware you're running on?

thanks

Dave

________________________________________
From: linux-kernel-owner@vger.kernel.org <linux-kernel-owner@vger.kernel.org> on behalf of Anatoly Pugachev <matorola@gmail.com>
Sent: 08 September 2019 11:58:08
To: Sparc kernel list
Cc: Linux Kernel list
Subject: [sparc64] Kernel unaligned access at TPC lzo1x_1_do_compress

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
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
