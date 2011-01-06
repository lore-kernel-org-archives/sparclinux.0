From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Thu, 06 Jan 2011 14:33:02 +0000
Subject: Re: [PATCH v2] cassini: Use local-mac-address prom property for	Cassini
Message-Id: <4D25D29E.3010806@oldelvet.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <1294321167.6193.69.camel@duncow>
In-Reply-To: <1294321167.6193.69.camel@duncow>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On 06/01/2011 14:08, Sam Ravnborg wrote:
> On Thu, Jan 06, 2011 at 01:39:27PM +0000, Richard Mortimer wrote:
>> +#if defined(CONFIG_OF)
>> +#include<linux/of.h>
>> +#include<linux/of_device.h>
>> +#endif
>
> The ifdefs are not required - the files include these already.
>
> 	Sam

Ah yes you are right thanks. v3 on its way soon.

Richard
