From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 05 Jan 2017 17:54:30 +0000
Subject: Re: [RFC 1/4] mm: remove unused TASK_SIZE_OF()
Message-Id: <CALCETrXUB8AeEzJ-WtW3kW9c189AcOe+GBq8TE7GPE+xrvXS8g@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20161230155634.8692-1-dsafonov@virtuozzo.com>
 <20161230155634.8692-2-dsafonov@virtuozzo.com>
 <063D6719AE5E284EB5DD2968C1650D6DB0258289@AcuExch.aculab.com>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DB0258289@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Jan 5, 2017 at 1:51 AM, David Laight <David.Laight@aculab.com> wrote:
> From: Dmitry Safonov
>> Sent: 30 December 2016 15:57
>> All users of TASK_SIZE_OF(tsk) have migrated to mm->task_size or
>> TASK_SIZE_MAX since:
>> commit d696ca016d57 ("x86/fsgsbase/64: Use TASK_SIZE_MAX for
>> FSBASE/GSBASE upper limits"),
>> commit a06db751c321 ("pagemap: check permissions and capabilities at
>> open time"),
> ...
>> +#define TASK_SIZE            (current->thread.task_size)
>
> I'm not sure I like he hidden 'current' argument to an
> apparent constant.

Me neither.  But this patch is merely changing the implementation.
