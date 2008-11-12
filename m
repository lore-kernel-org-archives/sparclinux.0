From: "Alexander Beregalov" <a.beregalov@gmail.com>
Date: Wed, 12 Nov 2008 14:13:14 +0000
Subject: Re: [PATCH] sparc64: add function save_stack_trace_tsk()
Message-Id: <a4423d670811120613p79a365d8se7a8ccf1afb005e8@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20081112134749.GD12456@orion>
In-Reply-To: <20081112134749.GD12456@orion>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, sparclinux@vger.kernel.org, linux-next@vger.kernel.org, kenchen@google.com, mingo@elte.hu, adobriyan@gmail.com

2008/11/12 Alexander Beregalov <a.beregalov@gmail.com>:
> Hi
>
> Current -next does not build on sparc64:
>  LD      .tmp_vmlinux1
>  fs/built-in.o: In function `proc_pid_stack':
>  /home/alexb/linux-2.6/fs/proc/base.c:360: undefined reference to
>  `save_stack_trace_tsk'
>
> ---
>
>  Add function save_stack_trace_tsk() on sparc64.
>
>
> Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
> ---
No, it does not work, it is not so simple.
