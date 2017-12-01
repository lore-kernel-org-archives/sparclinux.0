From: Eric Saint Etienne <eric.saint.etienne@oracle.com>
Date: Fri, 01 Dec 2017 20:37:15 +0000
Subject: Re: [PATCH] sparc64: Expose mdesc to sysfs
Message-Id: <1ffa7ea7-6771-2fe4-20a7-15e0fad14594@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
In-Reply-To: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Dave,

Can you please provide me with an example of an actual mdesc entry that 
needs sanitization? I believe you are thinking of passwords and crypto 
keys but I couldn't find any such entry on any machine I have access to.

It makes sense for this mdesc sysfs module to use the same level of 
sanitization that has been used for so many years for /dev/mdesc without 
any problem.

Regarding the machine description format specification url, what 
specification document did you use or share with the community when you 
initially wrote and upstreamed mdesc.c? Certainly the same document 
could be used for this module as the format hasn't changed since then.

Thank you.

Kind Regards,

-eric


On 01/12/17 19:46, David Miller wrote:
> From: Eric Saint Etienne <eric.saint.etienne@oracle.com>
> Date: Fri, 1 Dec 2017 17:15:13 +0000
>
>> Do you have any concern with this patch?
> I'm just wondering if the blacklist of sensitive nodes is complete and
> also futureproof.
>
> That's my first concern.
>
> Also the hypervisor specification URL is completely non-functional,
> the kenai.com stuff went down years ago.
>
> It's pretty rediculous for me to include code written to a
> specification nobody can access and check against the implementation.

