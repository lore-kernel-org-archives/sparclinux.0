From: David Miller <davem@davemloft.net>
Date: Wed, 26 Oct 2016 02:12:10 +0000
Subject: Re: Regression with 4.7.2 on sun4u
Message-Id: <20161025.221210.2111791233077964365.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <3fc12066-505b-5f87-cbbe-88593a736162@physik.fu-berlin.de>
In-Reply-To: <3fc12066-505b-5f87-cbbe-88593a736162@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: James Clarke <jrtc27@jrtc27.com>
Date: Tue, 25 Oct 2016 01:10:55 +0100

> Sure, that makes sense; updated and tested for a few hours:
> 
> From d5997fd98fc80d1ceabe11f6fcd63dfce99b8253 Mon Sep 17 00:00:00 2001
> From: James Clarke <jrtc27@jrtc27.com>
> Date: Mon, 24 Oct 2016 19:49:25 +0100
> Subject: [PATCH v2] sparc: Handle negative offsets in
>  arch_jump_label_transform
> 
> Additionally, if the offset will overflow the immediate for a ba,pt
> instruction, fall back on a standard ba to get an extra 3 bits.
> 
> Signed-off-by: James Clarke <jrtc27@jrtc27.com>

Applied, thanks.
