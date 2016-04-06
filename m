From: Josip Rodin <joy@entuzijast.net>
Date: Wed, 06 Apr 2016 16:37:55 +0000
Subject: Re: [PATCH v2 08/30] Add sparc-specific parity functions
Message-Id: <20160406163755.GA12117@entuzijast.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1459933647-6940-1-git-send-email-zengzhaoxiu@163.com>
In-Reply-To: <1459933647-6940-1-git-send-email-zengzhaoxiu@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Apr 06, 2016 at 05:07:27PM +0800, zengzhaoxiu@163.com wrote:
> +static inline unsigned int __arch_parity4(unsigned int w)
> +	return (0x6996 >> w) & 1;

> +ENTRY(__arch_parity8)
> +	sethi		%hi(0x6996), %g1
> +	or		%g1, %lo(0x6996), %g1

> +ENTRY(__arch_parity16)
> +	sethi		%hi(0x6996), %g1
> +	or		%g1, %lo(0x6996), %g1

> +ENTRY(__arch_parity32)
> +	sethi		%hi(0x6996), %g1
> +	or		%g1, %lo(0x6996), %g1

> +ENTRY(__arch_parity64)
> +	sethi		%hi(0x6996), %g1
> +	or		%g1, %lo(0x6996), %g1

Given how many times the magic constant is repeated, maybe it would make
sense to give it a name?

-- 
     2. That which causes joy or happiness.
