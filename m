From: Mark Farnell <mark.farnell@gmail.com>
Date: Sat, 11 Apr 2009 23:24:30 +0000
Subject: getting the program counter from sparc64 under gcc/glibc linux
Message-Id: <aaf549e0904111624s386eb6dfm1401a5561dfdc2f1@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I am running a program which needs to determine whether a memory
access attempt is read or write.  This is intended to be achieved by a
SIGSEGV handler which gets the program counter by getting:

pc = ucontext_t.mcontext_t.mc_gregs[MC_PC]

Then I tried to get the instruction by dereferencing the pc and
bit-test the instruction to get the memory.

Here is the source code for the program:

#include <errno.h>
#if 0
#include <siginfo.h>
#endif
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <ucontext.h>
#include <unistd.h>

#define is_load_or_store(inst) \
        (((inst) >> 30) = 3)

#define is_store(inst) \
        (is_load_or_store(inst) && \
         ((0xC0F0 >> (((inst) >> 19) & 0xF)) & 1) != 0)

static void my_segv_action(int signo, siginfo_t *info, void *dummy) {
  ucontext_t *uc = dummy;

#if 0
  greg_t pc = uc->uc_mcontext.gregs[REG_PC];
#endif
  mc_greg_t pc = uc->uc_mcontext.mc_gregs[MC_PC];


  unsigned long inst = *(unsigned long const *)pc;

  if (is_load_or_store(inst)) {
    if (is_store(inst)) {
      write(2, "It is a store.\n", 15);
    } else {
      write(2, "It is a load.\n", 14);
    }
  } else {
    write(2, "It is neither.\n", 15);
  }
  fprintf(stderr, "Address = %p, instruction = %08x\n", pc, inst);
#if 0
  psiginfo(info, "my_segv_action");
#endif
  abort();
}


int main(void) {
  struct sigaction New_Action;
  struct sigaction Old_Action;
  char *p = 0;

  New_Action.sa_handler = 0;
  New_Action.sa_sigaction = my_segv_action;
  (void)sigemptyset(&New_Action.sa_mask);
  New_Action.sa_flags = SA_SIGINFO | SA_RESETHAND;

#if 1
  if (sigaction(SIGSEGV, &New_Action, &Old_Action) != 0) {
    perror("sigaction");
    return EXIT_FAILURE;
  }
#endif
  (*p) = 77;          /* write attempt */
  return EXIT_SUCCESS;
}


However in the SIGSEGV handler, gdb tells me that
uc->uc_mcontext.mc_gregs[MC_PC] is 0   (MC_PC is 1)

How can I get the program counter which points to the instruction that
causes the write-segmentation fault under GNU/Linux SPARC64?

Thanks!

Mark
