From: William Lee Irwin III <wli@holomorphy.com>
Date: Sat, 10 Mar 2007 08:26:46 +0000
Subject: Re: [PATCH] Fix sparc TIF_USEDFPU flag atomicity
Message-Id: <20070310082646.GC2994@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20070310081743.GC23144@Krystal>
In-Reply-To: <20070310081743.GC23144@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: akpm@linux-foundation.org, mbligh@google.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Sat, Mar 10, 2007 at 03:17:43AM -0500, Mathieu Desnoyers wrote:
> @@ -348,7 +348,7 @@ void exit_thread(void)
>  #ifndef CONFIG_SMP
>  	if(last_task_used_math = current) {
>  #else
> -	if(current_thread_info()->flags & _TIF_USEDFPU) {
> +	if(test_ti_thread_flag(current_thread_info(), TIF_USEDFPU)) {
>  #endif
>  		/* Keep process from leaving FPU in a bogon state. */
>  		put_psr(get_psr() | PSR_EF);

Oh dear. Could we bit a bit more idiomatic here? For instance,
something like:

Index: linux-2.6/arch/sparc/kernel/process.c
=================================--- linux-2.6.orig/arch/sparc/kernel/process.c	2007-03-09 23:24:12.934472032 -0800
+++ linux-2.6/arch/sparc/kernel/process.c	2007-03-09 23:29:26.592346376 -0800
@@ -348,7 +348,7 @@
 #ifndef CONFIG_SMP
 	if(last_task_used_math = current) {
 #else
-	if(current_thread_info()->flags & _TIF_USEDFPU) {
+	if (test_thread_flag(TIF_USEDFPU)) {
 #endif
 		/* Keep process from leaving FPU in a bogon state. */
 		put_psr(get_psr() | PSR_EF);
@@ -357,7 +357,7 @@
 #ifndef CONFIG_SMP
 		last_task_used_math = NULL;
 #else
-		current_thread_info()->flags &= ~_TIF_USEDFPU;
+		clear_thread_flag(TIF_USEDFPU);
 #endif
 	}
 }
@@ -371,7 +371,7 @@
 #ifndef CONFIG_SMP
 	if(last_task_used_math = current) {
 #else
-	if(current_thread_info()->flags & _TIF_USEDFPU) {
+	if (test_thread_flag(TIF_USEDFPU)) {
 #endif
 		/* Clean the fpu. */
 		put_psr(get_psr() | PSR_EF);
@@ -380,7 +380,7 @@
 #ifndef CONFIG_SMP
 		last_task_used_math = NULL;
 #else
-		current_thread_info()->flags &= ~_TIF_USEDFPU;
+		clear_thread_flag(TIF_USEDFPU);
 #endif
 	}
 
@@ -466,13 +466,13 @@
 #ifndef CONFIG_SMP
 	if(last_task_used_math = current) {
 #else
-	if(current_thread_info()->flags & _TIF_USEDFPU) {
+	if (test_thread_flag(TIF_USEDFPU)) {
 #endif
 		put_psr(get_psr() | PSR_EF);
 		fpsave(&p->thread.float_regs[0], &p->thread.fsr,
 		       &p->thread.fpqueue[0], &p->thread.fpqdepth);
 #ifdef CONFIG_SMP
-		current_thread_info()->flags &= ~_TIF_USEDFPU;
+		clear_thread_flag(TIF_USEDFPU);
 #endif
 	}
 
@@ -609,13 +609,13 @@
 		return 1;
 	}
 #ifdef CONFIG_SMP
-	if (current_thread_info()->flags & _TIF_USEDFPU) {
+	if (test_thread_flag(TIF_USEDFPU)) {
 		put_psr(get_psr() | PSR_EF);
 		fpsave(&current->thread.float_regs[0], &current->thread.fsr,
 		       &current->thread.fpqueue[0], &current->thread.fpqdepth);
 		if (regs != NULL) {
 			regs->psr &= ~(PSR_EF);
-			current_thread_info()->flags &= ~(_TIF_USEDFPU);
+			clear_thread_flag(TIF_USEDFPU);
 		}
 	}
 #else
Index: linux-2.6/arch/sparc/kernel/traps.c
=================================--- linux-2.6.orig/arch/sparc/kernel/traps.c	2007-03-09 23:40:33.994379450 -0800
+++ linux-2.6/arch/sparc/kernel/traps.c	2007-03-09 23:44:07.910569839 -0800
@@ -259,7 +259,7 @@
 	} else {
 		fpload(&current->thread.float_regs[0], &current->thread.fsr);
 	}
-	current_thread_info()->flags |= _TIF_USEDFPU;
+	set_thread_flag(TIF_USEDFPU);
 #endif
 }
 
@@ -290,7 +290,7 @@
 #ifndef CONFIG_SMP
 	if(!fpt) {
 #else
-        if(!(task_thread_info(fpt)->flags & _TIF_USEDFPU)) {
+	if (!test_tsk_thread_flag(fpt, TIF_USEDFPU)) {
 #endif
 		fpsave(&fake_regs[0], &fake_fsr, &fake_queue[0], &fake_depth);
 		regs->psr &= ~PSR_EF;
@@ -333,7 +333,7 @@
 	/* nope, better SIGFPE the offending process... */
 	       
 #ifdef CONFIG_SMP
-	task_thread_info(fpt)->flags &= ~_TIF_USEDFPU;
+	clear_tsk_thread_flag(fpt, TIF_USEDFPU);
 #endif
 	if(psr & PSR_PS) {
 		/* The first fsr store/load we tried trapped,
