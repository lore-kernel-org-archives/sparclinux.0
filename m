From: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>
Date: Mon, 28 Mar 2016 05:44:03 +0000
Subject: Re: [PATCH 10/31] Add sparc-specific parity functions
Message-Id: <56F8C4A3.1070808@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1458788612-4367-1-git-send-email-zhaoxiu.zeng@gmail.com>
 <56F780FE.7000600@gmail.com>
 <20160327.224308.220596078048860811.davem@davemloft.net>
In-Reply-To: <20160327.224308.220596078048860811.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

在 2016年03月28日 10:43, David Miller 写道:
> From: "zhaoxiu.zeng" <zhaoxiu.zeng@gmail.com>
> Date: Sun, 27 Mar 2016 14:43:10 +0800
>
>> +
>> +/*
>> + * parityN: returns the parity of a N-bit word,
>> + * i.e. the number of 1-bits in x modulo 2.
>> + */
>> +
>> +#define __arch_parity4(w)	(__arch_hweight8((w) & 0xf) & 1)
>> +#define __arch_parity8(w)	(__arch_hweight8(w) & 1)
>> +#define __arch_parity16(w)	(__arch_hweight16(w) & 1)
>> +#define __arch_parity32(w)	(__arch_hweight32(w) & 1)
>> +#define __arch_parity64(w)	((unsigned int)__arch_hweight64(w) & 1)
> This looks like asm-generic/ material to me.

This is generic for the architectures which have popcount instruction,
but more higher costs than asm-generic/ for others.


