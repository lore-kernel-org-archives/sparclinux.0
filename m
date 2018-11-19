From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 19 Nov 2018 15:37:39 +0000
Subject: Re: [PATCH 1/4] bpf: account for freed JIT allocations in arch code
Message-Id: <CAKv+Gu8mo+WkJ356wByidUDoA-xHrUH99od5N_yJoqtX_28_5g@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20181117185715.25198-1-ard.biesheuvel@linaro.org>
 <20181117185715.25198-2-ard.biesheuvel@linaro.org>
 <b37c3411-7950-dcb3-f0c3-6d9f589d36ab@iogearbox.net>
In-Reply-To: <b37c3411-7950-dcb3-f0c3-6d9f589d36ab@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, 19 Nov 2018 at 02:37, Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 11/17/2018 07:57 PM, Ard Biesheuvel wrote:
> > Commit ede95a63b5e84 ("bpf: add bpf_jit_limit knob to restrict unpriv
> > allocations") added a call to bpf_jit_uncharge_modmem() to the routine
> > bpf_jit_binary_free() which is called from the __weak bpf_jit_free().
> > This function is overridden by arches, some of which do not call
> > bpf_jit_binary_free() to release the memory, and so the released
> > memory is not accounted for, potentially leading to spurious allocation
> > failures.
> >
> > So replace the direct calls to module_memfree() in the arch code with
> > calls to bpf_jit_binary_free().
>
> Sorry but this patch is completely buggy, and above description on the
> accounting incorrect as well. Looks like this patch was not tested at all.
>

My apologies. I went off into the weeds a bit looking at different
versions for 32-bit and 64-bit on different architectures. So indeed,
this patch should be dropped.

> The below cBPF JITs that use module_memfree() which you replace with
> bpf_jit_binary_free() are using module_alloc() internally to get the JIT
> image buffer ...
>

Indeed. So would you prefer for arm64 to override bpf_jit_free() in
its entirety, and not call bpf_jit_binary_free() but simply call
bpf_jit_uncharge_modmem() and vfree() directly? It's either that, or
we'd have to untangle this a bit, to avoid having one __weak function
on top of the other just so other arches can replace the
module_memfree() call in bpf_jit_binary_free() with vfree() (which
amount to the same thing on arm64 anyway)
