From: David Miller <davem@davemloft.net>
Date: Wed, 29 Nov 2017 20:06:56 +0000
Subject: Re: sparc64: git kernel 4.14.0-12995-g0c86a6bd85ff does not boot
Message-Id: <20171129.150656.1716401720689579244.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqxRB=G4+QwYasS0a7GJA-4WJW13NQTm-oEt8QrHgZixSQ@mail.gmail.com>
In-Reply-To: <CADxRZqxRB=G4+QwYasS0a7GJA-4WJW13NQTm-oEt8QrHgZixSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Anatoly Pugachev <matorola@gmail.com>
Date: Wed, 29 Nov 2017 23:05:19 +0300

> On Wed, Nov 29, 2017 at 10:37 PM, David Miller <davem@davemloft.net> wrote:
>>
>> Anatoly, please try this patch:
>>
>> diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
>> index 0f0f76b..063556f 100644
>> --- a/arch/sparc/lib/Makefile
>> +++ b/arch/sparc/lib/Makefile
>> @@ -19,7 +19,7 @@ lib-$(CONFIG_SPARC32) += muldi3.o bitext.o cmpdi2.o
>>  lib-$(CONFIG_SPARC64) += multi3.o
>>  lib-$(CONFIG_SPARC64) += fls.o
>>  lib-$(CONFIG_SPARC64) += fls64.o
>> -obj-$(CONFIG_SPARC64) += NG4fls.o
>> +lib-$(CONFIG_SPARC64) += NG4fls.o
>>
>>  lib-$(CONFIG_SPARC64) += copy_page.o clear_page.o bzero.o
>>  lib-$(CONFIG_SPARC64) += csum_copy.o csum_copy_from_user.o csum_copy_to_user.o
> 
> 
> Yes, this patch fixes problem. Thanks.

Thanks, I'll push this upstream.
