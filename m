From: Willy Tarreau <w@1wt.eu>
Date: Tue, 19 Sep 2006 18:26:38 +0000
Subject: Re: Patch 2.4 kernel / allow to read more than 2048 (1821) Symbols from /boot/System.map
Message-Id: <20060919182638.GD3467@1wt.eu>
List-Id: <sparclinux.vger.kernel.org>
References: <DA6197CAE190A847B662079EF7631C06015692C9@OEKAW2EXVS03.hbi.ad.harman.com> <20060917.223512.25476592.davem@davemloft.net>
In-Reply-To: <20060917.223512.25476592.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: DJurzitza@harmanbecker.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

Hi David,

On Sun, Sep 17, 2006 at 10:35:12PM -0700, David Miller wrote:
> From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
> Date: Mon, 18 Sep 2006 07:23:58 +0200
> 
> > The 2.4 kernel series uses sys32_get_kernel_syms(struct kernel_sym32
> > *table) for reading the kernel symbols (on sparc64). The size of
> > struct kernel_sym is 64 byte on "normal" arches, but 72 byte on
> > sparc64.
> 
> Jurzita, you do not need to post this patch multiple times.
> I was simply on vacation for 2 weeks right after your first
> posting so I had no chance to review the patch.

BTW, did you finally review it (no emergency at all on my side) ?

Regards,
Willy

