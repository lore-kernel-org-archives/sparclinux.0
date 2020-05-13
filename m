From: David Miller <davem@davemloft.net>
Date: Wed, 13 May 2020 21:58:20 +0000
Subject: Re: [PATCH 07/11] sparc64: constify sysrq_key_op
Message-Id: <20200513.145820.686713273456115128.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20200513214351.2138580-1-emil.l.velikov@gmail.com>
 <20200513214351.2138580-7-emil.l.velikov@gmail.com>
In-Reply-To: <20200513214351.2138580-7-emil.l.velikov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: emil.l.velikov@gmail.com
Cc: sparclinux@vger.kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, jslaby@suse.com

From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Wed, 13 May 2020 22:43:47 +0100

> With earlier commits, the API no longer discards the const-ness of the
> sysrq_key_op. As such we can add the notation.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>

Acked-by: David S. Miller <davem@davemloft.net>
