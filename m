From: Eric Botcazou <ebotcazou@libertysurf.fr>
Date: Fri, 23 Jun 2017 19:18:56 +0000
Subject: Re: sparc gcc 7.1 compile issue
Message-Id: <1983988.jzTnvLsH9s@polaris>
List-Id: <sparclinux.vger.kernel.org>
References: <20170531193431.GA26922@waldemar-brodkorb.de>
In-Reply-To: <20170531193431.GA26922@waldemar-brodkorb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Unaligned stack accesses, which is what I can gather was going on looking
> at your fix, could point to a myriad of areas where bugs could live.
> 
> If somehow the stack pointer itself got misaligned, we could be looking
> at a window spill/fill bug or similar.
> 
> I'll try to see if I can figure out what might have gone wrong.  It could
> simply be a bug in the unaligned memory access trap handler.

I don't think it's that simple, but I'm no specialist.  What happened for the 
testcases I looked at and which hung is that the cilk+ scheduler "stole" some 
work (cilk+ terminology) of the main thread, which means that it spawned a 
second thread and did some low-level fiddling with the stack and the likes to 
connect it to the main thread.  But, because of the bug, this second thread 
died while the main thread was busy waiting for it, so the whole thing hung.

Things start to go awry in the kernel when you have a sufficiently large 
number of these hung testcases spinning at the same time; if the parallelism 
level is low and given that DejaGNU kills them after 300s, they can't pile up.

-- 
Eric Botcazou
