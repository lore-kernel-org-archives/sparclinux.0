From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 04 Sep 2016 13:50:25 +0000
Subject: Re: Clarification for source code formatting around jump labels
Message-Id: <50edcf58-112e-0b89-4265-7c39d2f147ca@users.sourceforge.net>
List-Id: <sparclinux.vger.kernel.org>
References: <57CAFFDC.4030606@iogearbox.net>
 <20160903.230607.1667562673788737377.davem@davemloft.net>
 <1365a588-c7c7-717c-1e3d-ceabd71e8479@users.sourceforge.net>
 <20160903.235916.1892276070318494855.davem@davemloft.net>
 <deecaab4-011b-b8d5-a3c7-6e34abef60e5@users.sourceforge.net>
 <57CBEFEA.3080007@iogearbox.net>
In-Reply-To: <57CBEFEA.3080007@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jonathan Corbet <corbet@lwn.net>, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, Adam Buchbinder <adam.buchbinder@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Rabin Vincent <rabin@rab.in>, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>, linux-doc@vger.kernel.org, Jean Delvare <jdelvare@suse.de>

>> I am just curious on how much further software development "fun" the rec=
ent update
>> by a topic like "CodingStyle: Clarify and complete chapter 7" will trigg=
er.
>=20
> I don't want to drag this thread onwards for (way) too long, but clearly =
"it is
> advised to indent labels with a single space (not tab)" (from diff in abo=
ve commit)

How do you think about the reason (which you omitted from your quotation) f=
or this advice?

=93=85,
so that "diff -p" does not confuse labels with functions.
=85=94


> doesn't really reflect the majority of kernel practice we have in-tree to=
day and
> actually rather adds more confusion than any clarification whatsoever:
>=20
>   $ git grep -n "^\ [a-z_]*:" -- '*.[ch]' | wc -l
>   4919
>   $ git grep -n "^[a-z_]*:" -- '*.[ch]' | wc -l
>   54686

So there is a mixture already.


> A CodingStyle document should document what's regarded as a general conse=
nsus of
> kernel coding practices, and thus should represent the /majority/ of codi=
ng style,
> which (if I didn't screw up my git-grep line completely)

1. Is the used character class specification complete in the shown regular =
expression?

2. I guess that you should use the regex operator "plus" (instead of the as=
terisk).

3. Would you like to try another source code analysis out which can be a bi=
t safer
   with the usage of the semantic patch language?


> above 9% does not really reflect at all.

How tolerant are you for using an extra space character before the identifi=
er for
a jump label?


> So, new folks starting with kernel hacking reading this are rather misgui=
ded,
> and code-wise it just adds up to have more inconsistencies from new patch=
es,
> or worse, have noisy patches (like this one) flying around that try to
> brute-force everything into this advice.

In which ways would you prefer that the style specifications should be
clarified further?

Where should source code become more consistent?

Regards,
Markus
