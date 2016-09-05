From: Jean Delvare <jdelvare@suse.de>
Date: Mon, 05 Sep 2016 11:07:37 +0000
Subject: Re: sparc: bpf_jit: Rename jump labels in bpf_jit_compile()
Message-Id: <20160905130737.74f63abe@endymion>
List-Id: <sparclinux.vger.kernel.org>
References: <57CAFFDC.4030606@iogearbox.net>
        <20160903.230607.1667562673788737377.davem@davemloft.net>
        <1365a588-c7c7-717c-1e3d-ceabd71e8479@users.sourceforge.net>
        <20160903.235916.1892276070318494855.davem@davemloft.net>
        <deecaab4-011b-b8d5-a3c7-6e34abef60e5@users.sourceforge.net>
        <57CBEFEA.3080007@iogearbox.net>
In-Reply-To: <57CBEFEA.3080007@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, Adam Buchbinder <adam.buchbinder@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Rabin Vincent <rabin@rab.in>, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>, linux-doc@vger.kernel.org

Hi Daniel,

Preliminary note: the SNR of Markus Elfring is incredibly low. I advise
you just ignore him.

On Sun, 04 Sep 2016 11:56:58 +0200, Daniel Borkmann wrote:
> I don't want to drag this thread onwards for (way) too long, but clearly "it is
> advised to indent labels with a single space (not tab)" (from diff in above commit)
> doesn't really reflect the majority of kernel practice we have in-tree today and
> actually rather adds more confusion than any clarification whatsoever:
> 
>    $ git grep -n "^\ [a-z_]*:" -- '*.[ch]' | wc -l
>    4919
>    $ git grep -n "^[a-z_]*:" -- '*.[ch]' | wc -l
>    54686

Well the documentation update in question has not hit mainline yet, so
it's not really surprising.

> A CodingStyle document should document what's regarded as a general consensus of
> kernel coding practices, and thus should represent the /majority/ of coding style,

I beg to disagree. Recommendations are not meant to document what
people are currently doing but what we think they should be doing. By
your reasoning, we would have killed all the devm infrastructure,
because at some point in time (and it might still be the case) most
drivers were not using it.

There is a rationale for the leading space, it is given in the patch,
but sadly you decided to not quote it above.

> which (if I didn't screw up my git-grep line completely) above 9% does not really
> reflect at all. So, new folks starting with kernel hacking reading this are rather

Your grep patterns are slightly inaccurate. Space doesn't need to be
escaped, labels can use capital letters, and except for the first
character, digits are accepted too. Also to be completely fair, you
should also count the labels which are intended using tabs. But it
doesn't change the balance noticeably anyway, so no big deal.

> misguided, and code-wise it just adds up to have more inconsistencies from new
> patches, or worse, have noisy patches (like this one) flying around that try to
> brute-force everything into this advice.

Guys who like to waste our time with pointless patches will always find
a way to do that, sadly, so I don't think this point is relevant.

The acceptance of an optional single space before labels dates back to
at least June 2007, as supported by the very first incarnation of
checkpatch.pl. So nothing really new here, except for a preference
(my preference, admittedly, but I'm know I'm not alone) being expressed
in the coding style document.

My assumption was that the behavior of "diff -p" would never change, as
despite the language-specificity of its long option name, it seemed too
generic to be loaded with C-specific rules.

Now I see in http://patchwork.ozlabs.org/patch/664966/ that Peter
Zijlstra reportedly changed the behavior of "diff -p" so that it
handles unindented C labels nicely. If this actually happens, it could
change my point of view. However I can't find this commit in upstream
diffutils. Peter, can you please clarify the situation? Is it just a
local hack on your own instance of "diff"?

Even if upstream diff is ever changed, it will take some time until new
versions propagate to all developers. And until this happens, my
preference for one-space-indented labels will remain.

Also git has its own implementation of "diff", so any change in the
behavior of GNU diff's -p and/or --show-c-function options should be
reflected there as well for consistency.

-- 
Jean Delvare
SUSE L3 Support
