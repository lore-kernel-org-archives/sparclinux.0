From: "=?ISO-8859-1?Q?Fr=E9d=E9ric_Weisbecker?=" <fweisbec@gmail.com>
Date: Thu, 06 Nov 2008 13:10:09 +0000
Subject: Re: sparc boot failure
Message-Id: <c62985530811060510n2da72847tc5fc9e10b557a8a7@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <49125E98.8070905@earthlink.net>
In-Reply-To: <49125E98.8070905@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

2008/11/6 Robert Reif <reif@earthlink.net>:
> Fr=E9d=E9ric Weisbecker wrote:
>>
>> 2008/11/6 David Miller <davem@davemloft.net>:
>>
>>>
>>> From: Robert Reif <reif@earthlink.net>
>>> Date: Wed, 05 Nov 2008 22:03:52 -0500
>>>
>>>
>>>>
>>>> sparc has failed to boot recently and I bisected it down to this patch:
>>>>
>>>
>>>  ...
>>>
>>>>
>>>>  sparc: correct section of current_pc()
>>>>
>>>
>>>  ...
>>>
>>>>
>>>> Reverting this patch gets current git booting again.
>>>>
>>>
>>> Thanks for tracking this down.  I'll take a look and if I
>>> can't figure it out I'll revert.
>>>
>>
>>
>> Sorry, I will not have the time to look at it. But this bug is weird...
>> --
>> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>
> You can't change sections in the middle of a chunk of code.  The code abo=
ve
> current_pc: falls through to that label which is now in a different secti=
on.
>  Thats why you get an illegal instruction trap at bootup.
>

Oh ok, I understand...
