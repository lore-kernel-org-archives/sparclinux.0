From: Konrad Eisele <konrad@gaisler.com>
Date: Wed, 18 Apr 2012 06:33:19 +0000
Subject: Re: failing kthread_create_on_node()
Message-Id: <4F8E602F.7060907@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4F8BED36.7000304@gaisler.com>
In-Reply-To: <4F8BED36.7000304@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: Konrad Eisele<konrad@gaisler.com>
> Date: Tue, 17 Apr 2012 08:37:50 +0200
>
>> 2. What happens next
>>
>>     CPU1 will boot up and execute schedule().
>>     ...
>>     ->  kernel/core.c:__schedule()
>
> The stop thread doesn't actually run immediately when it is created,
> so will need to be woken up to be scheduled and run.
>
> At wakeup time, set_task_cpu() should fix things up and make the
> task have a correct ->cpu in it's thread_info.
>
> I wonder if one of the sparc32 global cpu masks isn't being
> initialized properly.

Ok, thanks. I'll investigate in that direction.

> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

