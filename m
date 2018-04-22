From: Tom Hromatka <tom.hromatka@oracle.com>
Date: Sun, 22 Apr 2018 21:52:49 +0000
Subject: Re: [PATCH v4 1/2] char: sparc64: Add privileged ADI driver
Message-Id: <7241fc77-c38c-abdb-d8dc-4b22dac36895@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180420205221.488589-1-tom.hromatka@oracle.com>
 <20180420205221.488589-2-tom.hromatka@oracle.com>
 <20180421090449.GA8194@kroah.com>
In-Reply-To: <20180421090449.GA8194@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org



On 04/21/2018 03:04 AM, Greg KH wrote:
> On Fri, Apr 20, 2018 at 02:52:20PM -0600, Tom Hromatka wrote:
>> --- /dev/null
>> +++ b/drivers/char/adi.c
>> @@ -0,0 +1,240 @@
>> +// SPDX-License-Identifier: GPL-2.0
> Good, but:
>
>> +MODULE_LICENSE("GPL");
> That's the wrong line :(
>
> Read include/linux/module.h for the correct string to put here for a
> GPL version 2 only module.
>

<Tom hangs his head in shame>

My sincerest apologies, Greg.=C2=A0 I'll follow the guidance from
the aforementioned file and re-re-submit the patch tomorrow :(.

Thanks so much for your patience.

Regards,

Tom
