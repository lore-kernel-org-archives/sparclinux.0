From: David Miller <davem@davemloft.net>
Date: Wed, 26 Oct 2016 15:54:51 +0000
Subject: Re: [PATCH] sparc64: Handle extremely large kernel TSB range flushes sanely.
Message-Id: <20161026.115451.1644074317156100303.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20161025.224442.1417439049113609110.davem@davemloft.net>
In-Reply-To: <20161025.224442.1417439049113609110.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: James Clarke <jrtc27@jrtc27.com>
Date: Wed, 26 Oct 2016 09:28:05 +0100

> Any progress on TLB flushing?

I was half-way through an implementation when I noticed that
hypervisor TLB flush handler relative branch bug I posted the
fix for last night.

I'll keep plugging away at it today.
