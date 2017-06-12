From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 12 Jun 2017 19:55:44 +0000
Subject: Re: [v2 4/8] sparc64: optimize loads in clock_sched()
Message-Id: <47272358-9421-8b66-0c7d-6baf7273a665@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1497286107-974183-5-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1497286107-974183-5-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Dave,

Thank you for your comments:

When I use __cacheline_aligned instead of __aligned(64) I am getting the 
following error:

error: section of 'tick_operations' conflicts with previous declaration

The __section__ difference causes the issue:

__cacheline_aligned= __attribute__((__aligned__((1 << 6)), 
__section__(".data..cacheline_aligned")))

vs

__aligned(64) = __attribute__((aligned(64)))

Pasha

On 2017-06-12 15:06, David Miller wrote:
> From: Pavel Tatashin <pasha.tatashin@oracle.com>
> Date: Mon, 12 Jun 2017 12:48:23 -0400
> 
>> @@ -164,7 +164,7 @@ static unsigned long tick_add_tick(unsigned long adj)
>>   	return new_tick;
>>   }
>>   
>> -static struct sparc64_tick_ops tick_operations __read_mostly = {
>> +static struct sparc64_tick_ops tick_operations __aligned(64) __read_mostly = {
> 
> Please use __cacheline_aligned instead of "__aligned(64)"
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

