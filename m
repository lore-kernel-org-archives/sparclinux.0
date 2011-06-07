From: David Miller <davem@davemloft.net>
Date: Tue, 07 Jun 2011 23:07:37 +0000
Subject: Re: [PATCH 0/3] Bugfixes for sun4d after genirq changes
Message-Id: <20110607.160737.2230584578166992370.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.1106012201440.16937@oizys.tordivel.org>
In-Reply-To: <Pine.LNX.4.64.1106012201440.16937@oizys.tordivel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kjetil Oftedal <oftedal@gmail.com>
Date: Wed, 1 Jun 2011 22:29:31 +0200 (CEST)

> 
> This patch set fixes some sun4d specific bugs introduced by the changes 
> performed during the introduction of genirq for sparc32 
> (6baa9b20a68a88c2fd751cbe8d7652009379351b)
> These changes allows for sun4d based systems to boot without crashing or 
> enter eternal loops:
> - Restructuring of sun4d_build_device_irq
> - Bugfixes in communication with interrupt controllers
> - Add irq support for bootbus devices

Thanks for doing this work, all applied.
