From: walter harms <wharms@bfs.de>
Date: Mon, 29 Aug 2016 11:57:41 +0000
Subject: Re: [PATCH 1/2] sparc: Use kmalloc_array() in three functions
Message-Id: <57C42335.5000106@bfs.de>
List-Id: <sparclinux.vger.kernel.org>
References: <0ca0235c-ddb9-0534-3bde-b4aaa48da92e@users.sourceforge.net> <fbdf6d83-08ac-a6b2-1674-53bc86c69ae8@users.sourceforge.net> <4475e65d-415d-9cde-1fe1-c17e120849c4@redhat.com>
In-Reply-To: <4475e65d-415d-9cde-1fe1-c17e120849c4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>, sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>



Am 29.08.2016 11:47, schrieb Paolo Bonzini:
> 
> 
> On 25/08/2016 10:22, SF Markus Elfring wrote:
>> --- a/arch/sparc/kernel/led.c
>> +++ b/arch/sparc/kernel/led.c
>> @@ -69,7 +69,7 @@ static ssize_t led_proc_write(struct file *file, const char __user *buffer,
>>  	if (count > LED_MAX_LENGTH)
>>  		count = LED_MAX_LENGTH;
>>  
>> -	buf = kmalloc(sizeof(char) * (count + 1), GFP_KERNEL);
>> +	buf = kmalloc_array(count + 1, sizeof(*buf), GFP_KERNEL);
>>  	if (!buf)
>>  		return -ENOMEM;
>>  
> 
> Here it's probably best to just remove sizeof(char) completely, as it's
> 1 by definition.
> 
> Paolo


I would not do so, if you ever change buf to something else it would break,
having a sizeof(*buf) here is harmless and a known pattern.

re,
 wh
