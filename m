From: David Miller <davem@davemloft.net>
Date: Thu, 03 Dec 2009 06:29:29 +0000
Subject: Re: [PATCH 0/3] sparc,leon: SPARC/LEON cleanup patches
Message-Id: <20091202.222929.112243970.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1259764222-1802-1-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1259764222-1802-1-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Wed,  2 Dec 2009 15:30:19 +0100

> These patches remove warnings and do some minor cleanup.
> 
> I dropped the idprom patch. We fake one in the boot loader.
> 
> Kristoffer Glembo (3):
>   sparc,leon: Added Aeroflex Gaisler in manufacturer_info structure
>   sparc32: Remove early interrupt enable.
>   sparc,leon: init_leon srmmu cleanup

Thanks a lot, all applied to sparc-next-2.6
