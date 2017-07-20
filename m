From: David Miller <davem@davemloft.net>
Date: Thu, 20 Jul 2017 22:01:58 +0000
Subject: Re: [PATCH] sparc64: prevent sunvdc panic when mpgroup disk added to guest domain
Message-Id: <20170720.230158.963296800355149608.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1500546590-109040-1-git-send-email-Jim.Quigley@oracle.com>
In-Reply-To: <1500546590-109040-1-git-send-email-Jim.Quigley@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jim Quigley <jim.quigley@oracle.com>
Date: Thu, 20 Jul 2017 21:19:52 +0100

> On 20/07/2017 20:35, David Miller wrote:
>>> +	if ((vdev->dev_no = port_data->dev_no) &&
>>> +	    (!(strcmp((char *)&vdev->type, port_data->type))) &&
>> vdev->type is a char pointer already, there is no need for this cast
>> and it's looks awful as well :-)
> 
>     vdev->type is defined as
> 
>                 char                    type[VIO_MAX_TYPE_LEN];
> 
>     and removing the cast results in :-
> 
> drivers/block/sunvdc.c: In function 'vdc_device_probed':
> drivers/block/sunvdc.c:891: warning: passing argument 1 of 'strcmp'
> from incompatible pointer type
> ./include/linux/string.h:42: note: expected 'const char *' but
> argument is of type 'char (*)[32]'

That's unfortunate, ok.

>>
>>> +		return 1;
>>> +	} else {
>>> +		return 0;
>> Please use "bool" as the return type and true/false here.
> 
>     It needs to be an int for device_find_child().

Ok.

