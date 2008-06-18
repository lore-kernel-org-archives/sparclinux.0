From: Mikulas Patocka <mpatocka@redhat.com>
Date: Wed, 18 Jun 2008 00:47:57 +0000
Subject: stack overflow on Sparc64
Message-Id: <Pine.LNX.4.64.0806171954060.2560@engineering.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alasdair G Kergon <agk@redhat.com>

Hi

I am getting stack overflows on my Sparc64 station. They happen when I 
copy to device-mapper snapshot origin device using small IO size (512 
bytes) and simultaneously execute "lvs" command. The kernel is compiled 
with most debugging functions enabled. The stack trace is this:

__ide_end_request
__blk_end_request
__end_that_request_first
req_bio_endio
bio_endio
clone_endio
dec_pending
bio_endio
clone_endio
dec_pending
bio_endio
clone_endio
dec_pending
bio_endio
end_bio_bh_io_sync
end_buffer_read_sync
__end_buffer_read_notouch
unlock_buffer
wake_up_bit
__wake_up_bit
__wake_up
__wake_up_common
wake_bit_function
autoremove_wake_function
default_wake_function
try_to_wake_up
task_rq_lock
__spin_lock
lock_acquire
__lock_acquire
*** crash, stack overflow

--- observations:

That loop bio_endio->clone_endio->dec_pending is repeating for each level 
of nested devices --- so for any architecture there exists a level at 
which it causes trouble. We need something to prevent recursion, maybe the 
similar trick that was done with avoing bio request function recursion 
(i.e. if bio_endio is called recursively, it just adds the bio to queue 
and lets the top level to call endio method).

Wait queue waking looks like being written by a high-level maniac --- it 
contains 8 levels of calls (none of them inlined). 7 of these calls (until 
try_to_wake_up) do nothing but pass arguments to lower level call. And 
each of these calls allocate at least 192 bytes of stack space. All these 
7 useless calls consume 1360 bytes of stack (and cause windows traps that 
needlessly damage performance). Would you agree to inline most of the 
calls to save stack? Or do you see another solution?

Long-term consideration: Is it possible to implement interrupt stacks on 
sparc64? Functions on sparc eat stack much more aggressively than on other 
architectures (minimum stack size for a function is 192 bytes).

Mikulas
