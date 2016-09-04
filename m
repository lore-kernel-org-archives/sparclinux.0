From: Daniel Borkmann <daniel@iogearbox.net>
Date: Sun, 04 Sep 2016 17:04:12 +0000
Subject: Re: Clarification for source code formatting around jump labels
Message-Id: <57CC540C.6070701@iogearbox.net>
List-Id: <sparclinux.vger.kernel.org>
References: <57CAFFDC.4030606@iogearbox.net> <20160903.230607.1667562673788737377.davem@davemloft.net> <1365a588-c7c7-717c-1e3d-ceabd71e8479@users.sourceforge.net> <20160903.235916.1892276070318494855.davem@davemloft.net> <deecaab4-011b-b8d5-a3c7-6e34abef60e5@users.sourceforge.net> <57CBEFEA.3080007@iogearbox.net> <50edcf58-112e-0b89-4265-7c39d2f147ca@users.sourceforge.net>
In-Reply-To: <50edcf58-112e-0b89-4265-7c39d2f147ca@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Jonathan Corbet <corbet@lwn.net>, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, Adam Buchbinder <adam.buchbinder@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Rabin Vincent <rabin@rab.in>, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>, linux-doc@vger.kernel.org, Jean Delvare <jdelvare@suse.de>

On 09/04/2016 03:50 PM, SF Markus Elfring wrote:
>>> I am just curious on how much further software development "fun" the re=
cent update
>>> by a topic like "CodingStyle: Clarify and complete chapter 7" will trig=
ger.
>>
>> I don't want to drag this thread onwards for (way) too long, but clearly=
 "it is
>> advised to indent labels with a single space (not tab)" (from diff in ab=
ove commit)
>
> How do you think about the reason (which you omitted from your quotation)=
 for this advice?
>
> =93=85,
> so that "diff -p" does not confuse labels with functions.
> =85=94

Yep, since this recently came up in a different thread as well, please
see here, for example:

   http://patchwork.ozlabs.org/patch/664966/

>> doesn't really reflect the majority of kernel practice we have in-tree t=
oday and
>> actually rather adds more confusion than any clarification whatsoever:
>>
>>    $ git grep -n "^\ [a-z_]*:" -- '*.[ch]' | wc -l
>>    4919
>>    $ git grep -n "^[a-z_]*:" -- '*.[ch]' | wc -l
>>    54686
>
> So there is a mixture already.
>
[...]
> In which ways would you prefer that the style specifications should be
> clarified further?
>
> Where should source code become more consistent?

It would likely make sense to document that git config mentioned in the
link above as a recommendation for that paragraph, and stick with what
is used in the vast majority of cases already, meaning no leading space
before labels.
