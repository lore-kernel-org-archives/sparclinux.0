From: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>
Date: Thu, 07 Apr 2016 03:56:08 +0000
Subject: Re: [PATCH v2 08/30] Add sparc-specific parity functions
Message-Id: <5705DA58.3040207@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <57031D9D.801@gmail.com>
 <1459933647-6940-1-git-send-email-zengzhaoxiu@163.com>
 <20160406184447.GA5963@ravnborg.org>
In-Reply-To: <20160406184447.GA5963@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Sam Ravnborg <sam@ravnborg.org>, zengzhaoxiu@163.com
Cc: davem@davemloft.net, wim.coekaerts@oracle.com, linux@roeck-us.net, julian.calaby@gmail.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

在 2016年04月07日 02:44, Sam Ravnborg 写道:
> Hi Zeng.
>
>> Use runtime patching for sparc64, lifted from hweight
> No errors found in patch - but a few comments.
> In general patch looks good.

Thanks. Sparc, powerpc, and x86 are all new to me.

>> +++ b/arch/sparc/include/asm/bitops_64.h
>> @@ -47,6 +47,24 @@ unsigned int __arch_hweight16(unsigned int w);
>>   unsigned int __arch_hweight8(unsigned int w);
>>   
>>   #include <asm-generic/bitops/const_hweight.h>
>> +
>> +/*
>> + * parityN: returns the parity of a N-bit word,
>> + * i.e. the number of 1-bits in w modulo 2.
>> + */
>> +
>> +static inline unsigned int __arch_parity4(unsigned int w)
>> +{
>> +	w &= 0xf;
>> +	return (0x6996 >> w) & 1;
>> +}
> As Josef already said - this constant should have a name.
> PARITY_BIT
> ?
>

Maybe PARITY_MAGIC?

>> +++ b/arch/sparc/kernel/sparc_ksyms_64.c
>> @@ -45,6 +45,12 @@ EXPORT_SYMBOL(__arch_hweight16);
>>   EXPORT_SYMBOL(__arch_hweight32);
>>   EXPORT_SYMBOL(__arch_hweight64);
>>   
>> +/* from parity.S */
>> +EXPORT_SYMBOL(__arch_parity8);
>> +EXPORT_SYMBOL(__arch_parity16);
>> +EXPORT_SYMBOL(__arch_parity32);
>> +EXPORT_SYMBOL(__arch_parity64);
> Did you compile this?
> I wonder if bitops_64.h is indirectly included.

Yes.

>> index 0000000..b1945e3
>> --- /dev/null
>> +++ b/arch/sparc/lib/parity.S
>> @@ -0,0 +1,93 @@
>> +#include <linux/linkage.h>
>> +
>> +	.text
>> +	.align	32
>> +
>> +ENTRY(__arch_parity8)
>> +	srl		%o0, 4, %g1
>> +	xor		%o0, %g1, %o0
>> +	and		%o0, 0xf, %o0
>> +	sethi		%hi(0x6996), %g1
>> +	or		%g1, %lo(0x6996), %g1
>> +	srl		%g1, %o0, %o0
>> +	retl
>> +	 and		%o0, 1, %o0
>> +ENDPROC(__arch_parity8)
> I know the level of comments in hweight is equal to none.
> But please do not follow this bad example.
> At least for each function a one-liner of the C code.
> And in the top of the file maybe two lines that the functions
> are patched at run-time if the processor has popc available.
>
>
> 	Sam

OK. I will try, but my english is very poor! :-)

