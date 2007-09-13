From: Sunil Amitkumar Janki <devel.sjanki@gmail.com>
Date: Thu, 13 Sep 2007 11:35:37 +0000
Subject: Re: Is Sun putting much effort into supporting the gcc/binutils toolchain
Message-Id: <46E92089.2050604@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <46E7CF5F.3090909@walrond.org>
In-Reply-To: <46E7CF5F.3090909@walrond.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Andrew Walrond wrote:
> Andrew Walrond wrote:
>   
>> David Miller wrote:
>>     
>>> That's correct, it's essentially GCC's language front ends
>>> plugged into Sun's compiler backend.
>>> -
>>>       
>> And presumably is solaris only doesn't work under gnu/linux?
>>
>>     
>
> Sorry; that is thinko/typo/horrible. What I actually meant:
>
> Presumably the gccfss/scgfss is only available for solaris and not
> gnu/linux?
>
>   
>> Andrew Walrond
>>     
>
>
>   

Sun Studio is available for Solaris and GNU/Linux x86 and Solaris SPARC.

GCC for SPARC is a front end to this compiler, which isn't available
for Linux/SPARC so not really useful at all. If Sun Studio were available
for GNU/Linux SPARC this front end would probably function the same as
on Solaris, maybe even without any changes at all.

I don't know if the source code to this front end has been released in the
open or if it is even useful to the GCC project in general and to GNU/Linux
on SPARC in particular.

Sunil

