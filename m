From: Anatoly Pugachev <matorola@gmail.com>
Date: Mon, 09 Sep 2019 12:49:51 +0000
Subject: Re: [sparc64] Kernel unaligned access at TPC lzo1x_1_do_compress
Message-Id: <CADxRZqxOwPtaqiVyXR8hBf7VcDxZq5+w3E57YjaxEc=qS31AZQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqxmvfE9gYoT+1oLV6-o_BbUsay_U45qmMEYL3vErTCCLA@mail.gmail.com>
 <VI1PR0802MB252826995ECEA2578C1B5C878FB70@VI1PR0802MB2528.eurprd08.prod.outlook.com>
In-Reply-To: <VI1PR0802MB252826995ECEA2578C1B5C878FB70@VI1PR0802MB2528.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Rodgman <dave.rodgman@arm.com>
Cc: Sparc kernel list <sparclinux@vger.kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>

On Mon, Sep 9, 2019 at 1:11 PM Dave Rodgman <dave.rodgman@arm.com> wrote:
>
> Thanks Anatoly, I'll take a look at this. Could you please let me know the exact hardware you're running on?

Dave,

machine is a LDOM on T5-2 server.

OS is debian unstable/sid linux with latest git kernel, currently :

$ uname -a
Linux ttip 5.3.0-rc8-dirty #1211 SMP Mon Sep 9 10:20:40 MSK 2019
sparc64 GNU/Linux

-dirty cause non-mainline (yet) fix for IPC [1] and reverted
HAVE_GENERIC_GUP patch [2].

$ gcc --version
gcc (Debian 9.2.1-7) 9.2.1 20190905

$ ld -V
GNU ld (GNU Binutils for Debian) 2.32.51.20190821

$ ldd --version
ldd (Debian GLIBC 2.28-10) 2.28


I could give you  account on this box to test or fix kernel if you would like.

Thanks.

1. https://marc.info/?l=linux-kernel&m6769723218727
2. https://marc.info/?l=linux-sparc&m6026414826151
