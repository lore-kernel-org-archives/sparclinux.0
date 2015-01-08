From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 08 Jan 2015 01:17:56 +0000
Subject: Re: [PATCH 2/3] module: remove mod arg from module_free, rename module_memfree().
Message-Id: <CAADnVQK0oM6U6qNuBn7H-DZHTdxzYjGrP2M7dvaOrdHztRw1eQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1420678687-30548-3-git-send-email-rusty@rustcorp.com.au>
In-Reply-To: <1420678687-30548-3-git-send-email-rusty@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Ralf Baechle <ralf@linux-mips.org>, Ley Foon Tan <lftan@altera.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Chris Metcalf <cmetcalf@ezchip.com>, Steven Rostedt <rostedt@goodmis.org>, "x86@kernel.org" <x86@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, linux-cris-kernel@axis.com, linux-mips <linux-mips@linux-mips.org>, nios2-dev@lists.rocketboards.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>

On Wed, Jan 7, 2015 at 4:58 PM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
>  void bpf_jit_binary_free(struct bpf_binary_header *hdr)
>  {
> -       module_free(NULL, hdr);
> +       module_memfree(hdr);
>  }
...
> -void __weak module_free(struct module *mod, void *module_region)
> +void __weak module_memfree(void *module_region)
>  {
>         vfree(module_region);
>  }

Looks obviously correct.
Acked-by: Alexei Starovoitov <ast@kernel.org>
