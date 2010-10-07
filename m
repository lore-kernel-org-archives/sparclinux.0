From: David Miller <davem@davemloft.net>
Date: Thu, 07 Oct 2010 06:41:28 +0000
Subject: Re: sun4v_intr_settarget() return HV_EINVAL
Message-Id: <20101006.234128.27821310.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201009291530.45792.alexvm12e@mail.ru>
In-Reply-To: <201009291530.45792.alexvm12e@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Alex <alexvm12e@mail.ru>
Date: Mon, 4 Oct 2010 17:36:15 +0400

>> It's not enough, I need to see the entire openfirmware device tree.
>>
>> Please get a copy of prtconf, built it from source if you have to, so
>> you can dump the information that I need.
> 
> OK, prtconf from sparc-utils-1.9 (see attached file, please).

The output is garbled and unusable, many of the property names are
missing before the ":" character.

Please also be sure to use "prtconf -pv".

And also do not encode the attachment in KOI8-R like it was this
time, use binary if you have to.

Thanks.

