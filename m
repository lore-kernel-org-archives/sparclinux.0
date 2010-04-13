From: David Miller <davem@davemloft.net>
Date: Tue, 13 Apr 2010 21:34:54 +0000
Subject: Re: [PATCH 7/7] sparc64: Add function graph tracer support.
Message-Id: <20100413.143454.214910028.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100412.234300.212396783.davem@davemloft.net>
In-Reply-To: <20100412.234300.212396783.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Rostedt <rostedt@goodmis.org>
Date: Tue, 13 Apr 2010 15:39:21 -0400

>> Works very well :)
>>
>> 63)               |  do_sparc64_fault() {
>> 63)   6.153 us    |    down_read_trylock();
>> 63)   5.164 us    |    find_vma();
>> 63)               |    handle_mm_fault() {
>> 63)   2.966 us    |      add_preempt_count();
>> 63)   2.856 us    |      sub_preempt_count();
>> 63)               |      _raw_spin_lock() {
>> 63)   2.857 us    |        add_preempt_count();
>> 63)   3.076 us    |        add_preempt_count();
>> 63)   2.527 us    |        sub_preempt_count();
>> 63) + 23.513 us   |      }
>>
> 
> I just had to comment on the CPU count.
> 
> Nice ;-)

Neener, neener:

 101)               |          run_local_timers() {
 115) + 24.063 us   |            raise_softirq();
  69)               |          run_local_timers() {
  85) + 23.623 us   |            hrtimer_run_queues();
 103)               |          run_local_timers() {
  66) + 71.749 us   |          }
  91)               |          run_local_timers() {
 106) + 23.184 us   |            raise_softirq();
  65) + 29.117 us   |            raise_softirq();
  68) + 23.843 us   |            hrtimer_run_queues();
 112) + 23.623 us   |            hrtimer_run_queues();
 105) + 24.063 us   |            hrtimer_run_queues();
  17) + 25.161 us   |            raise_softirq();
  82) + 24.282 us   |            hrtimer_run_queues();
 100) + 72.628 us   |          }

BTW, one thing that drives me nuts on this machine is that catting the
'trace' file takes several seconds to start up.  Is it calling
stop_machine() or something else which very expensive with high cpu
counts?
