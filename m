From: Ilya Malakhov <ilmalakhovthefirst@gmail.com>
Date: Mon, 15 Feb 2016 09:21:51 +0000
Subject: Invalid SIGSEGV from sparc64_set_context ()
Message-Id: <CAK1sNPDEk0x4mdOfma97EyAkiBAuKc10dC-hhqb3XWSkWw=SZw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

 Hi.

 There seems to be a rather transparent bug in `sparc64_set_context ()':


$ cat ./arch/sparc/kernel/signal_64.c
. . .
asmlinkage void sparc64_set_context(struct pt_regs *regs)
{
. . .
        flush_user_windows();
        if (get_thread_wsaved()                    ||
. . .
           )
                goto do_sigsegv;
. . .

 It would make a process get an invalid SIGSEGV if, for a example, a
"fast_data_access" exception were to happen while spilling window registers
to a previously untouched page of the stack. I wonder if `synchronize_user
_stack ()' should be used in place of `flush_user_windows ()' here to ensure
that the registers are actually spilled to memory and thus successfully proceed
with setcontext.

 The situation described above is sure to happen when running the following
64-bit test (note the use of `-static' to prevent the window registers in `f ()'
from being occasionally flushed while resolving a reference to `longjmp ()'
lazily at runtime):

$ sparc64-linux-gcc -m64 ./test.c -o ./test.64 -static

sparc64 $ ./test.64
Segmentation fault

$ cat ./test.c

#include <setjmp.h>

static jmp_buf env;
static int f (int) __attribute__ ((noinline));

static int
f (int j)
{
  volatile char arr[8192];

  if (j != 0)
    longjmp (env, 17);

  arr[0] = 0;
  return arr[0];
}

int jmp = 1;

int
main ()
{
  int res;

  res = setjmp (env);
  if (res = 0)
    return  f (jmp);
  else if (res != 17)
    return 1;

  return 0;
}
