From: Peter Hurley <peter@hurleysoftware.com>
Date: Mon, 18 Nov 2013 12:41:11 +0000
Subject: Re: RED state exception (trap type 0x64) on U5 reboot
Message-Id: <528A0AE7.3020803@hurleysoftware.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1310151347070.902@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1310151347070.902@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 11/18/2013 01:21 AM, Meelis Roos wrote:
>> This patch seems to switch ldata with its read_buf and echo_buf from
>> kmalloc/kfree to vmalloc/vfree (the bufs are now inlined in ldata, not
>> separately allocated).
>>
>> More fields in ldata are now explicitly initialized to zero instead of
>> kzalloc doing it before. However, I do not see the initialization of
>> some of the fields - maybe they are done later in the code? I noticed
>> process_char_map, raw, real_raw, icanon, read_buf, echo_buf that were
>> zeroed before but I did not find explicit zeroing of them after the
>> patch. However, just adding a memset to zero ldata after vmalloc does
>> not change anything.
>>
>> Openpromfs does not seem to be changed after 3.11 and it does not seem
>> to use any tty layer functions.
>>
>> I still have no idea how it would interact.
>
> I turned off most imaginable debug options - pagealloc, kobject, lockdep
> and kmemcheck among others. Lockdep got one on still working kernel,
> with the state just at the bad commit, on shutdown:
>
> ===========================
> [ INFO: possible circular locking dependency detected ]
> 3.11.0-rc2-00058-g20bafb3-dirty #121 Tainted: G        W
> -------------------------------------------------------
> bash/2383 is trying to acquire lock:
>   (&tty->termios_rwsem){++++.+}, at: [<0000000000633648>] n_tty_read+0x368/0x620
>
> but task is already holding lock:
>   (&ldata->atomic_read_lock){+.+.+.}, at: [<000000000063343c>] n_tty_read+0x15c/0x620
>
> which lock already depends on the new lock.

This is a false positive lockdep report that was fixed
with commit aefceaf453024ef4cf8a0f93c4b1edf6c6f748bf,
'n_tty: Fix termios_rwsem lockdep false positive', which
was added in 3.12-rc3.

>   [00000000004060b4] linux_sparc_syscall32+0x34/0x40
>
> This is UP machine so the race probably did not happen?

Even on SMP there is no race (and thus no deadlock) because
the CPU holding the termios_rwsem has a read lock and thus
cannot prevent the other CPU from also acquiring a read lock
while holding the atomic_read_lock.

Regards,
Peter Hurley


