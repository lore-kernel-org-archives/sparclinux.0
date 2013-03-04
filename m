From: Daniel Hellstrom <daniel@gaisler.com>
Date: Mon, 04 Mar 2013 07:30:20 +0000
Subject: Re: [PATCH] sparc,leon: support for GRPCI1 PCI host bridge controller
Message-Id: <51344D8C.7080403@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1362061978-1964-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1362061978-1964-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 03/01/2013 10:39 PM, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Fri, 1 Mar 2013 19:51:46 +0100
>
>>>>>    	default y
>>>>>    +config GRPCI1
>>>> I see we do not do so with GRPCI2 - but please prefix
>>>> all SPARC specific kconfig symbols with SPARC_
>>> I can only see SPARC_LED and SPARC_LEON in arch/sparc/Kconfig following that naming convention.
>>>   Would it be more correct to call it LEON_GRPCI1? I see there are some SUN_ and US3_ names.
>> sparc is not a good example here :-(
>> For the new architectures I have reviewed recently all their arch specific symbols
>> has been prefixed with the abbreviated arch name.
>> And sparc specific symbols we add shall follow the same rule.
>>
>> I may fix up the other sparc specific symbols one day too, but it is low on
>> my todo list.
>> On the other hand using the name SPARC_LEON_xxx is too specific.
>> We already should know what it is from the SPARC_GRPCI part of the name.
> I agree with Sam, prefix all your new Kconfig symbols with SPARC_*, thanks.

Ok, that makes sense. I will update the two patches and resend.

Thanks,
Daniel
