From: David Miller <davem@davemloft.net>
Date: Fri, 15 Jan 2010 00:58:47 +0000
Subject: Re: [PATCH] sparc: leds_resource.end assigned to itself in
Message-Id: <20100114.165847.126963317.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4B4F4C9B.9040202@gmail.com>
In-Reply-To: <4B4F4C9B.9040202@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: roel.kluin@gmail.com
Cc: sparclinux@vger.kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org

From: Roel Kluin <roel.kluin@gmail.com>
Date: Thu, 14 Jan 2010 17:55:55 +0100

> These statements appear redundant.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> Is there any reason to assign this to itself?

It's a bug, let me try and figure out what this code is trying
to do.
