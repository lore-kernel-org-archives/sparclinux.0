From: David Miller <davem@davemloft.net>
Date: Mon, 28 Mar 2016 02:43:08 +0000
Subject: Re: [PATCH 10/31] Add sparc-specific parity functions
Message-Id: <20160327.224308.220596078048860811.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1458788612-4367-1-git-send-email-zhaoxiu.zeng@gmail.com>
	<56F780FE.7000600@gmail.com>
In-Reply-To: <56F780FE.7000600@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: zhaoxiu.zeng@gmail.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: "zhaoxiu.zeng" <zhaoxiu.zeng@gmail.com>
Date: Sun, 27 Mar 2016 14:43:10 +0800

> +
> +/*
> + * parityN: returns the parity of a N-bit word,
> + * i.e. the number of 1-bits in x modulo 2.
> + */
> +
> +#define __arch_parity4(w)	(__arch_hweight8((w) & 0xf) & 1)
> +#define __arch_parity8(w)	(__arch_hweight8(w) & 1)
> +#define __arch_parity16(w)	(__arch_hweight16(w) & 1)
> +#define __arch_parity32(w)	(__arch_hweight32(w) & 1)
> +#define __arch_parity64(w)	((unsigned int)__arch_hweight64(w) & 1)

This looks like asm-generic/ material to me.
