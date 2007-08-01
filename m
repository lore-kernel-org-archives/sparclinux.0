From: David Miller <davem@davemloft.net>
Date: Wed, 01 Aug 2007 01:42:50 +0000
Subject: Fw: [RESEND] [BUG] futex_unlock_pi() hurts my brain and may cause
Message-Id: <20070731.184250.71089148.davem@davemloft.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--Next_Part(Tue_Jul_31_18_42_50_2007_680)--"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

----Next_Part(Tue_Jul_31_18_42_50_2007_680)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


This FUTEX fix just got posted and the symptoms of the bug it fixes
matches the issue that we've been working on here.

Can you folks give this patch a try?

Thanks!

----Next_Part(Tue_Jul_31_18_42_50_2007_680)--
Content-Type: Message/Rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Return-Path: <davem@vger.kernel.org>
X-Original-To: davem@sunset.davemloft.net
Delivered-To: davem@sunset.davemloft.net
Received: from vger.kernel.org (vger.kernel.org [209.132.176.167])
	by sunset.davemloft.net (Postfix) with ESMTP id D315C29010A
	for <davem@sunset.davemloft.net>; Tue, 31 Jul 2007 16:54:06 -0700 (PDT)
Received: (from localhost user: 'davem' uid#2109 fake: STDIN
	(davem@vger.kernel.org)) by vger.kernel.org id S1763598AbXGaXxw
	(ORCPT <rfc822;davem@sunset.davemloft.net>);
	Tue, 31 Jul 2007 19:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763590AbXGaXxv (ORCPT <rfc822;davem@davemloft.net>);
	Tue, 31 Jul 2007 19:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756356AbXGaXxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jul 2007 19:53:43 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:39429 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756270AbXGaXxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jul 2007 19:53:42 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6VNrfsA008901
	for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2007 19:53:41 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l6VNrfso489806
	for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2007 19:53:41 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6VNre6g032094
	for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2007 19:53:41 -0400
Received: from [9.47.21.16] (cog.beaverton.ibm.com [9.47.21.16])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id l6VNrdrJ032085;
	Tue, 31 Jul 2007 19:53:40 -0400
Subject: [RESEND] [BUG] futex_unlock_pi() hurts my brain and may cause
	application deadlock
From: john stultz <johnstul@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sripathi Kodi <sripathik@in.ibm.com>
In-Reply-To: <1180572567.6126.44.camel@localhost.localdomain>
References: <1180572567.6126.44.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 31 Jul 2007 16:53:39 -0700
Message-Id: <1185926019.8850.198.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.10.1 
Content-Transfer-Encoding: 7bit
Sender: "David S. Miller" <davem@vger.kernel.org>
Fake-Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2007-05-30 at 17:49 -0700, john stultz wrote:
> All,
> 	So we've been seeing PI mutex deadlocks with a few of our applications
> using the -rt kernel. After narrowing things down, we were finding that
> the applications were indirectly calling futex_unlock_pi(), which on
> occasion would return -EFAULT, which is promptly ignored by glibc. This
> would cause the application to continue on as if it has unlocked the
> mutex, until it tried to reacquire it and deadlock.
> 
> In looking into why the kernel was returning -EFAULT, I found the
> following:
> 
> ...
> retry_locked:
> 	/*
> 	 * To avoid races, try to do the TID -> 0 atomic transition
> 	 * again. If it succeeds then we can return without waking
> 	 * anyone else up:
> 	 */
> 	if (!(uval & FUTEX_OWNER_DIED)) {
> 		pagefault_disable();
> 		uval = futex_atomic_cmpxchg_inatomic(uaddr, current->pid, 0);
> 		pagefault_enable();
> 	}
> 
> 	if (unlikely(uval == -EFAULT))
> 		goto pi_faulted;
> ...[snip]...
> pi_faulted:
> 	/*
> 	 * We have to r/w  *(int __user *)uaddr, but we can't modify it
> 	 * non-atomically.  Therefore, if get_user below is not
> 	 * enough, we need to handle the fault ourselves, while
> 	 * still holding the mmap_sem.
> 	 */
> 	if (attempt++) {
> 		ret = futex_handle_fault((unsigned long)uaddr, fshared,
> 					 attempt);
> 		if (ret)
> 			goto out_unlock;
> 		goto retry_locked;
> 	}
> 
> 
> Should we fault through normal causes, on the second round we call
> futex_handle_fault, which faults in the address, and we then jump back
> to retry_locked. However, since uval is -EFAULT from the last cmpxchg,
> it &s w/ FUTEX_OWNER_DIED so we don't enter the first conditional to try
> to cmpxchg again. So since uval is still -EFAULT, we loop back to
> pi_faulted! This will loop until futex_handle_fault() bombs out because
> attempt is too big and we return -EFAULT.
> 
> I *think* this is a possible quick fix here, but I'm no futex guru, so I
> wanted to run it by folks for review.
> 
> Big thanks to Sripathi and Angela Lin for helping debug this, and Steven
> for suggesting a cleaner fix then what I first tried.


Hey Ingo,
	I sent this fix for this back in the 2.6.21-rt9 era, and I thought to
picked it up, but I think it arrived amid some futex churn and
apparently has been dropped or was just lost.

Some of our testers have been reporting futex deadlocks and this fix
resolves it, so I believe it to still be needed.

thanks
-john

Avoid futex_unlock_pi returning -EFAULT (which results in deadlock), by
clearing uval before jumping to retry_locked.

Signed-off-by: John Stultz <johnstul@us.ibm.com>
Index: 2.6-rt/kernel/futex.c
===================================================================
--- 2.6-rt.orig/kernel/futex.c	2007-07-31 16:48:41.000000000 -0700
+++ 2.6-rt/kernel/futex.c	2007-07-31 16:48:48.000000000 -0700
@@ -1673,6 +1673,7 @@ pi_faulted:
 					 attempt);
 		if (ret)
 			goto out;
+		uval = 0;
 		goto retry_unlocked;
 	}
 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----Next_Part(Tue_Jul_31_18_42_50_2007_680)----
