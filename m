From: Peter Zijlstra <peterz@infradead.org>
Date: Mon, 05 Sep 2016 11:58:38 +0000
Subject: Re: sparc: bpf_jit: Rename jump labels in bpf_jit_compile()
Message-Id: <20160905115838.GC10153@twins.programming.kicks-ass.net>
List-Id: <sparclinux.vger.kernel.org>
References: <57CAFFDC.4030606@iogearbox.net>
 <20160903.230607.1667562673788737377.davem@davemloft.net>
 <1365a588-c7c7-717c-1e3d-ceabd71e8479@users.sourceforge.net>
 <20160903.235916.1892276070318494855.davem@davemloft.net>
 <deecaab4-011b-b8d5-a3c7-6e34abef60e5@users.sourceforge.net>
 <57CBEFEA.3080007@iogearbox.net>
 <20160905130737.74f63abe@endymion>
 <20160905113704.GA10153@twins.programming.kicks-ass.net>
 <20160905135445.501814a1@endymion>
In-Reply-To: <20160905135445.501814a1@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <jdelvare@suse.de>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Jonathan Corbet <corbet@lwn.net>, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, Adam Buchbinder <adam.buchbinder@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Rabin Vincent <rabin@rab.in>, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>, linux-doc@vger.kernel.org

On Mon, Sep 05, 2016 at 01:54:45PM +0200, Jean Delvare wrote:
> On Mon, 5 Sep 2016 13:37:04 +0200, Peter Zijlstra wrote:
> > On Mon, Sep 05, 2016 at 01:07:37PM +0200, Jean Delvare wrote:
> > > Now I see in http://patchwork.ozlabs.org/patch/664966/ that Peter
> > > Zijlstra reportedly changed the behavior of "diff -p" so that it
> > > handles unindented C labels nicely. If this actually happens, it could
> > > change my point of view. However I can't find this commit in upstream
> > > diffutils. Peter, can you please clarify the situation? Is it just a
> > > local hack on your own instance of "diff"?
> > 
> > I have it in my local .gitconfig, and recommend it to people who send me
> > patches.
> 
> What does it look like, please?

[diff "default"]
        xfuncname = "^[[:alpha:]$_].*[^:]$"
[core]
	abbrev = 12
[alias]
	one = show -s --pretty='format:%h (\"%s\")'
[rerere]
	enable = true
	enabled = true
	autoupdate = true

