From: Robert Reif <reif@earthlink.net>
Date: Sat, 10 Jan 2009 14:56:01 +0000
Subject: Re: sparc32 broke
Message-Id: <4968B701.7020001@earthlink.net>
List-Id: <sparclinux.vger.kernel.org>
References: <49669B15.7020107@earthlink.net>
In-Reply-To: <49669B15.7020107@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Sat, 10 Jan 2009 08:33:21 +0100
>
>   
>> The real fix should look like this:
>>
>> #ifdef __arch64__
>> #define _NSIG_BPW       64
>> #else
>> #define _NSIG_BPW       64
>> #endif
>>
>> This is required because this header is exported to userspace
>> where we do not have access to CONFIG_* symbols.
>>     
>
> I assume you meant to use "32" in the #else branch :-)
>
>   
This fixed it (with the 32).
