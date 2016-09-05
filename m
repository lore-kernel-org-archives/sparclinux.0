From: Jean Delvare <jdelvare@suse.de>
Date: Mon, 05 Sep 2016 11:54:45 +0000
Subject: Re: sparc: bpf_jit: Rename jump labels in bpf_jit_compile()
Message-Id: <20160905135445.501814a1@endymion>
List-Id: <sparclinux.vger.kernel.org>
References: <57CAFFDC.4030606@iogearbox.net>
        <20160903.230607.1667562673788737377.davem@davemloft.net>
        <1365a588-c7c7-717c-1e3d-ceabd71e8479@users.sourceforge.net>
        <20160903.235916.1892276070318494855.davem@davemloft.net>
        <deecaab4-011b-b8d5-a3c7-6e34abef60e5@users.sourceforge.net>
        <57CBEFEA.3080007@iogearbox.net>
        <20160905130737.74f63abe@endymion>
        <20160905113704.GA10153@twins.programming.kicks-ass.net>
In-Reply-To: <20160905113704.GA10153@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Jonathan Corbet <corbet@lwn.net>, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, Adam Buchbinder <adam.buchbinder@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Rabin Vincent <rabin@rab.in>, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>, linux-doc@vger.kernel.org

On Mon, 5 Sep 2016 13:37:04 +0200, Peter Zijlstra wrote:
> On Mon, Sep 05, 2016 at 01:07:37PM +0200, Jean Delvare wrote:
> > Now I see in http://patchwork.ozlabs.org/patch/664966/ that Peter
> > Zijlstra reportedly changed the behavior of "diff -p" so that it
> > handles unindented C labels nicely. If this actually happens, it could
> > change my point of view. However I can't find this commit in upstream
> > diffutils. Peter, can you please clarify the situation? Is it just a
> > local hack on your own instance of "diff"?
> 
> I have it in my local .gitconfig, and recommend it to people who send me
> patches.

What does it look like, please?

> I've never tried to get diffutils fixed, although maybe I should.

If you don't want one-space-indented labels to become the norm, then
yes you should.

-- 
Jean Delvare
SUSE L3 Support
