From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Date: Fri, 09 Mar 2007 02:38:14 +0000
Subject: [PATCH] Fix atomicity of TIF update in flush_thread() for sparc64
Message-Id: <20070309023814.GA9462@Krystal>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org, mbligh@google.com, linux-kernel@vger.kernel.org, davem@davemloft.net, sparclinux@vger.kernel.org

Fix atomicity of TIF update in flush_thread() for x86_64

Race :

parent process executing :
sys_ptrace()
 (lock_kernel())
 (ptrace_get_task_struct(pid))
 arch_ptrace()
   ptrace_detach()
     ptrace_disable(child);
       clear_singlestep(child);
         clear_tsk_thread_flag(child, TIF_SINGLESTEP);
         (which clears the TIF_SINGLESTEP flag atomically from a different
	  process)
 (put_task_struct(child))
 (unlock_kernel())

And at the same time, in the child process :
sys_execve()
 do_execve()
   search_binary_handler()
     load_elf_binary()
       flush_old_exec()
         flush_thread()
           doing a non-atomic thread flag update 

It applies on 2.6.20.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--- a/arch/sparc64/kernel/process.c
+++ b/arch/sparc64/kernel/process.c
@@ -413,8 +413,13 @@ void flush_thread(void)
 	struct thread_info *t = current_thread_info();
 	struct mm_struct *mm;
 
-	if (t->flags & _TIF_ABI_PENDING)
-		t->flags ^= (_TIF_ABI_PENDING | _TIF_32BIT);
+	if (test_tsk_thread_flag(tsk, TIF_ABI_PENDING)) {
+		clear_tsk_thread_flag(tsk, TIF_ABI_PENDING);
+		if (test_tsk_thread_flag(tsk, TIF_32BIT))
+			clear_tsk_thread_flag(tsk, TIF_32BIT);
+		else
+			set_tsk_thread_flag(tsk, TIF_32BIT);
+	}
 
 	mm = t->task->mm;
 	if (mm)
-- 
Mathieu Desnoyers
Computer Engineering Ph.D. Student, Ecole Polytechnique de Montreal
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
