From: Robert Reif <reif@earthlink.net>
Date: Fri, 05 Jun 2009 02:49:25 +0000
Subject: Re: SILO & Ext4
Message-Id: <4A2887B5.8070308@earthlink.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a4423d670906010333x16cbae69g667a7441be2f140a@mail.gmail.com>
In-Reply-To: <a4423d670906010333x16cbae69g667a7441be2f140a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: Robert Reif <reif@earthlink.net>
> Date: Wed, 03 Jun 2009 07:22:36 -0400
>
>   
>> David Miller wrote:
>>     
>>> The limit is now at 64MB on sparc64, isn't that enough?
>>>   
>>>       
>> And what is the limit on sparc32?
>>     
>
> I have no idea, to be honest with you.
>
>   
It looks like it's between 2.4 and 2.6 MB depending on
the source.

I found a 2 year old patch to silo that loads the kernel
above 4 MB like sparc64 but the sparc32 kernel is not
relocatable. It loads fine but then tries to move it down
low where it wants to be and fails because there isn't
enough space.

SILO Version 1.4.14
boot:
Allocated 64 Megs of memory at 0x3FFFC000 for kernel
Uncompressing image...
Your kernel cannot fit into the memory destination. This
can be resolved by recompiling the kernel with more devices
built as modules, or upgrading your kernel to one that
supports being loaded to higher memory areas (currently
2.6.3+ or 2.4.26+).
boot:

I'm looking at head_32.S and head_64.s to try and figure
out what's involved in making sparc32 relocatable but I'm
not sure what to look for. Any hints?
