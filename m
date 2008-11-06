From: Robert Reif <reif@earthlink.net>
Date: Thu, 06 Nov 2008 11:44:59 +0000
Subject: Re: sparc boot failure
Message-Id: <4912D8BB.3070904@earthlink.net>
List-Id: <sparclinux.vger.kernel.org>
References: <49125E98.8070905@earthlink.net>
In-Reply-To: <49125E98.8070905@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Fr=E9d=E9ric Weisbecker wrote:
> 2008/11/6 David Miller <davem@davemloft.net>:
>  =20
>> From: Robert Reif <reif@earthlink.net>
>> Date: Wed, 05 Nov 2008 22:03:52 -0500
>>
>>    =20
>>> sparc has failed to boot recently and I bisected it down to this patch:
>>>      =20
>>  ...
>>    =20
>>>  sparc: correct section of current_pc()
>>>      =20
>>  ...
>>    =20
>>> Reverting this patch gets current git booting again.
>>>      =20
>> Thanks for tracking this down.  I'll take a look and if I
>> can't figure it out I'll revert.
>>    =20
>
>
> Sorry, I will not have the time to look at it. But this bug is weird...
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>  =20
You can't change sections in the middle of a chunk of code.  The code=20
above current_pc: falls through to that label which is now in a=20
different section.  Thats why you get an illegal instruction trap at bootup.
