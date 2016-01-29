From: Wim Coekaerts <wim.coekaerts@oracle.com>
Date: Fri, 29 Jan 2016 00:35:56 +0000
Subject: Re: [PATCH v6] Add sun4v_wdt watchdog driver
Message-Id: <56AAB3EC.6070802@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1454017572-5235-1-git-send-email-wim.coekaerts@oracle.com>
 <CAGRGNgWKzomgV2199r_Ym-DbGpeHz5dLwcWkC5-Lz+pftqBF9g@mail.gmail.com>
 <56AA9BDF.6070907@oracle.com> <56AAB157.3070809@roeck-us.net>
In-Reply-To: <56AAB157.3070809@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>, Julian Calaby <julian.calaby@gmail.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>


On 1/28/16 4:24 PM, Guenter Roeck wrote:
> On 01/28/2016 02:53 PM, Wim Coekaerts wrote:
>> On 01/28/2016 02:50 PM, Julian Calaby wrote:
>>> Hi Wim,
>>>
>>> Sorry to keep iterating on this, but I noticed two small things you
>>> could improve:
>>
>> yeah I was considering that although it makes the code a bit more 
>> readable but
>> fine happy to tweak that. no problem.
>>
>> the static is definitely no longer needed after all the cleanup that 
>> happened.
>>
>
> It would be great if you can drop the static. I'll leave the other one 
> for you
> to decide; I was 50/50 on it myself. I don't have any further comments 
> (assuming
> you ran the patch through checkpatch).
>
> Thanks,
> Guenter
>

awesome I will drop the static. I did run through checkpatch. all good 
there :)

I'll sleep on the value one. :)

Thanks!
Wim
