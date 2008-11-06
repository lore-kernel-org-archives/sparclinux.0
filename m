From: "=?ISO-8859-1?Q?Fr=E9d=E9ric_Weisbecker?=" <fweisbec@gmail.com>
Date: Thu, 06 Nov 2008 10:40:21 +0000
Subject: Re: sparc boot failure
Message-Id: <c62985530811060240x9efead5v43d73056c4fa942f@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <49125E98.8070905@earthlink.net>
In-Reply-To: <49125E98.8070905@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

2008/11/6 David Miller <davem@davemloft.net>:
> From: Robert Reif <reif@earthlink.net>
> Date: Wed, 05 Nov 2008 22:03:52 -0500
>
>> sparc has failed to boot recently and I bisected it down to this patch:
>  ...
>>  sparc: correct section of current_pc()
>  ...
>> Reverting this patch gets current git booting again.
>
> Thanks for tracking this down.  I'll take a look and if I
> can't figure it out I'll revert.


Sorry, I will not have the time to look at it. But this bug is weird...
