From: Anatoly Pugachev <matorola@gmail.com>
Date: Sun, 28 Jul 2019 20:00:56 +0000
Subject: Re: [PATCH 09/16] sparc64: use the generic get_user_pages_fast code
Message-Id: <CADxRZqwv_TUkGsbS5vHsdGXMadjf3MjYbW7WUPEenpa=iSo6PQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqx-jEnm4U8oe=tJf5apbvcMuw5OYZUN8h4G68sXFvDsmQ@mail.gmail.com>
 <20190724.131324.1545677795217357026.davem@davemloft.net> <CADxRZqw0oCpw=wKUrFTOJF1dUKrCU6k5MQXj3tVGachu4zPcgw@mail.gmail.com>
 <20190727.190929.2229738632787796180.davem@davemloft.net>
In-Reply-To: <20190727.190929.2229738632787796180.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: "Dmitry V. Levin" <ldv@altlinux.org>, Christoph Hellwig <hch@lst.de>, Khalid Aziz <khalid.aziz@oracle.com>, torvalds@linux-foundation.org, akpm@linux-foundation.org, Sparc kernel list <sparclinux@vger.kernel.org>, linux-mm@kvack.org, Linux Kernel list <linux-kernel@vger.kernel.org>

On Sun, Jul 28, 2019 at 5:09 AM David Miller <davem@davemloft.net> wrote:
> From: Anatoly Pugachev <matorola@gmail.com>
> Date: Thu, 25 Jul 2019 21:33:24 +0300
> > there's vmlinuz-5.3.0-rc1 kernel and archive 5.3.0-rc1-modules.tar.gz
> > of /lib/modules/5.3.0-rc1/
> > this is from oracle sparclinux LDOM , compiled with 7.4.0 gcc
>
> Please, I really really need the unstripped kernel image with all the
> symbols.  This vmlinuz file is stripped already.  The System.map does
> not serve as a replacement.

David,

http://u164.east.ru/kernel2/

I'm sorry missed debug kernel first. Enabled CONFIG_DEBUG_INFO=y
