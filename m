From: Robert Reif <reif@earthlink.net>
Date: Wed, 03 Jun 2009 11:22:36 +0000
Subject: Re: SILO & Ext4
Message-Id: <4A265CFC.8000602@earthlink.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a4423d670906010333x16cbae69g667a7441be2f140a@mail.gmail.com>
In-Reply-To: <a4423d670906010333x16cbae69g667a7441be2f140a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: Robert Reif <reif@earthlink.net>
> Date: Tue, 02 Jun 2009 21:29:25 -0400
>
>   
>> David Miller wrote:
>>     
>>> All of my effort has been spent on adding sparc support to
>>> grub2.
>>>
>>>   
>>>       
>> Will it include sparc32 support?
>>     
>
> No.
>
>   
>> Will it increase the kernel size that can be loaded?
>>     
>
> The limit is now at 64MB on sparc64, isn't that enough?
>   
And what is the limit on sparc32?  The silo that comes
with debian etch will not load a kernel compiled with
the default configuration.  It hasn't for a long time.
Currently you have to disable virtually every option
just to get a kernel that loads.  Sparc32 has been
broken for a while because you can't load a kernel
that does anything.
