From: Robert Reif <reif@earthlink.net>
Date: Fri, 05 Jun 2009 12:12:13 +0000
Subject: Re: SILO & Ext4
Message-Id: <4A290B9D.2070200@earthlink.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a4423d670906010333x16cbae69g667a7441be2f140a@mail.gmail.com>
In-Reply-To: <a4423d670906010333x16cbae69g667a7441be2f140a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: Robert Reif <reif@earthlink.net>
> Date: Thu, 04 Jun 2009 22:49:25 -0400
>
>   
>> I'm looking at head_32.S and head_64.s to try and figure
>> out what's involved in making sparc32 relocatable but I'm
>> not sure what to look for. Any hints?
>>     
>
> You'll have to learn how to load kernel TLB entries for about 4 or 5
> different major TLB/cache types on sun4c, sun4m, and sun4d systems.
>   
Couldn't you do this using OBP in a HW independent way?
> This is what you need to do to relocate the kernel into a new location
> then jump to it.
>
>   
On sparc32, is the kernel always loaded in the lower 3 MB
of physical memory regardless of the amount of physical
memory and just left there?
