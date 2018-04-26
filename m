From: Christoph Hellwig <hch@lst.de>
Date: Thu, 26 Apr 2018 08:24:29 +0000
Subject: Re: [PATCH 13/22] nds32: use generic dma_noncoherent_ops
Message-Id: <20180426082429.GA15580@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180420080313.18796-1-hch@lst.de> <20180420080313.18796-14-hch@lst.de> <CAEbi=3fkakVD2vxGu6SgJM77JnNM8Y79xS8_o6m9d_85BJpMFQ@mail.gmail.com> <20180424191640.GA32495@lst.de> <CAEbi=3f7yzE+KAM2GOh6QahC_E6BAUfB3ys3U-WdBSUf3DPZqg@mail.gmail.com> <20180425064055.GA11460@lst.de> <CAEbi=3fcd8E=xi_hbef45LnPsBZhZv37yPO-xfZmU1gMaWnDvg@mail.gmail.com> <20180426064239.GA13895@lst.de> <CAEbi=3e3gM_WpQOtKZXP4Xj2Az4bLf_u6BjDELqXy6-d9HurMQ@mail.gmail.com>
In-Reply-To: <CAEbi=3e3gM_WpQOtKZXP4Xj2Az4bLf_u6BjDELqXy6-d9HurMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greentime Hu <green.hu@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-arch <linux-arch@vger.kernel.org>, Michal Simek <monstr@monstr.eu>, Vincent Chen <deanbo422@gmail.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>, linux-xtensa@linux-xtensa.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Apr 26, 2018 at 04:06:34PM +0800, Greentime Hu wrote:
> It works!!!

Thanks!

Can you retest the updated tree here with all the fixes and give me
your Tested-by: for the generic and nds32 patches?

git://git.infradead.org/users/hch/misc.git generic-dma-noncoherent
