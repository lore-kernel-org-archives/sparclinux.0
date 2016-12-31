From: Andy Lutomirski <luto@amacapital.net>
Date: Sat, 31 Dec 2016 01:36:31 +0000
Subject: Re: [RFC 1/4] mm: remove unused TASK_SIZE_OF()
Message-Id: <CALCETrVsjDqWpF2E4gZKMx4EEFHLYSR+AOX_3BcV3FNPe13pkg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20161230155634.8692-1-dsafonov@virtuozzo.com>
 <20161230155634.8692-2-dsafonov@virtuozzo.com>
In-Reply-To: <20161230155634.8692-2-dsafonov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Dec 30, 2016 at 7:56 AM, Dmitry Safonov <dsafonov@virtuozzo.com> wrote:
> All users of TASK_SIZE_OF(tsk) have migrated to mm->task_size or
> TASK_SIZE_MAX since:
> commit d696ca016d57 ("x86/fsgsbase/64: Use TASK_SIZE_MAX for
> FSBASE/GSBASE upper limits"),
> commit a06db751c321 ("pagemap: check permissions and capabilities at
> open time"),

I like this.

Reviewed-by: Andy Lutomirski <luto@kernel.org> # for x86
