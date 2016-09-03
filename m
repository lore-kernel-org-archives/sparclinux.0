From: Daniel Borkmann <daniel@iogearbox.net>
Date: Sat, 03 Sep 2016 16:58:12 +0000
Subject: Re: [PATCH 3/4] sparc: bpf_jit: Avoid assignment for "flen" if BPF JIT is disabled
Message-Id: <57CB0124.1040605@iogearbox.net>
List-Id: <sparclinux.vger.kernel.org>
References: <566ABCD9.1060404@users.sourceforge.net> <ab4a20b2-16be-c3b2-58a7-fe7db39ab559@users.sourceforge.net> <2bd51cac-bbb7-da76-9648-4ae24ba342b2@users.sourceforge.net>
In-Reply-To: <2bd51cac-bbb7-da76-9648-4ae24ba342b2@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>, sparclinux@vger.kernel.org, Adam Buchbinder <adam.buchbinder@gmail.com>, Alexei Starovoitov <ast@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rabin Vincent <rabin@rab.in>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>

On 09/03/2016 06:40 PM, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 3 Sep 2016 18:00:03 +0200
>
> Move the assignment for the local variable "flen" a bit at the beginning
> so that it will only be performed if BPF JIT is enabled for this function.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Why is that a particular issue (did you measure some improvement when
you say "fine-tuning" as per subject) ?

That's all not in critical path here by the way, same for patch 2.
