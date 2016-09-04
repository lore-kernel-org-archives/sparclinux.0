From: Daniel Borkmann <daniel@iogearbox.net>
Date: Sun, 04 Sep 2016 09:56:58 +0000
Subject: Re: sparc: bpf_jit: Rename jump labels in bpf_jit_compile()
Message-Id: <57CBEFEA.3080007@iogearbox.net>
List-Id: <sparclinux.vger.kernel.org>
References: <57CAFFDC.4030606@iogearbox.net> <20160903.230607.1667562673788737377.davem@davemloft.net> <1365a588-c7c7-717c-1e3d-ceabd71e8479@users.sourceforge.net> <20160903.235916.1892276070318494855.davem@davemloft.net> <deecaab4-011b-b8d5-a3c7-6e34abef60e5@users.sourceforge.net>
In-Reply-To: <deecaab4-011b-b8d5-a3c7-6e34abef60e5@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Jonathan Corbet <corbet@lwn.net>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, Adam Buchbinder <adam.buchbinder@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Rabin Vincent <rabin@rab.in>, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>, linux-doc@vger.kernel.org, Jean Delvare <jdelvare@suse.de>

On 09/04/2016 09:20 AM, SF Markus Elfring wrote:
>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit=
/Documentation/CodingStyle?id=865a1caa4b6b886babdd9d67e7c3608be4567a51

[ + Jonathan for above commit in linux-next ]

>> You seem to lack understanding of the difference between absolute
>> requirements and "advice".
>>
>> As Sparc maintainer I can choose to not take this "advice",
>> and I so choose to do so.
>
> Your conclusion can be fine in principle.
>
> I am just curious on how much further software development "fun" the rece=
nt update
> by a topic like "CodingStyle: Clarify and complete chapter 7" will trigge=
r.

I don't want to drag this thread onwards for (way) too long, but clearly "i=
t is
advised to indent labels with a single space (not tab)" (from diff in above=
 commit)
doesn't really reflect the majority of kernel practice we have in-tree toda=
y and
actually rather adds more confusion than any clarification whatsoever:

   $ git grep -n "^\ [a-z_]*:" -- '*.[ch]' | wc -l
   4919
   $ git grep -n "^[a-z_]*:" -- '*.[ch]' | wc -l
   54686

A CodingStyle document should document what's regarded as a general consens=
us of
kernel coding practices, and thus should represent the /majority/ of coding=
 style,
which (if I didn't screw up my git-grep line completely) above 9% does not =
really
reflect at all. So, new folks starting with kernel hacking reading this are=
 rather
misguided, and code-wise it just adds up to have more inconsistencies from =
new
patches, or worse, have noisy patches (like this one) flying around that tr=
y to
brute-force everything into this advice.
